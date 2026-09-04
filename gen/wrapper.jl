# Script to parse SuiteSparse headers and generate Julia wrappers.
using Clang
using Clang.Generators
using JuliaFormatter
using SuiteSparse32_jll

function wrapper(name::String, headers::Vector{String})
  @info "Wrapping $name"

  cd(@__DIR__)
  include_dir = joinpath(pwd(), "include")
  options = load_options(joinpath(@__DIR__, "generator.toml"))
  options["general"]["output_file_path"] = joinpath("..", "src", "wrappers", "$(name).jl")
  options["general"]["library_name"] = "lib" * name

  options["general"]["output_ignorelist"] = [
    "SuiteSparse_config_printf_func_get",
    "SuiteSparse_config_malloc_func_get",
    "SuiteSparse_config_calloc_func_get",
    "SuiteSparse_config_realloc_func_get",
    "SuiteSparse_config_free_func_get",
    "SuiteSparse_config_hypot_func_get",
    "SuiteSparse_config_divcomplex_func_get",
    "SuiteSparse_config_malloc_func_set",
    "SuiteSparse_config_calloc_func_set",
    "SuiteSparse_config_realloc_func_set",
    "SuiteSparse_config_free_func_set",
    "SuiteSparse_config_printf_func_set",
    "SuiteSparse_config_hypot_func_set",
    "SuiteSparse_config_divcomplex_func_set",
    "SuiteSparse_config_free",
    "SuiteSparse_config_hypot",
    "SuiteSparse_config_malloc",
    "SuiteSparse_config_calloc",
    "SuiteSparse_config_realloc",
    "SuiteSparse_config_divcomplex",
    "SuiteSparse_config_struct",
    "SuiteSparse_BLAS_library",
    "SuiteSparse_BLAS_integer_size",
    "SuiteSparse_start",
    "SuiteSparse_finish",
    "SuiteSparse_malloc",
    "SuiteSparse_calloc",
    "SuiteSparse_realloc",
    "SuiteSparse_free",
    "SuiteSparse_tic",
    "SuiteSparse_toc",
    "SuiteSparse_time",
    "SuiteSparse_hypot",
    "SuiteSparse_divcomplex",
    "SuiteSparse_version",
    "SuiteSparse_long",
    "SuiteSparse_long_max",
    "SuiteSparse_long_idd",
    "SuiteSparse_long_id",
    "SUITESPARSE_DATE",
    "SUITESPARSE_VERSION",
    "SUITESPARSE_MAIN_VERSION",
    "SUITESPARSE_SUB_VERSION",
    "SUITESPARSE_SUBSUB_VERSION",
    "AMD_DATE",
    "AMD_VERSION",
    "AMD_MAIN_VERSION",
    "AMD_SUB_VERSION",
    "AMD_SUBSUB_VERSION",
    "CAMD_DATE",
    "CAMD_VERSION",
    "CAMD_MAIN_VERSION",
    "CAMD_SUB_VERSION",
    "CAMD_SUBSUB_VERSION",
    "COLAMD_DATE",
    "COLAMD_VERSION",
    "COLAMD_MAIN_VERSION",
    "COLAMD_SUB_VERSION",
    "COLAMD_SUBSUB_VERSION",
    "CCOLAMD_DATE",
    "CCOLAMD_VERSION",
    "CCOLAMD_MAIN_VERSION",
    "CCOLAMD_SUB_VERSION",
    "CCOLAMD_SUBSUB_VERSION",
    "SUITESPARSE_OPENMP_MAX_THREADS",
    "SUITESPARSE_OPENMP_GET_NUM_THREADS",
    "SUITESPARSE_OPENMP_GET_WTIME",
    "SUITESPARSE_OPENMP_GET_THREAD_ID",
    "SUITESPARSE_COMPILER_NVCC",
    "SUITESPARSE_COMPILER_ICX",
    "SUITESPARSE_COMPILER_ICC",
    "SUITESPARSE_COMPILER_CLANG",
    "SUITESPARSE_COMPILER_GCC",
    "SUITESPARSE_COMPILER_MSC",
    "SUITESPARSE_COMPILER_XLC",
    "SUITESPARSE_COMPILER_MAJOR",
    "SUITESPARSE_COMPILER_MINOR",
    "SUITESPARSE_COMPILER_SUB",
    "SUITESPARSE_COMPILER_NAME",
    "SUITESPARSE_STDC_VERSION",
    "SUITESPARSE_RESTRICT",
    "SUITESPARSE_CONFIG_TIMER",
    "SUITESPARSE_TIME",
    "SUITESPARSE__VERSION",
    "SUITESPARSE_COMPLEX_FLOAT",
    "SUITESPARSE_COMPLEX_DOUBLE",
    "SUITESPARSE_BLAS_INT",
    "SUITESPARSE_BLAS_DTRSV",
    "SUITESPARSE_BLAS_DGEMV",
    "SUITESPARSE_BLAS_DTRSM",
    "SUITESPARSE_BLAS_DGEMM",
    "SUITESPARSE_BLAS_DSYRK",
    "SUITESPARSE_BLAS_DGER",
    "SUITESPARSE_BLAS_DSCAL",
    "SUITESPARSE_BLAS_DNRM2",
    "SUITESPARSE_LAPACK_DPOTRF",
    "SUITESPARSE_LAPACK_DLARF",
    "SUITESPARSE_LAPACK_DLARFG",
    "SUITESPARSE_LAPACK_DLARFT",
    "SUITESPARSE_LAPACK_DLARFB",
    "SUITESPARSE_BLAS_ZTRSV",
    "SUITESPARSE_BLAS_ZGEMV",
    "SUITESPARSE_BLAS_ZTRSM",
    "SUITESPARSE_BLAS_ZGEMM",
    "SUITESPARSE_BLAS_ZHERK",
    "SUITESPARSE_BLAS_ZGERU",
    "SUITESPARSE_BLAS_ZSCAL",
    "SUITESPARSE_BLAS_DZNRM2",
    "SUITESPARSE_LAPACK_ZPOTRF",
    "SUITESPARSE_LAPACK_ZLARF",
    "SUITESPARSE_LAPACK_ZLARFG",
    "SUITESPARSE_LAPACK_ZLARFT",
    "SUITESPARSE_LAPACK_ZLARFB",
    "SUITESPARSE_BLAS_STRSV",
    "SUITESPARSE_BLAS_SGEMV",
    "SUITESPARSE_BLAS_STRSM",
    "SUITESPARSE_BLAS_SGEMM",
    "SUITESPARSE_BLAS_SSYRK",
    "SUITESPARSE_BLAS_SGER",
    "SUITESPARSE_BLAS_SSCAL",
    "SUITESPARSE_BLAS_SNRM2",
    "SUITESPARSE_LAPACK_SPOTRF",
    "SUITESPARSE_LAPACK_SLARF",
    "SUITESPARSE_LAPACK_SLARFG",
    "SUITESPARSE_LAPACK_SLARFT",
    "SUITESPARSE_LAPACK_SLARFB",
    "SUITESPARSE_BLAS_CTRSV",
    "SUITESPARSE_BLAS_CGEMV",
    "SUITESPARSE_BLAS_CTRSM",
    "SUITESPARSE_BLAS_CGEMM",
    "SUITESPARSE_BLAS_CHERK",
    "SUITESPARSE_BLAS_CGERU",
    "SUITESPARSE_BLAS_CSCAL",
    "SUITESPARSE_BLAS_SCNRM2",
    "SUITESPARSE_LAPACK_CPOTRF",
    "SUITESPARSE_LAPACK_CLARF",
    "SUITESPARSE_LAPACK_CLARFG",
    "SUITESPARSE_LAPACK_CLARFT",
    "SUITESPARSE_LAPACK_CLARFB",
    "AMD__VERSION",
    "CAMD__VERSION",
    "COLAMD__VERSION",
    "CCOLAMD__VERSION",
    "amd_version",
    "camd_version",
    "colamd_version",
    "ccolamd_version",
  ]

  args = get_default_args()
  push!(args, "-I$include_dir")

  ctx = create_context(headers, args, options)
  build!(ctx)

  path = options["general"]["output_file_path"]
  format_file(path, YASStyle())

  text = read(path, String)
  text = replace(text, "end\n\nconst" => "end\n\n\nconst")
  text = replace(text, "\n\nconst" => "\nconst")
  write(path, text)
  return nothing
end

function main(name::String = "all")
  include = joinpath(SuiteSparse32_jll.artifact_dir, "include", "suitesparse")

  if name == "all" || name == "amd"
    wrapper("amd", [joinpath(include, "amd.h")])
  end

  if name == "all" || name == "camd"
    wrapper("camd", [joinpath(include, "camd.h")])
  end

  if name == "all" || name == "colamd"
    wrapper("colamd", [joinpath(include, "colamd.h")])
  end

  if name == "all" || name == "ccolamd"
    wrapper("ccolamd", [joinpath(include, "ccolamd.h")])
  end
end

# If we want to use the file as a script with `julia wrapper.jl`
if abspath(PROGRAM_FILE) == @__FILE__
  main()
end
