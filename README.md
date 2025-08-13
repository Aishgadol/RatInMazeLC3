# Rat in a Maze – LC-3 Assembly

Minimal LC‑3 program that reads a maze and leaves a stub for a solving routine.

## Files
- `main.asm` – entry point; loads helpers, reads maze size and matrix, calls `SOLVE`.
- `GetNum.asm` – reads a decimal number from stdin.
- `GetMatrix.asm` – fills an `n×n` matrix and checks that the start `(0,0)` and end `(n-1,n-1)` cells are `1`.
- `Mul.asm` – iterative multiplication helper.
- `submitters.txt` – original authors.

## Requirements
- LC‑3 assembler and simulator (`lc3as`, `lc3sim`, or [lc3tools](https://github.com/chobits/LC3Tools)).

## Build and Run
```bash
lc3as main.asm GetNum.asm GetMatrix.asm Mul.asm
lc3sim main.obj GetNum.obj GetMatrix.obj Mul.obj
```
The program prompts for a maze size between 2 and 20 and then for the matrix contents.
Invalid input restarts the matrix entry.

## Extending `SOLVE`
`SOLVE` receives two stack arguments:
1. pointer to the matrix (R6+0)
2. maze dimension `n` (R6+1)

Implement any path‑finding algorithm and return a non‑zero value if a path exists.

## License
No license file is provided; contact the authors before reuse.
