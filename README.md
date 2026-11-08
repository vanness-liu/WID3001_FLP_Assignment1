# WID3001 Functional and Logic Programming: Assignment 1

Arithmetic Expression Evaluator in Haskell.

Course: WID3001 Functional and Logic Programming, Semester 1, 2026/2027
Due date: 10 November 2026

## About

The starting code in `Evaluator.hs` is a simple arithmetic expression evaluator that works on the happy path but contains several bugs. The assignment has two parts:

1. Debug and refactor: fix at least five distinct edge cases and split the code into logically separated modules.
2. Extend: add integer floor division (`//`) and modulo (`%`), with the same precedence as `*` and `/`, correct handling of negative operands and division by zero.

Examples: `-7 // 3 = -3` and `-7 % 3 = 2`.

## Requirements

GHC (Glasgow Haskell Compiler) with GHCi.

## Usage

From the project directory, start GHCi:

    ghci Evaluator.hs

Then try some expressions:

    evaluate "2 + 3 * 4"
    evaluate "(2 + 3) * 4"
    evaluate "-3 * (4 + 5.5)"
    evaluate "-7 // 3"
    evaluate "-7 % 3"

Results are `Right` with the answer, or `Left` with an error message:

    evaluate "2 ** 3 ** 2"    -- Right 512.0
    evaluate "-7 // 3"        -- Right (-3.0)
    evaluate "-7 % 3"         -- Right 2.0
    evaluate "5 // 0"         -- Left "Floor division by zero"
    evaluate "1 2"            -- Left "Unexpected input left after a complete expression"

`//` and `%` are integer operations: they round down (towards negative infinity) and reject operands with a fractional part, such as `5.5 // 2`.

## Files

The original single-file evaluator is split into modules. An input string flows through them in order: `Lexer` → `Parser` → `Eval`.

- `Types.hs`: shared `Token` and `Expr` data types
- `Lexer.hs`: stage 1, `tokenize` turns the input string into tokens
- `Parser.hs`: stage 2, builds an expression tree with the correct precedence and associativity
- `Eval.hs`: stage 3, `eval` computes the result, including `//` and `%`, returning `Left` errors instead of Infinity or NaN
- `Evaluator.hs`: public `evaluate` function that joins the three stages and rejects leftover input
- `tests.txt`: shared test log with expected, before and after results for each bug and for Part 2
- `Assignment 1.pdf`: the assignment brief

The original code is kept at the git tag `original`.

## Group Members
|No.|Name|Matric Number|
|---|----|-------------|
|1.|Matthewdass A/L Sandanadass|23004906|
|2.|Ong Zhao Qian|23004986|
|3.|Vanness Liu Chuen Wei|23005021|