# AMD

[![Build Status](https://travis-ci.org/JuliaSmoothOptimizers/AMD.jl.svg?branch=master)](https://travis-ci.org/JuliaSmoothOptimizers/AMD.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/6wrr7rwl7qpox3ny/branch/master?svg=true)](https://ci.appveyor.com/project/JuliaSmoothOptimizers/amd-jl/branch/master)
[![codecov.io](https://codecov.io/github/JuliaSmoothOptimizers/AMD.jl/coverage.svg?branch=master)](https://codecov.io/github/JuliaSmoothOptimizers/AMD.jl?branch=master)

Given a square sparse matrix, compute an approximate minimum degree ordering.
This package is an interface to the AMD library of Amestoy, Davis and Duff.

### Installing

```JULIA
Pkg.add("AMD")
Pkg.test("AMD")
```

### Example

In the simplest case:

```JULIA
julia> using AMD
julia> A = sprand(10, 10, .5);
julia> p = amd(A);
```

If statistics on the permutation are of interest and/or for changing the
default control parameters:

```JULIA
julia> meta = Amd{Clong}();  # because A's index type is Int64 on my platform
julia> # optionally change meta.control: ?Amd
julia> p = amd(A, meta)
julia> print(meta)
Control:
  dense row parameter: 10.0
  aggressive absorption: 1.0
Info:
  status: ok
  matrix size: 10.0
  number of nonzeros: 54.0
  pattern symmetry: 0.5
  number of nonzeros on diagonal: 6.0
  number of nonzeros in A + A': 72.0
  number of dense columns: 0.0
  memory used: 1408.0
  number of garbage collections: 0.0
  approx number of nonzers in factor: 38.0
  number of float divides: 38.0
  number of float * or - for LDL: 114.0
  number of float * or - for LU: 190.0
  max nonzeros in any column of factor: 8.0
```

AMD computes a fill-reducing permutation based on the sparsity pattern of A +
Aᵀ. The input pattern can be anything: diagonal entries will be ignored and the
rest will be used to implicitly work on the pattern of A + Aᵀ. Thus if A is
symmetric, it is sufficient to supply the strict lower or upper triangle only.

### References

1. P. R. Amestoy, T. A. Davis and I. S. Duff. An Approximate Minimum Degree
   Ordering Algorithm. *SIAM Journal on Matrix Analysis and Applications*, 17(4),
   pp. 886&ndash;905, 1996.
   Doi [10.1137/S0895479894278952](http://dx.doi.org/10.1137/S0895479894278952)
2. P. R. Amestoy, T. A. Davis, and I. S. Duff. Algorithm 837: An approximate
   minimum degree ordering algorithm. *ACM Transactions on Mathematical
   Software*, 30(3), pp. 381&ndash;388, 2004.
   Doi [10.1145/1024074.1024081](http://dx.doi.org/10.1145/1024074.1024081)
