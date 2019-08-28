using LinearAlgebra
using SparseArrays
using Test

using AMD

_Clong = Base.Sys.WORD_SIZE == 32 ? Clong : Clonglong
for n in [10, 20, 30]
  for density in [.25, .75, 1.0]
    for T in [Cint, _Clong]
      A = convert(SparseMatrixCSC{Float64,T}, sprand(n, n, density))
      @test amd_valid(A)

      meta = Amd()
      p = amd(A, meta)
      @test meta.info[AMD_STATUS] == AMD_OK
      @test minimum(p) == 1
      @test maximum(p) == n

      q = amd(A)
      @test all(p .== q)

      # test that amd(A) with A unsymmetric is amd(A + A')
      A = A + A'
      pA = amd(A)

      L = Symmetric(A, :L)
      pL = amd(L)
      @test all(pA .== pL)

      U = Symmetric(A, :U)
      pU = amd(U)
      @test all(pA .== pU)
    end
  end
end

# For coverage.
meta = Amd()
A = convert(SparseMatrixCSC{Float64,_Clong}, sprand(10, 10, .5))
p = amd(A, meta)
show(meta)
print(meta)
