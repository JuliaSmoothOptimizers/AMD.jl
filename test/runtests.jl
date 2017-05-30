using AMD
using Base.Test

for n in [10, 20, 30]
  for density in [.25, .75, 1.0]
    for T in [Cint, Clong]
      A = convert(SparseMatrixCSC{Float64,T}, sprand(n, n, density))
      @assert amd_valid(A)

      meta = Amd()
      p = amd(A, meta)
      @assert meta.info[AMD_STATUS] == AMD_OK
      @assert minimum(p) == 1
      @assert maximum(p) == n

      q = amd(A)
      @assert p == q
    end
  end
end

# For coverage.
meta = Amd()
A = convert(SparseMatrixCSC{Float64,Clong}, sprand(10, 10, .5))
p = amd(A, meta)
show(meta)
print(meta)
