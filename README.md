# Signed 8-bit calculator with fundamental operaions
A calculator that takes in two 8-bit numbers, in two's complement, and executes a given operation.

## Purpose of this project

In this project, I studied the fundamental bit-wise algorithms, such as shift-and-add multiplication or quotient-remainder pair generation (division). 

Alongside the implementation of such algorithms, I practiced hardware modularization into a Control Unit (instruction sequencing & flow control) and Execution Unit arithmetic, logic operations and displaying logic) of my digital system.

## How it works :

Because I wanted to use my Nexys A7 board as much as possible, I designed the code around using it. It does it's operations in two steps:

The first step is introducing two eight-bit numbers it two's complement, using the board's switches (the chosen numbers are shown on the seven-segment display):

<img width="528" height="561" alt="phaze1" src="https://github.com/user-attachments/assets/0ef30837-9dfb-4623-9cc2-ede58a4906e2" />

The second step, is selecting the operation:
  1. UP : Addition
  2. DOWN : Subtraction
  3. LEFT : Multiplication
  4. RIGHT : Division
  5. MIDDLE : Reset back to step one
