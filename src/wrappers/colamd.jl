function colamd_recommended(nnz, n_row, n_col)
  @ccall libcolamd.colamd_recommended(nnz::Cint, n_row::Cint, n_col::Cint)::Csize_t
end

function colamd_l_recommended(nnz, n_row, n_col)
  @ccall libcolamd.colamd_l_recommended(nnz::Int64, n_row::Int64, n_col::Int64)::Csize_t
end

function colamd_set_defaults(knobs)
  @ccall libcolamd.colamd_set_defaults(knobs::Ptr{Cdouble})::Cvoid
end

function colamd_l_set_defaults(knobs)
  @ccall libcolamd.colamd_l_set_defaults(knobs::Ptr{Cdouble})::Cvoid
end

function colamd(n_row, n_col, Alen, A, p, knobs, stats)
  @ccall libcolamd.colamd(n_row::Cint, n_col::Cint, Alen::Cint, A::Ptr{Cint}, p::Ptr{Cint},
                          knobs::Ptr{Cdouble}, stats::Ptr{Cint})::Cint
end

function colamd_l(n_row, n_col, Alen, A, p, knobs, stats)
  @ccall libcolamd.colamd_l(n_row::Int64, n_col::Int64, Alen::Int64, A::Ptr{Int64}, p::Ptr{Int64},
                            knobs::Ptr{Cdouble}, stats::Ptr{Int64})::Int64
end

function symamd(n, A, p, perm, knobs, stats, allocate, release)
  @ccall libcolamd.symamd(n::Cint, A::Ptr{Cint}, p::Ptr{Cint}, perm::Ptr{Cint}, knobs::Ptr{Cdouble},
                          stats::Ptr{Cint}, allocate::Ptr{Cvoid}, release::Ptr{Cvoid})::Cint
end

function symamd_l(n, A, p, perm, knobs, stats, allocate, release)
  @ccall libcolamd.symamd_l(n::Int64, A::Ptr{Int64}, p::Ptr{Int64}, perm::Ptr{Int64},
                            knobs::Ptr{Cdouble}, stats::Ptr{Int64}, allocate::Ptr{Cvoid},
                            release::Ptr{Cvoid})::Int64
end

function colamd_report(stats)
  @ccall libcolamd.colamd_report(stats::Ptr{Cint})::Cvoid
end

function colamd_l_report(stats)
  @ccall libcolamd.colamd_l_report(stats::Ptr{Int64})::Cvoid
end

function symamd_report(stats)
  @ccall libcolamd.symamd_report(stats::Ptr{Cint})::Cvoid
end

function symamd_l_report(stats)
  @ccall libcolamd.symamd_l_report(stats::Ptr{Int64})::Cvoid
end

const COLAMD_KNOBS = 20
const COLAMD_STATS = 20
const COLAMD_DENSE_ROW = 0
const COLAMD_DENSE_COL = 1
const COLAMD_AGGRESSIVE = 2
const COLAMD_DEFRAG_COUNT = 2
const COLAMD_STATUS = 3
const COLAMD_INFO1 = 4
const COLAMD_INFO2 = 5
const COLAMD_INFO3 = 6
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
