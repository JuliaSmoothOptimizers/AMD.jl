module AMD

using SparseArrays

export Amd, amd_valid, amd
export AMD_DENSE, AMD_AGGRESSIVE
export AMD_STATUS, AMD_N, AMD_NZ, AMD_SYMMETRY, AMD_NZDIAG,
       AMD_NZ_A_PLUS_AT, AMD_NDENSE, AMD_MEMORY, AMD_NCMPA,
       AMD_LNZ, AMD_NDIV, AMD_NMULTSUBS_LDL, AMD_NMULTSUBS_LU,
       AMD_DMAX
export AMD_OK, AMD_OUT_OF_MEMORY, AMD_INVALID, AMD_OK_BUT_JUMBLED

const AMD_CONTROL = 5  # size of control array
const AMD_INFO = 20    # size of info array

# Indices in control array.
const AMD_DENSE = 1
const AMD_AGGRESSIVE = 2

# Indices in info array.
const AMD_STATUS = 1          # return value of amd_order
const AMD_N = 2               # size of A
const AMD_NZ = 3              # number of nonzeros in A
const AMD_SYMMETRY = 4        # pattern symmetry (1 = symmetric, 0 = unsymmetric)
const AMD_NZDIAG = 5          # number of entries on diagonal
const AMD_NZ_A_PLUS_AT = 6    # number of nonzeros in A+A'
const AMD_NDENSE = 7          # number of "dense" rows or cols in A
const AMD_MEMORY = 8          # amount of memory used by AMD
const AMD_NCMPA = 9           # number of garbage collections in AMD
const AMD_LNZ = 10            # approximate number of nonzeros in factor, excluding diagonal
const AMD_NDIV = 11           # number of floating point divides for LU and LDL'
const AMD_NMULTSUBS_LDL = 12  # number of floating point (*,-) pairs for LDL'
const AMD_NMULTSUBS_LU = 13   # number of floating point (*,-) pairs for LU
const AMD_DMAX = 14           # max nonzeros in any column of factor, including diagonal

# Return codes.
const AMD_OK = 0              # success
const AMD_OUT_OF_MEMORY = -1  # malloc failed or problem too large
const AMD_INVALID = -2        # input arguments not valid
const AMD_OK_BUT_JUMBLED = 1  # input ok but AMD will need to perform extra work

const statuses = Dict(AMD_OK => "ok",
                      AMD_OUT_OF_MEMORY => "out of memory",
                      AMD_INVALID => "input invalid",
                      AMD_OK_BUT_JUMBLED => "ok but jumbled",
                     )

include("amd_functions.jl")

"""Base type to hold control and information related to a call to AMD.
`control` is a vector of C doubles with components:

* d = control[AMD_DENSE]: rows with more than max(d√n, 16) entries are
considered "dense" and appear last in the permutation. If d < 0 no
row will be treated as dense.

* control[AMD_AGGRESSIVE]: triggers aggressive absorption if nonzero.

`info` is a vector of C doubles that contains statistics on the ordering.
"""
mutable struct Amd
  control :: Vector{Cdouble}
  info :: Vector{Cdouble}

  function Amd()
    control = zeros(Cdouble, AMD_CONTROL)
    info = zeros(Cdouble, AMD_INFO)
    ccall(_amd_defaults, Nothing, (Ptr{Cdouble},), control)
    return new(control, info)
  end
end

import Base.show, Base.print

function show(io :: IO, meta :: Amd)
  s  = "Control:\n"
  s *= "  dense row parameter: $(meta.control[AMD_DENSE])\n"
  s *= "  aggressive absorption: $(meta.control[AMD_AGGRESSIVE])\n"
  s *= "Info:\n"
  s *= "  status: $(statuses[meta.info[AMD_STATUS]])\n"
  s *= "  number of nonzeros in A + A': $(meta.info[AMD_NZ_A_PLUS_AT])\n"
  s *= "  number of dense columns: $(meta.info[AMD_NDENSE])\n"
  s *= "  memory used: $(meta.info[AMD_MEMORY])\n"
  s *= "  approx number of nonzeros in factor: $(meta.info[AMD_LNZ])\n"
  s *= "  max nonzeros in any column of factor: $(meta.info[AMD_DMAX])\n"
  print(io, s)
