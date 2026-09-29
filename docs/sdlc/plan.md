# Plan

> **Artifact type:** Plan (the *how*). Third of three agentic-SDLC artifacts: **[intent](intent.md) → [spec](spec.md) → plan**.
> **Mode:** Part A reconstructs how the original implementation is organized, working back from the code. Part B is the plan that was carried out to reorganize and document this repository.

---

## Part A: Original Implementation Plan (reconstructed)

The original work was not planned in writing. The steps below are **inferred** from the structure of the code and the report. They show how the spec items map onto the code.

| Step | Work item | Implements | Location |
|---|---|---|---|
| A1 | Define GA parameters (population, genes, mutation, generations) | CFG-1…4 | script lines 4–11 |
| A2 | Define the objective function and its surface grid; one block per assignment function, toggled by comments | CFG-6, CFG-7 | lines 13–24 |
| A3 | Set search bounds and a random initial population | CFG-5, FR-1 | lines 26–41 |
| A4 | Fitness mapping for minimization (positive and negative branches) | FR-2 | lines 47–58 |
| A5 | Roulette-wheel selection as a separate function | FR-3 | `Ruleta.m` |
| A6 | Pairing loop with distinct parents and single-point crossover | FR-4, FR-5 | lines 59–74 |
| A7 | Random-reset mutation | FR-6 | lines 75–85 |
| A8 | Per-generation visualization | FR-7 | lines 86–95 |
| A9 | Generational replacement | FR-8, FR-9 | lines 96–97 |
| A10 | Run for f₂ and f₁, capture figures, write the report and conclusions | AC-1…3 | [original report](../original/practica-3-genetic-algorithms-report.pdf) |

---

## Part B: Repository Modernization Plan (carried out)

### Guardrails
- `src/**` and `docs/original/**` are **read-only**. Moves are allowed (`git mv`); edits are not.
- Documentation only: no new tooling, CI, containers, tests or package managers.
- Every claim is labeled or phrased as Confirmed / Inferred / Unknown.

### Tasks

| # | Task | Output | Status |
|---|---|---|---|
| B1 | Inventory every file in the repository and its Git history | File classification (below) | Done |
| B2 | Read the PDF, both as text and **visually** (figures, formulas embedded as images, captions) | Recovered context | Done |
| B3 | Read the source code; map parameters, operators and flow | Spec (FR/CFG/NFR) | Done |
| B4 | Cross-check the report against the code; record contradictions | [project-context § Contradictions](../project-context.md#contradictions-and-gaps-found) | Done |
| B5 | Move source code into `src/` with `git mv` (content untouched) | `src/` | Done |
| B6 | Move and rename `PDF.pdf` → `docs/original/practica-3-genetic-algorithms-report.pdf` (content untouched) | `docs/original/` | Done |
| B7 | Extract the report's figures (bit-exact embedded images, no re-encoding) for use in the docs | `assets/images/` | Done |
| B8 | Write the README, context, assignment, report summary, code overview and possible improvements | `README.md`, `docs/*.md` | Done |
| B9 | Write the SDLC artifacts (intent, spec, plan) | `docs/sdlc/` | Done |
| B10 | Add `AGENTS.md` with contributor/agent guardrails, and a minimal MATLAB `.gitignore` | `AGENTS.md`, `.gitignore` | Done |
| B11 | Verify preservation (checksums identical before and after) and check that relative links resolve | Verification log (below) | Done |

### File classification (B1)

| Original path | Type | Role | New path |
|---|---|---|---|
| `AlgoritmoGeneticoParaMinimos_SeleccionNatural.m` | Source (script) | Core | `src/` |
| `Ruleta.m` | Source (function) | Core helper | `src/` |
| `PDF.pdf` | Original report / deliverable | Documentation and historical outputs (figures) | `docs/original/practica-3-genetic-algorithms-report.pdf` |
| `LICENSE` | License | Legal | unchanged |
| — (embedded in the PDF) | Figures | Historical program outputs | `assets/images/` |

No datasets, notebooks, configuration files or generated outputs exist as separate files, so no `data/`, `notebooks/` or `archive/` folders were created.

### Verification log (B11)

| Check | Result |
|---|---|
| SHA-256 of both `.m` files before the move = after the move | Identical (see [spec §7](spec.md#7-preservation-contract)) |
| SHA-256 of the PDF before the move = after the move | Identical |
| Git detects the moves as 100 % renames | Yes (`R100`) |
| CRLF line endings preserved in `src/*.m` | Yes |

### Future work (optional, not scheduled)

These would each be a **separate** change and would not touch `src/`:

- Record the MATLAB version the next time the code is run, and check Octave compatibility.
- Add numeric results (the best value found) to the documentation after a documented run.
- If a modernized implementation is ever wanted, put it in a separate folder or repository so that `src/` stays the historical record.
