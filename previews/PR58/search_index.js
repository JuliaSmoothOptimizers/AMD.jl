var documenterSearchIndex = {"docs":
[{"location":"reference/#Reference","page":"Reference","title":"Reference","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"​","category":"page"},{"location":"reference/#Contents","page":"Reference","title":"Contents","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"​","category":"page"},{"location":"reference/","page":"Reference","title":"Reference","text":"Pages = [\"reference.md\"]","category":"page"},{"location":"reference/","page":"Reference","title":"Reference","text":"​","category":"page"},{"location":"reference/#Index","page":"Reference","title":"Index","text":"","category":"section"},{"location":"reference/","page":"Reference","title":"Reference","text":"​","category":"page"},{"location":"reference/","page":"Reference","title":"Reference","text":"Pages = [\"reference.md\"]","category":"page"},{"location":"reference/","page":"Reference","title":"Reference","text":"​","category":"page"},{"location":"reference/","page":"Reference","title":"Reference","text":"Modules = [AMD]","category":"page"},{"location":"reference/#AMD.Amd","page":"Reference","title":"AMD.Amd","text":"Base type to hold control and information related to a call to AMD. control is a vector of C doubles with components:\n\nd = control[AMD_DENSE]: rows with more than max(d√n, 16) entries are\n\nconsidered \"dense\" and appear last in the permutation. If d < 0 no row will be treated as dense.\n\ncontrol[AMD_AGGRESSIVE]: triggers aggressive absorption if nonzero.\n\ninfo is a vector of C doubles that contains statistics on the ordering.\n\n\n\n\n\n","category":"type"},{"location":"reference/#AMD.amd","page":"Reference","title":"AMD.amd","text":"amd(A, meta)\n\nor\n\namd(A)\n\nGiven a sparse matrix A and an Amd structure meta, p = amd(A, meta) computes the approximate minimum degree ordering of A + Aᵀ. The ordering is represented as a permutation vector p. Factorizations of A[p,p] tend to be sparser than those of A.\n\nThe matrix A must be square and the sparsity pattern of A + Aᵀ is implicit. Thus it is convenient to represent symmetric or hermitian matrices using one triangle only. The diagonal of A may be present but will be ignored.\n\nThe ordering may be influenced by changing meta.control[AMD_DENSE] and meta.control[AMD_AGGRESSIVE].\n\nStatistics on the ordering appear in meta.info.\n\n\n\n\n\n","category":"function"},{"location":"reference/#AMD.colamd","page":"Reference","title":"AMD.colamd","text":"colamd(A, meta)\n\nor\n\ncolamd(A)\n\ncolamd computes a permutation vector p such that the Cholesky factorization of   A[:,p]' * A[:,p] has less fill-in and requires fewer floating point operations than AᵀA.\n\n\n\n\n\n","category":"function"},{"location":"reference/#AMD.symamd","page":"Reference","title":"AMD.symamd","text":"symamd(A, meta)\n\nor\n\nsymamd(A)\n\nGiven a symmetric or hermitian matrix A, symamd computes a permutation vector p such that the Cholesky factorization of A[p,p] has less fill-in and requires fewer floating point operations than that of A.\n\n\n\n\n\n","category":"function"},{"location":"#AMD.jl","page":"Home","title":"AMD.jl","text":"","category":"section"},{"location":"tutorial/#AMD.jl-Tutorial","page":"Tutorial","title":"AMD.jl Tutorial","text":"","category":"section"}]
}
