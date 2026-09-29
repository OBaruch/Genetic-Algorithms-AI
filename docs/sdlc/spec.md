# Specification (As-Built)

> **Artifact type:** Spec (the *what*). Second of three agentic-SDLC artifacts: **[intent](intent.md) → spec → [plan](plan.md)**.
> **Mode:** reverse-engineered from the existing code in [`src/`](../../src/) and the [original report](../original/practica-3-genetic-algorithms-report.pdf). It describes the system **as it was built**, including its quirks. It is not a specification for a new or corrected version.
> **Evidence legend:** **[C]** Confirmed · **[I]** Inferred · **[U]** Unknown.

## 1. System Summary

| Attribute | Value |
|---|---|
| Name | Genetic algorithm for minima (natural selection) |
| Entry point | `src/AlgoritmoGeneticoParaMinimos_SeleccionNatural.m` (MATLAB script) **[C]** |
| Components | Main script + `src/Ruleta.m` (function) **[C]** |
| Runtime | MATLAB, version **[U]**; no toolboxes required **[C]** |
| Inputs | None at runtime; all parameters hard-coded **[C]** |
| Outputs | Animated 3D figure; no files and no console output **[C]** |

## 2. Configuration (hard-coded)

| ID | Parameter | Value | Source |
|---|---|---|---|
| CFG-1 | Population size `N` | 1000 | line 5 **[C]** |
| CFG-2 | Genes per individual `D` | 2 | line 7 **[C]** |
| CFG-3 | Mutation parameter `Pm` | 0 | line 9 **[C]** |
| CFG-4 | Generations `generaciones` | 5 | line 11 **[C]** |
| CFG-5 | Lower / upper bounds `xi`, `xu` | [−5, −5] / [5, 5] | lines 32–33 **[C]** |
| CFG-6 | Active objective | f₂(x, y) = (x−2)² + (y−2)² | line 15 **[C]** |
| CFG-7 | Alternative objective (commented) | f₁(x, y) = x·e^(−x²−y²) | line 20 **[C]** |

## 3. Functional Requirements (observed behavior)

| ID | Requirement | Status |
|---|---|---|
| FR-1 | The system SHALL initialize `N` individuals uniformly at random inside `[xi, xu]`. | **[C]** lines 39–41 |
| FR-2 | Each generation, the system SHALL compute fitness as `1/(1+f)` when `f ≥ 0` and `1+|f|` when `f < 0`. | **[C]** lines 48–58 |
| FR-3 | The system SHALL select each parent by fitness-proportionate (roulette-wheel) selection. | **[C]** `Ruleta.m` |
| FR-4 | The two parents of a pair SHALL be different individuals (different index). | **[C]** lines 63–65 |
| FR-5 | The system SHALL create two children per pair by single-point crossover at `pc ∈ {1..D}`. | **[C]** lines 69–73 |
| FR-6 | The system SHALL apply random-reset mutation per gene when `randi([0 1]) < Pm`. | **[C]** line 78 |
| FR-7 | The system SHALL draw, each generation, the objective surface (`surfc`) and the current population as red markers at height `f`. | **[C]** lines 88–95 |
| FR-8 | The system SHALL replace the whole population with the children (no elitism). | **[C]** line 97 |
| FR-9 | The system SHALL stop after `generaciones` iterations. | **[C]** line 45 |

## 4. Acceptance Criteria (from the original report)

| ID | Criterion | Evidence |
|---|---|---|
| AC-1 | For f₂, after 5 generations the population forms a dense cluster around (2, 2). | Report p. 3 figure **[C]** |
| AC-2 | For f₁, after enough generations the population gathers in the negative valley near (−0.71, 0). | Report p. 2 figure **[C]**; settings used for that run **[I]** (100 generations according to the caption) |
| AC-3 | Generation 1 shows the population spread over the whole search box. | Report pp. 2–3 **[C]** |

## 5. Non-Functional Characteristics (observed)

| ID | Characteristic | Status |
|---|---|---|
| NFR-1 | Selection cost O(N²) per generation (each roulette spin is O(N)). | **[C]** by reading the code |
| NFR-2 | Rendering: N separate `plot3` calls per frame. | **[C]** |
| NFR-3 | Non-deterministic: no random seed is set. | **[C]** |
| NFR-4 | `N` must be even for the population size to stay constant. | **[C]** by reading the code |
| NFR-5 | Source files use CRLF line endings (written on Windows). | **[C]** `file` output; author's OS **[I]** |

## 6. Known Deviations (documented, intentionally not fixed)

| ID | Deviation | Reference |
|---|---|---|
| DEV-1 | The mutation condition is not a real probability test (`randi` returns an integer). | [possible-improvements §1](../possible-improvements.md#1-mutation-probability-check) |
| DEV-2 | The search box is [−5, 5]² for f₁, although the assignment specifies [−2, 2]². | [possible-improvements §2](../possible-improvements.md#2-domain-of-function-1) |
| DEV-3 | `pc = D` produces clones (no recombination). | [possible-improvements §3](../possible-improvements.md#3-crossover-with-d--2) |
| DEV-4 | The final offspring are never evaluated or displayed, and no numeric optimum is reported. | [possible-improvements §5](../possible-improvements.md#5-last-generation-is-never-shown-or-evaluated) |

## 7. Preservation Contract

These files are **frozen**. Any change to them breaks this specification.

| File | SHA-256 |
|---|---|
| `src/AlgoritmoGeneticoParaMinimos_SeleccionNatural.m` | `ac5a535ae1799968e7d5e6a0392515f11620680d32841ff5455710e634ea57f7` |
| `src/Ruleta.m` | `1bc186f854a4563c73e9073474f2fdd5dcdd28d4b98740a69ce036692a580e11` |
| `docs/original/practica-3-genetic-algorithms-report.pdf` (originally `PDF.pdf`) | `542058b15e73c10bb7d530cf213e0b698e2ea78cf683d7fbfc215ee635977a45` |

Verify with:

```bash
sha256sum src/*.m docs/original/*.pdf
```

## 8. Out of Scope

- Any change in behavior, fix or optimization of the algorithm.
- Porting to another language, or making the code Octave-compatible.
- Adding tests, CI, packaging or runtime configuration.
