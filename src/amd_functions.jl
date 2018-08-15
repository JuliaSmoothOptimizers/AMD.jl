function __init__()
  global const _libamd = Libdl.dlopen("libamd")

  global const _amd_defaults = Libdl.dlsym(_libamd, "amd_defaults")
  global const _amd_valid = Libdl.dlsym(_libamd, "amd_valid")
  global const _amd_order = Libdl.dlsym(_libamd, "amd_order")

  global const _amd_l_defaults = Libdl.dlsym(_libamd, "amd_l_defaults")
  global const _amd_l_valid = Libdl.dlsym(_libamd, "amd_l_valid")
  global const _amd_l_order = Libdl.dlsym(_libamd, "amd_l_order")
end
