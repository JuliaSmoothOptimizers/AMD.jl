function amd_order(n, Ap, Ai, P, Control, Info)
  @ccall libamd.amd_order(n::Cint, Ap::Ptr{Cint}, Ai::Ptr{Cint}, P::Ptr{Cint},
                          Control::Ptr{Cdouble}, Info::Ptr{Cdouble})::Cint
end

function amd_l_order(n, Ap, Ai, P, Control, Info)
  @ccall libamd.amd_l_order(n::Int64, Ap::Ptr{Int64}, Ai::Ptr{Int64}, P::Ptr{Int64},
                            Control::Ptr{Cdouble}, Info::Ptr{Cdouble})::Int64
end

function amd_2(n, Pe, Iw, Len, iwlen, pfree, Nv, Next, Last, Head, Elen, Degree, W, Control, Info)
  @ccall libamd.amd_2(n::Cint, Pe::Ptr{Cint}, Iw::Ptr{Cint}, Len::Ptr{Cint}, iwlen::Cint,
                      pfree::Cint, Nv::Ptr{Cint}, Next::Ptr{Cint}, Last::Ptr{Cint}, Head::Ptr{Cint},
                      Elen::Ptr{Cint}, Degree::Ptr{Cint}, W::Ptr{Cint}, Control::Ptr{Cdouble},
                      Info::Ptr{Cdouble})::Cvoid
end

function amd_l2(n, Pe, Iw, Len, iwlen, pfree, Nv, Next, Last, Head, Elen, Degree, W, Control, Info)
  @ccall libamd.amd_l2(n::Int64, Pe::Ptr{Int64}, Iw::Ptr{Int64}, Len::Ptr{Int64}, iwlen::Int64,
                       pfree::Int64, Nv::Ptr{Int64}, Next::Ptr{Int64}, Last::Ptr{Int64},
                       Head::Ptr{Int64}, Elen::Ptr{Int64}, Degree::Ptr{Int64}, W::Ptr{Int64},
                       Control::Ptr{Cdouble}, Info::Ptr{Cdouble})::Cvoid
end

function amd_valid(n_row, n_col, Ap, Ai)
  @ccall libamd.amd_valid(n_row::Cint, n_col::Cint, Ap::Ptr{Cint}, Ai::Ptr{Cint})::Cint
end

function amd_l_valid(n_row, n_col, Ap, Ai)
  @ccall libamd.amd_l_valid(n_row::Int64, n_col::Int64, Ap::Ptr{Int64}, Ai::Ptr{Int64})::Int64
end

function amd_defaults(Control)
  @ccall libamd.amd_defaults(Control::Ptr{Cdouble})::Cvoid
end

function amd_l_defaults(Control)
  @ccall libamd.amd_l_defaults(Control::Ptr{Cdouble})::Cvoid
end

function amd_control(Control)
  @ccall libamd.amd_control(Control::Ptr{Cdouble})::Cvoid
end

function amd_l_control(Control)
  @ccall libamd.amd_l_control(Control::Ptr{Cdouble})::Cvoid
end

function amd_info(Info)
  @ccall libamd.amd_info(Info::Ptr{Cdouble})::Cvoid
end

function amd_l_info(Info)
  @ccall libamd.amd_l_info(Info::Ptr{Cdouble})::Cvoid
end

const AMD_CONTROL = 5
const AMD_INFO = 20
const AMD_DENSE = 0
const AMD_AGGRESSIVE = 1
const AMD_DEFAULT_DENSE = 10.0
const AMD_DEFAULT_AGGRESSIVE = 1
const AMD_STATUS = 0
const AMD_N = 1
const AMD_NZ = 2
const AMD_SYMMETRY = 3
const AMD_NZDIAG = 4
const AMD_NZ_A_PLUS_AT = 5
const AMD_NDENSE = 6
const AMD_MEMORY = 7
const AMD_NCMPA = 8
const AMD_LNZ = 9
const AMD_NDIV = 10
const AMD_NMULTSUBS_LDL = 11
const AMD_NMULTSUBS_LU = 12
const AMD_DMAX = 13
const AMD_OK = 0
const AMD_OUT_OF_MEMORY = -1
const AMD_INVALID = -2
const AMD_OK_BUT_JUMBLED = 1
