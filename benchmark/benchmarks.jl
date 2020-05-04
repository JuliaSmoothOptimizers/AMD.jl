using MatrixMarket, DelimitedFiles
using LinearAlgebra, SparseArrays
using LDLFactorizations, AMD, Metis
using Printf, DataFrames, SolverBenchmark

# download from https://github.com/optimizers/sqd-collection
# run(`git clone https://github.com/optimizers/sqd-collection.git`)

markdown_benchmarks = true
latex_benchmarks    = true

const sqd_path = joinpath(dirname(pathof(AMD)), "..", "benchmark", "sqd-collection")
subdirs = readdir(sqd_path)
const formulations = ("2x2", "3x3")

names_sqd     = String[]
ratio_amd     = Float64[]
ratio_symamd  = Float64[]
ratio_metis   = Float64[]
ratio_classic = Float64[]
nnz_sqd       = Int[]

import SparseArrays.nnz
nnz(ldlt::LDLFactorizations.LDLFactorization) = SparseArrays.nnz(ldlt.L) + length(ldlt.D)

for subdir ∈ subdirs
  subdir == ".git" && continue
  isdir(joinpath(sqd_path, subdir)) || continue  # ignore regular files
  for formulation ∈ formulations
    iterpath = joinpath(sqd_path, subdir, formulation, "iter_0")
    isdir(iterpath) || continue

    A = MatrixMarket.mmread(joinpath(iterpath, "K_0.mtx"))
    b = readdlm(joinpath(iterpath, "rhs_0.rhs"), Float64)[:]
    nnz_A = nnz(tril(A))
    if size(A, 1) ≤ 10000
      name = "$(subdir)_$(formulation)"
      push!(names_sqd, name)
      println(name)

      p_amd     = amd(A)
      p_metis   = Int.(Metis.permutation(A)[1])
      p_symamd  = symamd(A)
      p_classic = collect(1:size(A,1))

      ldlt_amd     = ldl(A, p_amd)
      ldlt_symamd  = ldl(A, p_symamd)
      ldlt_metis   = ldl(A, p_metis)
      ldlt_classic = ldl(A, p_classic)

      push!(nnz_sqd, nnz_A)
      push!(ratio_amd, nnz(ldlt_amd) / nnz_A)
      push!(ratio_symamd, nnz(ldlt_symamd) / nnz_A)
      push!(ratio_metis, nnz(ldlt_metis) / nnz_A)
      push!(ratio_classic, nnz(ldlt_classic) / nnz_A)
    end
  end
end

orderings = [:NO_ORDERING, :AMD, :SYMAMD, :METIS]
n = length(names_sqd)
stats = Dict(ordering => 
          DataFrame(
            :id     => 1:n,
            :name   => [@sprintf("%15s", names_sqd[i]) for i = 1:n],
            :nnz    => [@sprintf("%6d", nnz_sqd[i]) for i = 1:n],
            :ratio  => [@sprintf("%3.1f", (ordering == :AMD ? ratio_amd[i] : (ordering == :SYMAMD ? ratio_symamd[i] : (ordering == :METIS ? ratio_metis[i] : ratio_classic[i])))) for i = 1:n]
          ) for ordering in orderings)

df = join(stats, [:ratio], invariant_cols=[:name, :nnz])

if markdown_benchmarks
  open("benchmarks.md", "w") do io
    markdown_table(io, df)
  end
end

if latex_benchmarks
  open("benchmarks.tex", "w") do io
    println(io, "\\documentclass[varwidth=20cm,crop=true]{standalone}")
    println(io, "\\usepackage{longtable}")
    println(io, "\\begin{document}")
    latex_table(io, df)
    println(io, "\\end{document}")
  end
end
