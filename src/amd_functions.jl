using Libdl

function __init__()
  global _libamd = Libdl.dlopen("libamd")

  global _amd_defaults = Libdl.dlsym(_libamd, "amd_defaults")
  global _amd_valid = Libdl.dlsym(_libamd, "amd_valid")
  global _amd_order = Libdl.dlsym(_libamd, "amd_order")

  global _amd_l_defaults = Libdl.dlsym(_libamd, "amd_l_defaults")
  global _amd_l_valid = Libdl.dlsym(_libamd, "amd_l_valid")
  global _amd_l_order = Libdl.dlsym(_libamd, "amd_l_order")
end
