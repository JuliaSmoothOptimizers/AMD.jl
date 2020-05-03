export Colamd, colamd, symamd

const COLAMD_KNOBS = 20  # size of the knobs array
const COLAMD_STATS = 20  # size of the stats array

# Indices in the knobs and stats arrays.
const COLAMD_DENSE_ROW = 1
const COLAMD_DENSE_COL = 2
const COLAMD_AGGRESSIVE = 3
const COLAMD_DEFRAG_COUNT = 3
const COLAMD_STATUS = 4
const COLAMD_INFO1 = 5
const COLAMD_INFO2 = 6
const COLAMD_INFO3 = 7

#Return codes.
const COLAMD_OK = 0
const COLAMD_OK_BUT_JUMBLED = 1
const COLAMD_ERROR_A_not_present = -1
const COLAMD_ERROR_p_not_present = -2
const COLAMD_ERROR_nrow_negative = -3
const COLAMD_ERROR_ncol_negative = -4
const COLAMD_ERROR_nnz_negative = -5
const COLAMD_ERROR_p0_nonzero = -6
const COLAMD_ERROR_A_too_small = -7
const COLAMD_ERROR_col_length_negative = -8
const COLAMD_ERROR_row_index_out_of_bounds = -9
const COLAMD_ERROR_out_of_memory = -10
const COLAMD_ERROR_internal_error = -999

const colamd_statuses = Dict(COLAMD_OK => "ok",
                             COLAMD_OK_BUT_JUMBLED => "ok, but columns of input matrix were jumbled (unsorted columns or duplicate entries)",
                             COLAMD_ERROR_A_not_present => "rowval is a null pointer",
                             COLAMD_ERROR_p_not_present => "colptr is a null pointer",
                             COLAMD_ERROR_nrow_negative => "nrow is negative",
                             COLAMD_ERROR_ncol_negative => "nccol is negative",
                             COLAMD_ERROR_nnz_negative => "number of nonzeros in matrix is negative",
                             COLAMD_ERROR_p0_nonzero => "p[0] is nonzero",
                             COLAMD_ERROR_A_too_small => "workspace is too small",
                             COLAMD_ERROR_col_length_negative => "a column has a negative number of entries",
                             COLAMD_ERROR_row_index_out_of_bounds => "a row index is out of bounds",
                             COLAMD_ERROR_out_of_memory => "out of memory",
                             COLAMD_ERROR_internal_error => "internal error",
                            )                         

mutable struct Colamd{T<:Union{Cint,_Clong}} 
  knobs :: Vector{Cdouble}
  stats :: Vector{T}

  function Colamd{T}() where T <: Union{Cint,_Clong}
    knobs = zeros(Cdouble, COLAMD_KNOBS)
    stats = zeros(T, COLAMD_STATS)
    ccall(_colamd_set_defaults, Nothing, (Ptr{Cdouble},), knobs)
    return new(knobs, stats)
  end
end

function show(io :: IO, meta :: Colamd)
  s  = "dense row parameter: $(meta.knobs[COLAMD_DENSE_ROW])\n"
  s *= "dense col parameter: $(meta.knobs[COLAMD_DENSE_COL])\n"
  s *= "aggressive absorption: $(meta.knobs[COLAMD_AGGRESSIVE])\n"
  s *= "memory defragmentation: $(meta.stats[COLAMD_DEFRAG_COUNT])\n"
  s *= "status: $(colamd_statuses[meta.stats[COLAMD_STATUS]])\n"
  print(io, s)
end

@inline print(io :: IO, meta :: Colamd) = show(io, meta)

for (fn, typ) in ((:_colamd_recommended, Cint), (:_colamd_l_recommended, _Clong))
  @eval begin
    function colamd_recommended(nnz::$typ, nrow::$typ, ncol::$typ)
      len = ccall($fn, $typ,
                  ($typ, $typ, $typ),
                   nnz , nrow, ncol)
      return len
    end
  end
