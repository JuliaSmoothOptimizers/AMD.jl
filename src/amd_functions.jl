using Libdl, Base.Libc

function __init__()
  global _libamd = Libdl.dlopen("libamd")

  global _amd_defaults = Libdl.dlsym(_libamd, "amd_defaults")
  global _amd_valid = Libdl.dlsym(_libamd, "amd_valid")
  global _amd_order = Libdl.dlsym(_libamd, "amd_order")

  global _amd_l_defaults = Libdl.dlsym(_libamd, "amd_l_defaults")
  global _amd_l_valid = Libdl.dlsym(_libamd, "amd_l_valid")
  global _amd_l_order = Libdl.dlsym(_libamd, "amd_l_order")

  global _libcolamd = Libdl.dlopen("libcolamd")

  global _colamd_set_defaults = Libdl.dlsym(_libcolamd, "colamd_set_defaults")
  global _colamd_recommended = Libdl.dlsym(_libcolamd, "colamd_recommended")
  global _colamd = Libdl.dlsym(_libcolamd, "colamd")
  global _symamd = Libdl.dlsym(_libcolamd, "symamd")

  global _colamd_l_set_defaults = Libdl.dlsym(_libcolamd, "colamd_l_set_defaults")
  global _colamd_l_recommended = Libdl.dlsym(_libcolamd, "colamd_l_recommended")
  global _colamd_l = Libdl.dlsym(_libcolamd, "colamd_l")
  global _symamd_l = Libdl.dlsym(_libcolamd, "symamd_l")
end
