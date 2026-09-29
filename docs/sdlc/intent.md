# Intent

> **Artifact type:** Intent (the *why*). First of three agentic-SDLC artifacts: **intent → [spec](spec.md) → [plan](plan.md)**.
> **Mode:** reconstructed from the existing project, not written before it. It describes what the project was for and why this repository is maintained the way it is.
> **Evidence legend:** **[C]** Confirmed by a file or the Git history · **[I]** Inferred · **[U]** Unknown.

## 1. Original Intent (2019)

### Problem
Find the **global minimum** of two real functions of two variables with a **Genetic Algorithm**, as required by *Práctica 3* of *Sistemas Inteligentes II* at Universidad de Guadalajara, CUCEI. **[C]**

- f₁(x, y) = x·e^(−x²−y²), x, y ∈ [−2, 2] **[C]**
- f₂(**x**) = Σ(xᵢ − 2)², d = 2 **[C]**

### Why
- **Learning goal:** understand how natural selection, crossover and mutation can drive a population toward an optimum, by building the algorithm by hand instead of calling a toolbox solver. **[I]** (No GA toolbox call appears in the code **[C]**.)
- **Evaluation goal:** answer *"Is the GA method better than traditional methods? Why?"*. **[C]**
- **Communication goal:** make the convergence *visible* by animating the population on the function surface. **[C]** (Plotting code; report figures.)

### Desired outcome
- The population visibly clusters at each function's global minimum. **[C]** (Report pages 2–3.)
- A written reflection on the trade-offs of GAs: exploration versus computational cost, and sensitivity to population size, mutation probability and number of genes. **[C]** (Report page 4.)

### Who
- **Author:** Omar Baruch Morón López. **[C]**
- **Audience:** course instructor and grader. **[I]** Name, grade and feedback **[U]**.

### Non-goals (as evidenced by the delivered scope)
- A reusable library, CLI or API. **[I]**
- Numeric reporting, benchmarking or statistical comparison with classical methods. **[I]** The comparison in the report is qualitative **[C]**.
- Support for arbitrary dimensions or user-supplied functions without editing the code. **[I]**

## 2. Intent of This Repository (Today)

### Problem
Before this change the repository held two MATLAB files and a PDF named `PDF.pdf` in the root, with no README. A visitor could not tell what the project was, where it came from, or how to run it. **[C]**

### Why
Keep the project as an **authentic historical record** in a technical portfolio, and make it understandable in a few minutes.

### Desired outcome
1. A visitor understands the what, why, where and how from `README.md` alone.
2. The original source code and report are preserved **byte-for-byte**.
3. Every statement in the documentation is marked or phrased as confirmed, inferred or unknown.
4. Future contributors, human or AI agents, have explicit guardrails that keep the historical implementation from being "fixed".

### Guiding principle
> **Modernize the repository, not the project.** Organization, documentation and presentation may follow current standards. The original technical implementation stays intact.

### Constraints
- **MUST NOT** modify any file in `src/`: no logic, formatting, naming, comment, encoding or line-ending changes.
- **MUST NOT** modify, replace or delete the original report PDF.
- **MUST NOT** add build, CI/CD, container, test or lint infrastructure the original project did not have.
- **MUST NOT** invent context (dates, grades, versions, commands) that no file supports.

### Success signals
- SHA-256 checksums of the preserved files match the values in [spec.md §7](spec.md#7-preservation-contract).
- `git log --follow` shows the source files as renames with identical content.
- The documentation cross-links resolve and every claim can be traced to a source file.
