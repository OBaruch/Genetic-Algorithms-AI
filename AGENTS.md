# Contributor & Agent Guidelines

This file gives instructions to anyone changing this repository, human contributors and automated/AI coding agents alike.

## What this repository is

A **historical, preserved** university project: a MATLAB Genetic Algorithm from *Sistemas Inteligentes II*, Universidad de Guadalajara (CUCEI), 2019. Start with [`README.md`](README.md). The design artifacts are in [`docs/sdlc/`](docs/sdlc/) ([intent](docs/sdlc/intent.md) → [spec](docs/sdlc/spec.md) → [plan](docs/sdlc/plan.md)).

## Hard rules

1. **Do not modify anything in `src/`.** No bug fixes, refactors, formatting, renaming, translation of comments, encoding or line-ending changes (the files use CRLF on purpose). Moving them requires a documented reason.
2. **Do not modify `docs/original/`.** Original documents are kept as they are.
3. **Do not add infrastructure** (CI/CD, Docker, test frameworks, linters, package managers, Makefiles) unless the change is specifically about that and has been approved.
4. **Do not invent facts.** Label claims as *Confirmed*, *Inferred* or *Unknown*, following the existing docs.
5. Improvement ideas go in [`docs/possible-improvements.md`](docs/possible-improvements.md), never into the code.

## Before you finish a change

Run:

```bash
sha256sum src/*.m docs/original/*.pdf
```

and compare the output with the checksums in [`docs/sdlc/spec.md` §7](docs/sdlc/spec.md#7-preservation-contract). They must match.

## Workflow

For any non-trivial change, update the SDLC artifacts first: intent (why), then spec (what), then plan (how). Then change the docs, and keep relative links working.
