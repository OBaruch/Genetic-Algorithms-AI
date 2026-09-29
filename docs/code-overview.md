# Code Overview

> This page explains the original code **without changing it**. Line numbers refer to the files in [`../src/`](../src/). Spanish identifiers and comments are kept as they are and translated in parentheses where helpful.

## Files

| File | Kind | Lines | Responsibility |
|---|---|---|---|
| [`AlgoritmoGeneticoParaMinimos_SeleccionNatural.m`](../src/AlgoritmoGeneticoParaMinimos_SeleccionNatural.m) | MATLAB **script** | 98 | Parameters, objective function, population setup, GA loop, plotting |
| [`Ruleta.m`](../src/Ruleta.m) | MATLAB **function** | 20 | Roulette-wheel (fitness-proportionate) selection of one individual |

Dependency: the script calls `Ruleta(aptitud, N)`, so both files must be in the same folder or on the MATLAB path. There are no other dependencies.

The project is too small to have an "architecture" in any real sense. It is one procedural script with one helper function, so this page covers the execution flow instead.

## Main Script: `AlgoritmoGeneticoParaMinimos_SeleccionNatural.m`

### 1. Setup (lines 1–11)

| Variable | Value | Meaning (from the original comments) |
|---|---|---|
| `N` | `1000` | *Población*: population size (must be even, see §5) |
| `D` | `2` | *Cantidad de información genética*: genes per individual (the x and y coordinates) |
| `Pm` | `0` | *Posibilidad de mutar de los hijos*: children's mutation probability |
| `generaciones` | `5` | Number of generations |

`clear` and `clc` reset the workspace and the command window.

### 2. Objective function and surface (lines 13–24)

- **Active (function 2):** `f=@(x,y)((x-2).^2)+((y-2).^2)`. A grid `meshgrid(-20:.5:20,-10:.5:20)` and a matching `z` are built so the surface can be drawn.
- **Commented out (function 1):** `f=@(x,y) x.*exp(-x.^2-y.^2)` with a finer grid (step `.1`).
- `hold on` keeps later plot calls on the same axes.

#### Switching between the two objective functions

The original code has no parameter for choosing the function. The author commented out one block (lines 15–18) and uncommented the other (lines 20–23). That is how function 1's figures in the report were produced (Inferred). The report's "100 generations" caption suggests `generaciones` was changed at the same time. This is described here only; the repository keeps the file exactly as it was last saved.

### 3. Initialization (lines 26–41)

- `x` is a `D × N` matrix: each **column** is one individual.
- `aptitud` (fitness) is a `1 × N` row vector.
- Bounds `xi = [-5; -5]` (lower) and `xu = [5; 5]` (upper).
- Each individual is drawn uniformly from the box: `x(:,i) = xi + (xu-xi).*rand(D,1)`.

### 4. Fitness evaluation (lines 47–58)

The comment on line 47 is informal Mexican Spanish slang for "evaluate how good each individual is". It maps the objective value `fx` to a fitness to be maximized:

```
fx ≥ 0  →  aptitud = 1 / (1 + fx)      (smaller f  ⇒ fitness closer to 1)
fx < 0  →  aptitud = 1 + |fx|          (more negative f ⇒ fitness above 1)
```

This is a common way to turn minimization into maximization while keeping every fitness positive, which roulette selection needs. The negative branch matters for function 1, whose minimum is about −0.43.

### 5. Selection and crossover (lines 59–74)

For `j = 1, 3, 5, …, N−1` (so `N` must be even):

1. **Selection** (`%% Mejor candidato`, "best candidate"). Two parent indices are drawn with `Ruleta`. The second is re-drawn until it differs from the first.
2. **Crossover** (section `%% SEXO`). A cut point `pc = randi([1, D])` is chosen and the parents' tails are swapped:
   - `xh1 = [xp1(1:pc); xp2(pc+1:end)]`
   - `xh2 = [xp2(1:pc); xp1(pc+1:end)]`
3. The two children go into columns `j` and `j+1` of the offspring matrix `xh`.

With `D = 2`, `pc` is either 1 (swap y between the parents) or 2 (no swap, so the children are copies of their parents).

### 6. Mutation (lines 75–85)

For every gene of every child, if the condition `randi([0 1]) < Pm` holds, the gene is replaced with a new uniform random value inside its bounds (random-reset mutation). With `Pm = 0` the condition is never true, so **no mutation happens** in the delivered configuration. See [possible-improvements.md](possible-improvements.md#1-mutation-probability-check) for why this check does not act as a true probability for other values of `Pm`.

### 7. Plotting (lines 86–95)

- `cla` clears the axes. `surfc` redraws the objective surface with contour lines underneath.
- Each individual of the **current** population `x` (the parents just evaluated) is drawn as a red circle at height `f(x, y)` with `plot3(...,'ro')`, one call per individual.
- `axis([-5 5 -5 5])` limits the view to the search box, and `pause(.01)` lets the figure refresh, which gives the animation effect.

### 8. Replacement (lines 96–97)

`x = xh`: the whole population is replaced by the children (generational replacement, **no elitism**). The loop then continues with the next generation.

## `Ruleta.m`: Roulette-Wheel Selection

```matlab
function indp = Ruleta(aptitud, N)
```

| Step | Lines | Description |
|---|---|---|
| Sum fitness | 2–5 | `suma_aptitud` accumulates all fitness values in a loop |
| Probabilities | 6–9 | `P(i) = aptitud(i) / suma_aptitud` |
| Spin | 10 | `r = rand()` |
| Cumulative search | 11–18 | Adds up `P(i)` and returns the first `i` where the running sum is `≥ r` |
| Fallback | 19 | Returns `N` if rounding keeps the running sum below `r` |

Each call costs O(N), and it is called at least N times per generation, so selection costs O(N²) per generation (about 10⁶ operations with N = 1000).

## Execution Flow Summary

```
script start
 ├─ parameters, objective f, surface grid
 ├─ random population x (2×1000)
 └─ for s = 1..generaciones
     ├─ fitness(x)
     ├─ 500 × [Ruleta ×2 → crossover → 2 children]  → xh
     ├─ mutation(xh)          (no-op with Pm = 0)
     ├─ plot surface + x
     └─ x ← xh
```

## Glossary (Spanish → English)

| Identifier / comment | Meaning |
|---|---|
| `Poblacion` / `N` | Population / population size |
| `aptitud` | Fitness |
| `generaciones` | Generations |
| `Limites`, `xi`, `xu` | Bounds, lower bound, upper bound |
| `xp1`, `xp2` | Parent 1, parent 2 (*padre*) |
| `xh`, `xh1`, `xh2` | Children (*hijos*) |
| `pc` | Crossover point (*punto de cruce*) |
| `Pm` | Mutation probability (*probabilidad de mutación*) |
| `Ruleta` | Roulette |
| `suma_aptitud` | Sum of fitness |
| `indp` | Selected parent index |
| `CAMBIAR HIJOS POR PADRES` | "Replace parents with children" |
| `Plotear cada individuo de cada generación` | "Plot every individual of every generation" |
