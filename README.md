# WID3001 Functional and Logic Programming: Assignment 1

Arithmetic Expression Evaluator, written in Haskell.

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

## Files

- `Evaluator.hs`: the expression evaluator
- `Assignment 1.pdf`: the assignment brief
