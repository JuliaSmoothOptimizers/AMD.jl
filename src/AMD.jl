module AMD

using LinearAlgebra
using SparseArrays
using SuiteSparse_jll

import Base.show, Base.print

# Julia counterpart of `SuiteSparse_long`, the integer type of the `*_l` entry
# points, which is `int64_t` on every platform since SuiteSparse 6.
const SS_Int = Int64

include("wrappers/amd.jl")
include("wrappers/camd.jl")
include("wrappers/colamd.jl")
include("wrappers/ccolamd.jl")

include("amd_julia.jl")
include("colamd_julia.jl")

end # module
