# Project Context

This page separates what is **Confirmed** (stated in a file or in the Git history), what is **Inferred** (a reasonable deduction from the files), and what is **Unknown**.

## Classification

**Academic / University Project: Coursework / Assignment** (Confirmed)

The original report carries the Universidad de Guadalajara / CUCEI header. It names the course (*Sistemas Inteligentes II*) and the activity (*Práctica 3*), and it opens with a numbered assignment statement.

## Summary of Evidence

| Item | Value | Status | Source |
|---|---|---|---|
| Institution | Universidad de Guadalajara, Centro Universitario de Ciencias Exactas e Ingenierías (CUCEI) | Confirmed | Logo header on every page of the report |
| Course | Sistemas Inteligentes II | Confirmed | Report, page 1 |
| Activity | Práctica 3 | Confirmed | Report, page 1 |
| Author | Omar Baruch Morón López | Confirmed | Report, page 1 |
| Report date | Monday, 18 February 2019 | Confirmed | Report header |
| GitHub upload | 20 February 2021 (`Initial commit` and `Add files via upload`, by Baruch Lopez) | Confirmed | Git history |
| License | MIT, © 2021 Baruch Lopez | Confirmed | `LICENSE` |
| Language / platform | MATLAB | Confirmed (by the code) / Inferred (by the figures' look) | `.m` files, MATLAB plotting functions |
| Purpose | Find the global minimum of two given functions with a GA | Confirmed | Assignment statement in the report |
| Source code is the version used for the report | Probably, but not certain | Inferred | Parameters and figures agree for function 2 (5 generations). Function 1 is described after 100 generations, but the code has `generaciones=5`, so it was probably run with different settings. |
| Source of the theory text | Universidad del País Vasco GA lecture notes (footnote URL) | Confirmed | Report footnote 1 |
| Grade, feedback, or teacher | Not available | Unknown | — |
| MATLAB version used | Not available | Unknown | — |

## Original Objective

Write a program that finds the **global minimum** of the following functions using a **Genetic Algorithm**. Then show the evolution graphically and answer whether the GA is better than traditional methods, and why. See [assignment.md](assignment.md).

## Scope

The project is a single MATLAB script plus one helper function (~130 lines in total). It is a learning exercise meant to show GA mechanics visually. It is not a reusable library: it has no command-line interface, no file I/O, no tests and no configuration files. This is consistent with a timed lab assignment.

## Historical Timeline

| Date | Event |
|---|---|
| 18 Feb 2019 | Lab report dated and (presumably) submitted. Figures in the report come from runs of the MATLAB code. |
| 20 Feb 2021 | Repository created on GitHub with the MIT license. `PDF.pdf`, `Ruleta.m` and the main script were uploaded through the GitHub web UI. |
| Later | Repository reorganized and documented (this documentation). Source code left unchanged. |

## Naming Notes

- The GitHub repository name is **Genetic-Algorithms-AI**. The main script is called `AlgoritmoGeneticoParaMinimos_SeleccionNatural.m` ("Genetic algorithm for minima: natural selection").
- The original report file was called `PDF.pdf`. It was renamed to `practica-3-genetic-algorithms-report.pdf` inside [`original/`](original/) so the name says what it is. Its content is unchanged (SHA-256 `542058b1…7a45`).

## Contradictions and Gaps Found

| Topic | Assignment / report says | Code says | Notes |
|---|---|---|---|
| Domain of function 1 | x, y ∈ [−2, 2] | Population initialized in [−5, 5] for both functions (`xi`, `xu`) | The report's function 1 figures also show a −5…5 axis, so the code matches the figures, not the assignment's domain. The minimum (−0.707, 0) is inside both ranges. |
| Generations for function 1 | "After 100 generations" | `generaciones=5` | The code was probably last saved in its function 2 setup. Cannot be confirmed. |
| Mutation | The report treats mutation probability as a key parameter | `Pm=0`, and the mutation test `randi([0 1])<Pm` does not behave as a probability | See [possible-improvements.md](possible-improvements.md#1-mutation-probability-check). |
| Numeric result | The minimum is shown only graphically | No value is printed | The report never states the minimum it found as a number. |
