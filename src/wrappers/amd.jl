function amd_order(n, Ap, Ai, P, Control, Info)
  @ccall libamd.amd_order(
    n::Int32,
    Ap::Ptr{Int32},
    Ai::Ptr{Int32},
    P::Ptr{Int32},
    Control::Ptr{Cdouble},
    Info::Ptr{Cdouble},
  )::Cint
end

function amd_l_order(n, Ap, Ai, P, Control, Info)
  @ccall libamd.amd_l_order(
    n::Int64,
    Ap::Ptr{Int64},
    Ai::Ptr{Int64},
    P::Ptr{Int64},
    Control::Ptr{Cdouble},
    Info::Ptr{Cdouble},
  )::Cint
end

function amd_2(n, Pe, Iw, Len, iwlen, pfree, Nv, Next, Last, Head, Elen, Degree, W, Control, Info)
  @ccall libamd.amd_2(
    n::Int32,
    Pe::Ptr{Int32},
    Iw::Ptr{Int32},
    Len::Ptr{Int32},
    iwlen::Int32,
    pfree::Int32,
    Nv::Ptr{Int32},
    Next::Ptr{Int32},
    Last::Ptr{Int32},
    Head::Ptr{Int32},
    Elen::Ptr{Int32},
    Degree::Ptr{Int32},
    W::Ptr{Int32},
    Control::Ptr{Cdouble},
    Info::Ptr{Cdouble},
  )::Cvoid
end

function amd_l2(n, Pe, Iw, Len, iwlen, pfree, Nv, Next, Last, Head, Elen, Degree, W, Control, Info)
  @ccall libamd.amd_l2(
    n::Int64,
    Pe::Ptr{Int64},
    Iw::Ptr{Int64},
    Len::Ptr{Int64},
    iwlen::Int64,
    pfree::Int64,
    Nv::Ptr{Int64},
    Next::Ptr{Int64},
    Last::Ptr{Int64},
    Head::Ptr{Int64},
    Elen::Ptr{Int64},
    Degree::Ptr{Int64},
    W::Ptr{Int64},
    Control::Ptr{Cdouble},
    Info::Ptr{Cdouble},
  )::Cvoid
end

function amd_valid(n_row, n_col, Ap, Ai)
  @ccall libamd.amd_valid(n_row::Int32, n_col::Int32, Ap::Ptr{Int32}, Ai::Ptr{Int32})::Cint
end

function amd_l_valid(n_row, n_col, Ap, Ai)
  @ccall libamd.amd_l_valid(n_row::Int64, n_col::Int64, Ap::Ptr{Int64}, Ai::Ptr{Int64})::Cint
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
const AMD_DENSE = 1
const AMD_AGGRESSIVE = 2
const AMD_DEFAULT_DENSE = 10.0
const AMD_DEFAULT_AGGRESSIVE = 2
const AMD_STATUS = 1
const AMD_N = 2
const AMD_NZ = 3
const AMD_SYMMETRY = 4
const AMD_NZDIAG = 5
const AMD_NZ_A_PLUS_AT = 6
const AMD_NDENSE = 7
const AMD_MEMORY = 8
const AMD_NCMPA = 9
const AMD_LNZ = 10
const AMD_NDIV = 11
const AMD_NMULTSUBS_LDL = 12
const AMD_NMULTSUBS_LU = 13
const AMD_DMAX = 14
const AMD_OK = 0
const AMD_OUT_OF_MEMORY = -1
const AMD_INVALID = -2
const AMD_OK_BUT_JUMBLED = 1