end

function print(io :: IO, meta :: Amd)
  s  = "Control:\n"
  s *= "  dense row parameter: $(meta.control[AMD_DENSE])\n"
  s *= "  aggressive absorption: $(meta.control[AMD_AGGRESSIVE])\n"
  s *= "Info:\n"
  s *= "  status: $(statuses[meta.info[AMD_STATUS]])\n"
  s *= "  matrix size: $(meta.info[AMD_N])\n"
  s *= "  number of nonzeros: $(meta.info[AMD_NZ])\n"
  s *= "  pattern symmetry: $(meta.info[AMD_SYMMETRY])\n"
  s *= "  number of nonzeros on diagonal: $(meta.info[AMD_NZDIAG])\n"
  s *= "  number of nonzeros in A + A': $(meta.info[AMD_NZ_A_PLUS_AT])\n"
  s *= "  number of dense columns: $(meta.info[AMD_NDENSE])\n"
  s *= "  memory used: $(meta.info[AMD_MEMORY])\n"
  s *= "  number of garbage collections: $(meta.info[AMD_NCMPA])\n"
  s *= "  approx number of nonzers in factor: $(meta.info[AMD_LNZ])\n"
  s *= "  number of float divides: $(meta.info[AMD_NDIV])\n"
  s *= "  number of float * or - for LDL: $(meta.info[AMD_NMULTSUBS_LDL])\n"
  s *= "  number of float * or - for LU: $(meta.info[AMD_NMULTSUBS_LU])\n"
  s *= "  max nonzeros in any column of factor: $(meta.info[AMD_DMAX])\n"
  print(io, s)
end

_Clong = Base.Sys.WORD_SIZE == 32 ? Clong : Clonglong

for (validfn, typ) in ((:_amd_valid, Cint), (:_amd_l_valid, _Clong))

  @eval begin

    function amd_valid(A :: SparseMatrixCSC{F,$typ}) where F
      nrow, ncol = size(A)
      colptr = A.colptr .- $typ(1)  # 0-based indexing
      rowval = A.rowval .- $typ(1)
      valid = ccall($validfn, $typ,
                    ($typ, $typ, Ptr{$typ}, Ptr{$typ}), nrow, ncol, colptr, rowval)
      return valid == AMD_OK || valid == AMD_OK_BUT_JUMBLED
    end

  end
end


for (orderfn, typ) in ((:_amd_order, Cint), (:_amd_l_order, _Clong))

  @eval begin

    function amd(A::SparseMatrixCSC{F,$typ}, meta::Amd) where F
      nrow, ncol = size(A)
      nrow == ncol || error("AMD: input matrix must be square")
      colptr = A.colptr .- $typ(1)  # 0-based indexing
      rowval = A.rowval .- $typ(1)

      p = zeros($typ, nrow)
      valid = ccall($orderfn, $typ,
                    ($typ, Ref{$typ}, Ref{$typ}, Ptr{$typ}, Ptr{Cdouble}, Ptr{Cdouble}),
                     nrow, colptr,    rowval,    p,         meta.control, meta.info)
      (valid == AMD_OK || valid == AMD_OK_BUT_JUMBLED) || throw("amd_order returns: $(statuses[valid])")
      p .+= 1
      return p
    end

  end
end

function amd(A :: SparseMatrixCSC{F,T}) where {F,T<:Union{Cint,_Clong}}
  meta = Amd()
  amd(A, meta)
end

"""
    amd(A, meta)

or

    amd(A)

Given a sparse matrix `A` and an `Amd` structure `meta`, `p = amd(A, meta)`
computes the approximate minimum degree ordering of `A + A'`. The ordering is
represented as a permutation vector `p`. Factorizations of `A[p,p]` tend to
be sparser than those of `A`.

The matrix `A` must be square and the sparsity pattern of `A + A'` is implicit.
Thus it is convenient to represent symmetric matrices using one triangle only.
The diagonal of `A` may be present but will be ignored.

The ordering may be influenced by changing `meta.control[AMD_DENSE]` and
`meta.control[AMD_AGGRESSIVE]`.

Statistics on the ordering appear in `meta.info`.
"""
amd

end # module
