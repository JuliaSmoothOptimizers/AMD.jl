function ccolamd_recommended(nnz, n_row, n_col)
  @ccall libccolamd.ccolamd_recommended(nnz::Cint, n_row::Cint, n_col::Cint)::Csize_t
end

function ccolamd_l_recommended(nnz, n_row, n_col)
  @ccall libccolamd.ccolamd_l_recommended(nnz::Int64, n_row::Int64, n_col::Int64)::Csize_t
end

function ccolamd_set_defaults(knobs)
  @ccall libccolamd.ccolamd_set_defaults(knobs::Ptr{Cdouble})::Cvoid
end

function ccolamd_l_set_defaults(knobs)
  @ccall libccolamd.ccolamd_l_set_defaults(knobs::Ptr{Cdouble})::Cvoid
end

function ccolamd(n_row, n_col, Alen, A, p, knobs, stats, cmember)
  @ccall libccolamd.ccolamd(n_row::Cint, n_col::Cint, Alen::Cint, A::Ptr{Cint}, p::Ptr{Cint},
                            knobs::Ptr{Cdouble}, stats::Ptr{Cint}, cmember::Ptr{Cint})::Cint
end

function ccolamd_l(n_row, n_col, Alen, A, p, knobs, stats, cmember)
  @ccall libccolamd.ccolamd_l(n_row::Int64, n_col::Int64, Alen::Int64, A::Ptr{Int64}, p::Ptr{Int64},
                              knobs::Ptr{Cdouble}, stats::Ptr{Int64}, cmember::Ptr{Int64})::Int64
end

function csymamd(n, A, p, perm, knobs, stats, allocate, release, cmember, stype)
  @ccall libccolamd.csymamd(n::Cint, A::Ptr{Cint}, p::Ptr{Cint}, perm::Ptr{Cint},
                            knobs::Ptr{Cdouble}, stats::Ptr{Cint}, allocate::Ptr{Cvoid},
                            release::Ptr{Cvoid}, cmember::Ptr{Cint}, stype::Cint)::Cint
end

function csymamd_l(n, A, p, perm, knobs, stats, allocate, release, cmember, stype)
  @ccall libccolamd.csymamd_l(n::Int64, A::Ptr{Int64}, p::Ptr{Int64}, perm::Ptr{Int64},
                              knobs::Ptr{Cdouble}, stats::Ptr{Int64}, allocate::Ptr{Cvoid},
                              release::Ptr{Cvoid}, cmember::Ptr{Int64}, stype::Int64)::Int64
end

function ccolamd_report(stats)
  @ccall libccolamd.ccolamd_report(stats::Ptr{Cint})::Cvoid
end

function ccolamd_l_report(stats)
  @ccall libccolamd.ccolamd_l_report(stats::Ptr{Int64})::Cvoid
end

function csymamd_report(stats)
  @ccall libccolamd.csymamd_report(stats::Ptr{Cint})::Cvoid
end

function csymamd_l_report(stats)
  @ccall libccolamd.csymamd_l_report(stats::Ptr{Int64})::Cvoid
end

function ccolamd2(n_row, n_col, Alen, A, p, knobs, stats, Front_npivcol, Front_nrows, Front_ncols,
                  Front_parent, Front_cols, p_nfr, InFront, cmember)
  @ccall libccolamd.ccolamd2(n_row::Cint, n_col::Cint, Alen::Cint, A::Ptr{Cint}, p::Ptr{Cint},
                             knobs::Ptr{Cdouble}, stats::Ptr{Cint}, Front_npivcol::Ptr{Cint},
                             Front_nrows::Ptr{Cint}, Front_ncols::Ptr{Cint},
                             Front_parent::Ptr{Cint}, Front_cols::Ptr{Cint}, p_nfr::Ptr{Cint},
                             InFront::Ptr{Cint}, cmember::Ptr{Cint})::Cint
end

function ccolamd2_l(n_row, n_col, Alen, A, p, knobs, stats, Front_npivcol, Front_nrows, Front_ncols,
                    Front_parent, Front_cols, p_nfr, InFront, cmember)
  @ccall libccolamd.ccolamd2_l(n_row::Int64, n_col::Int64, Alen::Int64, A::Ptr{Int64},
                               p::Ptr{Int64}, knobs::Ptr{Cdouble}, stats::Ptr{Int64},
                               Front_npivcol::Ptr{Int64}, Front_nrows::Ptr{Int64},
                               Front_ncols::Ptr{Int64}, Front_parent::Ptr{Int64},
                               Front_cols::Ptr{Int64}, p_nfr::Ptr{Int64}, InFront::Ptr{Int64},
                               cmember::Ptr{Int64})::Int64
end

