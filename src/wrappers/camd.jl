function camd_order(n, Ap, Ai, P, Control, Info, C)
  @ccall libcamd.camd_order(n::Cint, Ap::Ptr{Cint}, Ai::Ptr{Cint}, P::Ptr{Cint},
                            Control::Ptr{Cdouble}, Info::Ptr{Cdouble}, C::Ptr{Cint})::Cint
end

function camd_l_order(n, Ap, Ai, P, Control, Info, C)
  @ccall libcamd.camd_l_order(n::Int64, Ap::Ptr{Int64}, Ai::Ptr{Int64}, P::Ptr{Int64},
                              Control::Ptr{Cdouble}, Info::Ptr{Cdouble}, C::Ptr{Int64})::Int64
end

function camd_2(n, Pe, Iw, Len, iwlen, pfree, Nv, Next, Last, Head, Elen, Degree, W, Control, Info,
                C, BucketSet)
  @ccall libcamd.camd_2(n::Cint, Pe::Ptr{Cint}, Iw::Ptr{Cint}, Len::Ptr{Cint}, iwlen::Cint,
                        pfree::Cint, Nv::Ptr{Cint}, Next::Ptr{Cint}, Last::Ptr{Cint},
                        Head::Ptr{Cint}, Elen::Ptr{Cint}, Degree::Ptr{Cint}, W::Ptr{Cint},
                        Control::Ptr{Cdouble}, Info::Ptr{Cdouble}, C::Ptr{Cint},
                        BucketSet::Ptr{Cint})::Cvoid
end

function camd_l2(n, Pe, Iw, Len, iwlen, pfree, Nv, Next, Last, Head, Elen, Degree, W, Control, Info,
                 C, BucketSet)
  @ccall libcamd.camd_l2(n::Int64, Pe::Ptr{Int64}, Iw::Ptr{Int64}, Len::Ptr{Int64}, iwlen::Int64,
                         pfree::Int64, Nv::Ptr{Int64}, Next::Ptr{Int64}, Last::Ptr{Int64},
                         Head::Ptr{Int64}, Elen::Ptr{Int64}, Degree::Ptr{Int64}, W::Ptr{Int64},
                         Control::Ptr{Cdouble}, Info::Ptr{Cdouble}, C::Ptr{Int64},
                         BucketSet::Ptr{Int64})::Cvoid
end

function camd_valid(n_row, n_col, Ap, Ai)
  @ccall libcamd.camd_valid(n_row::Cint, n_col::Cint, Ap::Ptr{Cint}, Ai::Ptr{Cint})::Cint
end

function camd_l_valid(n_row, n_col, Ap, Ai)
  @ccall libcamd.camd_l_valid(n_row::Int64, n_col::Int64, Ap::Ptr{Int64}, Ai::Ptr{Int64})::Int64
end

function camd_cvalid(n, C)
  @ccall libcamd.camd_cvalid(n::Cint, C::Ptr{Cint})::Cint
end

function camd_l_cvalid(n, C)
  @ccall libcamd.camd_l_cvalid(n::Int64, C::Ptr{Int64})::Int64
end

function camd_defaults(Control)
  @ccall libcamd.camd_defaults(Control::Ptr{Cdouble})::Cvoid
end

function camd_l_defaults(Control)
  @ccall libcamd.camd_l_defaults(Control::Ptr{Cdouble})::Cvoid
end

function camd_control(Control)
  @ccall libcamd.camd_control(Control::Ptr{Cdouble})::Cvoid
end

function camd_l_control(Control)
  @ccall libcamd.camd_l_control(Control::Ptr{Cdouble})::Cvoid
end

function camd_info(Info)
  @ccall libcamd.camd_info(Info::Ptr{Cdouble})::Cvoid
end

function camd_l_info(Info)
  @ccall libcamd.camd_l_info(Info::Ptr{Cdouble})::Cvoid
end

const CAMD_CONTROL = 5
const CAMD_INFO = 20
const CAMD_DENSE = 0
const CAMD_AGGRESSIVE = 1
const CAMD_DEFAULT_DENSE = 10.0
const CAMD_DEFAULT_AGGRESSIVE = 1
const CAMD_STATUS = 0
const CAMD_N = 1
const CAMD_NZ = 2
const CAMD_SYMMETRY = 3
const CAMD_NZDIAG = 4
const CAMD_NZ_A_PLUS_AT = 5
const CAMD_NDENSE = 6
const CAMD_MEMORY = 7
const CAMD_NCMPA = 8
const CAMD_LNZ = 9
const CAMD_NDIV = 10
const CAMD_NMULTSUBS_LDL = 11
const CAMD_NMULTSUBS_LU = 12
const CAMD_DMAX = 13
const CAMD_OK = 0
const CAMD_OUT_OF_MEMORY = -1
const CAMD_INVALID = -2
const CAMD_OK_BUT_JUMBLED = 1
