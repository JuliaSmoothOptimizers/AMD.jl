using AMD
using Base.Test

for n in [10, 20, 30]
  for density in [.25, .75, 1.0]
    for T in [Cint, Clong]
      A = convert(SparseMatrixCSC{Float64,T}, sprand(n, n, density))
      @assert amd_valid(A)

      meta = Amd{T}()
      p = amd(A, meta)
      @assert meta.info[AMD_STATUS] == AMD_OK
      @assert minimum(p) == 1
      @assert maximum(p) == n
    end
  end
end
