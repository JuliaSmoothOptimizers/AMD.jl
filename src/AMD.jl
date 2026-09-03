module AMD

using LinearAlgebra
using SparseArrays
using SuiteSparse_jll

import Base.show, Base.print

# Julia counterpart of `SuiteSparse_long`, the integer type of the `*_l` entrypoints.
# SuiteSparse >= 6 fixes it to `int64_t` while SuiteSparse <= 5 uses C `long`, which
# is 32 bits on 32-bit platforms.
# Every Julia release without `pkgversion` ships SuiteSparse 5.
const SS_Int = if isdefined(Base, :pkgversion) && pkgversion(SuiteSparse_jll) >= v"6"
  Int64
else
  Base.Sys.WORD_SIZE == 32 ? Int32 : Int64
end

include("wrappers/amd.jl")
include("wrappers/camd.jl")
include("wrappers/colamd.jl")
include("wrappers/ccolamd.jl")

include("amd_julia.jl")
include("colamd_julia.jl")

end # module
