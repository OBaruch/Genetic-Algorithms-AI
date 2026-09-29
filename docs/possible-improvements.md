# Possible Improvements

> **None of the items below have been applied.** The source code in [`../src/`](../src/) is deliberately kept exactly as it was written in 2019, to preserve the original implementation and its learning context. This page records what a reviewer today might point out. It is written for readers, not as a to-do list for this repository.

Each item gives the observation, why it matters, and what a modern version could do differently.

## Correctness

### 1. Mutation probability check

- **Observation:** line 78 uses `if randi([0 1]) < Pm`. `randi([0 1])` returns the integer 0 or 1, not a uniform number in [0, 1).
- **Effect:** for `Pm = 0` nothing ever mutates. For any `0 < Pm ≤ 1` a gene mutates whenever the result is 0, so about **50 %** of the time, whatever `Pm` is. For `Pm > 1` every gene mutates.
- **Alternative:** `if rand() < Pm`.

### 2. Domain of function 1

- **Observation:** the assignment limits function 1 to x, y ∈ [−2, 2], but the search bounds are [−5, 5] for both functions.
- **Effect:** the minimum (−0.707, 0) lies in both ranges, so the result is not affected. The search space is just larger than required.
- **Alternative:** define the bounds together with each objective function.

### 3. Crossover with `D = 2`

- **Observation:** `pc = randi([1, D])` can be `D`, and then the children are exact copies of the parents.
- **Effect:** about half of all pairings produce no recombination.
- **Alternative:** `pc = randi([1, D-1])` (for D ≥ 2), or arithmetic/blend crossover, which is common for real-coded GAs.

### 4. Population size must be even

- **Observation:** the offspring loop `for j=1:2:N` writes `xh(:,j+1)`.
- **Effect:** an odd `N` would grow `xh` by one column (MATLAB auto-expands on assignment), so the population size would drift.
- **Alternative:** validate `N`, or handle the last child separately.

### 5. Last generation is never shown or evaluated

- **Observation:** the plot draws `x` (the parents) before `x = xh`. After the final iteration the last children are neither evaluated nor drawn, and no best solution is reported.
- **Alternative:** after the loop, evaluate the final population and print `min f` and its argmin.

### 6. Duplicate-parent loop

- **Observation:** `while ind1==ind2` re-spins the roulette. If one individual held almost all of the fitness this could loop for a very long time. That is unlikely with N = 1000.

## Design and Maintainability

- **Script, not function:** parameters are hard-coded and `clear` wipes the caller's workspace. A function such as `ga_minimize(f, bounds, N, Pm, G)` would make runs reproducible and comparable.
- **Switching objectives by commenting code:** a parameter or a list of problem definitions (function, bounds, plot grid) would avoid editing the source.
- **Duplicated objective definition:** `f` and `z` both encode the same formula. `z = f(xfuncion, yfuncion)` would keep them in sync.
- **No elitism:** the best individual can be lost between generations. Keeping the top k individuals is a standard fix.
- **No stopping criterion or history:** only a fixed number of generations, and no record of best or mean fitness per generation. A convergence plot would support the report's conclusions.
- **Reproducibility:** no random seed is set (`rng(...)`), so runs cannot be repeated exactly.
- **Language consistency:** identifiers and comments mix Spanish, and some comments are informal. That is fine for coursework, but a shared codebase would usually use one language.

## Performance

- **Vectorization:** fitness, roulette sums (`cumsum`) and mutation can all be vectorized. `Ruleta` recomputes the whole probability vector on every call, which makes selection O(N²) per generation.
- **Plotting:** `plot3` is called once per individual (1000 graphics objects per frame). A single `plot3(x(1,:), x(2,:), f(x(1,:),x(2,:)), 'ro')` call draws the same thing much faster.
- The report's conclusion that GAs "use a lot of computational resources" is partly caused by these implementation choices, not only by the algorithm itself.

## Documentation Ideas (outside the code)

- Record the MATLAB version used. It is unknown today.
- Check whether the code runs in GNU Octave (it uses only core functions).
- Record the numeric minimum found for each function next to the figures.