function ccolamd_apply_order(Front, Order, Temp, nn, nfr)
  @ccall libccolamd.ccolamd_apply_order(Front::Ptr{Cint}, Order::Ptr{Cint}, Temp::Ptr{Cint},
                                        nn::Cint, nfr::Cint)::Cvoid
end

function ccolamd_l_apply_order(Front, Order, Temp, nn, nfr)
  @ccall libccolamd.ccolamd_l_apply_order(Front::Ptr{Int64}, Order::Ptr{Int64}, Temp::Ptr{Int64},
                                          nn::Int64, nfr::Int64)::Cvoid
end

function ccolamd_fsize(nn, MaxFsize, Fnrows, Fncols, Parent, Npiv)
  @ccall libccolamd.ccolamd_fsize(nn::Cint, MaxFsize::Ptr{Cint}, Fnrows::Ptr{Cint},
                                  Fncols::Ptr{Cint}, Parent::Ptr{Cint}, Npiv::Ptr{Cint})::Cvoid
end

function ccolamd_l_fsize(nn, MaxFsize, Fnrows, Fncols, Parent, Npiv)
  @ccall libccolamd.ccolamd_l_fsize(nn::Int64, MaxFsize::Ptr{Int64}, Fnrows::Ptr{Int64},
                                    Fncols::Ptr{Int64}, Parent::Ptr{Int64}, Npiv::Ptr{Int64})::Cvoid
end

function ccolamd_postorder(nn, Parent, Npiv, Fsize, Order, Child, Sibling, Stack, Front_cols,
                           cmember)
  @ccall libccolamd.ccolamd_postorder(nn::Cint, Parent::Ptr{Cint}, Npiv::Ptr{Cint},
                                      Fsize::Ptr{Cint}, Order::Ptr{Cint}, Child::Ptr{Cint},
                                      Sibling::Ptr{Cint}, Stack::Ptr{Cint}, Front_cols::Ptr{Cint},
                                      cmember::Ptr{Cint})::Cvoid
end

function ccolamd_l_postorder(nn, Parent, Npiv, Fsize, Order, Child, Sibling, Stack, Front_cols,
                             cmember)
  @ccall libccolamd.ccolamd_l_postorder(nn::Int64, Parent::Ptr{Int64}, Npiv::Ptr{Int64},
                                        Fsize::Ptr{Int64}, Order::Ptr{Int64}, Child::Ptr{Int64},
                                        Sibling::Ptr{Int64}, Stack::Ptr{Int64},
                                        Front_cols::Ptr{Int64}, cmember::Ptr{Int64})::Cvoid
end

function ccolamd_post_tree(root, k, Child, Sibling, Order, Stack)
  @ccall libccolamd.ccolamd_post_tree(root::Cint, k::Cint, Child::Ptr{Cint}, Sibling::Ptr{Cint},
                                      Order::Ptr{Cint}, Stack::Ptr{Cint})::Cint
end

function ccolamd_l_post_tree(root, k, Child, Sibling, Order, Stack)
  @ccall libccolamd.ccolamd_l_post_tree(root::Int64, k::Int64, Child::Ptr{Int64},
                                        Sibling::Ptr{Int64}, Order::Ptr{Int64},
                                        Stack::Ptr{Int64})::Int64
end

const CCOLAMD_KNOBS = 20
const CCOLAMD_STATS = 20
const CCOLAMD_DENSE_ROW = 0
const CCOLAMD_DENSE_COL = 1
const CCOLAMD_AGGRESSIVE = 2
const CCOLAMD_LU = 3
const CCOLAMD_DEFRAG_COUNT = 2
const CCOLAMD_STATUS = 3
const CCOLAMD_INFO1 = 4
const CCOLAMD_INFO2 = 5
const CCOLAMD_INFO3 = 6
const CCOLAMD_EMPTY_ROW = 7
const CCOLAMD_EMPTY_COL = 8
const CCOLAMD_NEWLY_EMPTY_ROW = 9
const CCOLAMD_NEWLY_EMPTY_COL = 10
const CCOLAMD_OK = 0
const CCOLAMD_OK_BUT_JUMBLED = 1
const CCOLAMD_ERROR_A_not_present = -1
const CCOLAMD_ERROR_p_not_present = -2
const CCOLAMD_ERROR_nrow_negative = -3
const CCOLAMD_ERROR_ncol_negative = -4
const CCOLAMD_ERROR_nnz_negative = -5
const CCOLAMD_ERROR_p0_nonzero = -6
const CCOLAMD_ERROR_A_too_small = -7
const CCOLAMD_ERROR_col_length_negative = -8
const CCOLAMD_ERROR_row_index_out_of_bounds = -9
const CCOLAMD_ERROR_out_of_memory = -10
const CCOLAMD_ERROR_invalid_cmember = -11
const CCOLAMD_ERROR_internal_error = -999