end

for (orderfn, typ) in ((:_colamd, Cint), (:_colamd_l, _Clong))

  @eval begin

    function colamd(A::SparseMatrixCSC{F,$typ}, meta::Colamd{$typ}) where F
      nrow, ncol = size(A)
      nnz = A.colptr[end] - 1
      p = A.colptr .- $typ(1)  # 0-based indexing
      len = colamd_recommended($typ(nnz), $typ(nrow), $typ(ncol))
      workspace = zeros($typ, len)
      workspace[1:length(A.rowval)] .= A.rowval .- $typ(1)
      valid = ccall($orderfn, $typ,
                    ($typ, $typ, $typ, $Ptr{$typ}, Ptr{$typ}, Ptr{Cdouble},  Ptr{$typ}),
                     nrow, ncol,  len,  workspace,         p,   meta.knobs, meta.stats)
      Bool(valid) || throw("colamd status: $(colamd_statuses[meta.stats[COLAMD_STATUS]])")
      pop!(p)  # remove the number of nnz
      p .+= $typ(1)  # 1-based indexing
      return p
    end

    colamd(A :: Symmetric{F,SparseMatrixCSC{F,$typ}}, meta::Colamd{$typ}) where F = colamd(A.data, meta)

  end
end

function colamd(A :: SparseMatrixCSC{F,T}) where {F,T<:Union{Cint,_Clong}}
  meta = Colamd{T}()
  colamd(A, meta)
end

@inline colamd(A :: Symmetric{F,SparseMatrixCSC{F,T}}) where {F,T<:Union{Cint,_Clong}} = colamd(A.data)

"""
    colamd(A, meta)

or

    colamd(A)

colamd computes a permutation vector `p` such that the Cholesky factorization of
  `A[:,p]' * A[:,p]` has less fill-in and requires fewer floating point operations than `AᵀA`.
"""
colamd

for (fn, typ) in ((:_symamd, Cint), (:_symamd_l, _Clong))

  @eval begin

    function symamd(A::SparseMatrixCSC{F,$typ}, meta::Colamd{$typ}) where F
      nrow, ncol = size(A)
      colptr = A.colptr .- $typ(1)  # 0-based indexing
      rowval = A.rowval .- $typ(1)
      p = zeros($typ, nrow+1) # p is used as a workspace during the ordering, which is why it must be of length n+1, not just n
      valid = ccall($fn, $typ,
                    ($typ, Ref{$typ}, Ref{$typ}, Ptr{$typ}, Ptr{Cdouble},  Ptr{$typ},                                   Ptr{Cvoid},                           Ptr{Cvoid}),
                     nrow,    rowval,    colptr,         p,   meta.knobs, meta.stats, @cfunction(calloc, Ptr{Cvoid}, ($typ, $typ)), @cfunction(free, Cvoid, (Ptr{Cvoid},)))
      Bool(valid) || throw("symamd status: $(colamd_statuses[meta.stats[COLAMD_STATUS]])")
      pop!(p)
      p .+= $typ(1)  # 1-based indexing
      return p
    end

    symamd(A :: Symmetric{F,SparseMatrixCSC{F,$typ}}, meta::Colamd{$typ}) where F = symamd(A.data, meta)

  end
end

function symamd(A :: SparseMatrixCSC{F,T}) where {F,T<:Union{Cint,_Clong}}
  meta = Colamd{T}()
  symamd(A, meta)
end

@inline symamd(A :: Symmetric{F,SparseMatrixCSC{F,T}}) where {F,T<:Union{Cint,_Clong}} = symamd(A.data)

"""
    symamd(A, meta)

or

    symamd(A)

Given a symmetric matrix `A`, symamd computes a permutation vector `p`
such that the Cholesky factorization of `A[p,p]` has less fill-in and
requires fewer floating point operations than that of A.
"""
symamd
