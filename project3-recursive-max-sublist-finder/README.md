# MIPS Sublist Maximum Value Finder

## Description

A MIPS assembly program that finds the maximum value in a predefined list of integers using a recursive algorithm. The program prompts the user to enter a sublist size and returns the maximum value within that specified range.

## Features

- Recursive maximum value finding algorithm
- User-defined sublist size input
- Handles integer lists with both positive and negative numbers
- Size range limited to 1-50 elements
- Simple command-line interface

## Usage

1. Run the program
2. Enter the desired sublist size:
   - Minimum size: 1
   - Maximum size: 50
3. View the maximum value of the selected sublist

## Input Requirements

- Sublist size: Integer between 1 and 50
- Input must be a valid number within the specified range

## Output Format

```
Enter the size of the sublist (1-50): [user input]
The maximum value of the sublist is [maximum value]
```

## Technical Details

- Written in MIPS assembly language
- Implements recursive function for maximum value finding
- Uses stack frame management for function calls
- Modular code organization with separate procedures:
  - `main`: Handles user interaction and program flow
  - `findMax`: Recursive maximum value calculation
- Efficient algorithm with O(n) time complexity

## Program Structure

1. Data Section

   - Predefined list of integers
   - User prompt strings
   - Output message strings

2. Text Section
   - Main program logic
   - Recursive maximum finding procedure
   - System call interactions for I/O

## Algorithm Description

- Base case: When sublist size is 1, return the single element
- Recursive case:
  - Reduce sublist size by 1
  - Compare first element with maximum of remaining sublist
  - Return the larger value

## Limitations

- Uses a hardcoded predefined list
- Sublist size restricted to 1-50 elements
- Requires manual code modification to change the list

## Notes

- Handles both positive and negative integers
- Demonstrates recursive algorithm implementation in MIPS assembly

## Author

Sayed Abdul Ahad Ibrahimi

## Date

April 18, 2023
