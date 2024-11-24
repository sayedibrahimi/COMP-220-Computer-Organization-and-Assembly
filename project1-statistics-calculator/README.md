# MIPS Statistics Calculator

## Description

This MIPS assembly program calculates various statistics from user-input integers. The program accepts up to 25 integers ranging from -10 to 10 and provides comprehensive statistical analysis along with a visual frequency representation.

## Features

- Accepts up to 25 integer inputs
- Valid input range: -10 to 10
- Input termination using sentinel value (0)
- Calculates key statistics:
  - Total count of input values
  - Maximum value
  - Minimum value
  - Integer mean (average)
  - Mode (most frequent value)
  - Sum of all values
- Generates a visual bar graph showing frequency distribution

## Usage

1. Run the program
2. Enter integers one at a time (range: -10 to 10)
3. Enter 0 when finished to see results
4. The program will display all statistics and generate a frequency bar graph

## Input Requirements

- Only integers between -10 and 10 are accepted
- Maximum of 25 numbers can be entered
- Input must be terminated with 0 (sentinel value)
- Same number can be entered multiple times
- All input is assumed to be valid (no error checking)

## Output Format

The program outputs:

```
The number of values input: [count]
Maximum Value: [max]
Minimum Value: [min]
Mean: [average]
Mode: [most frequent]
Sum: [total]

[Bar Graph]
Program completed
```

The bar graph displays each value and its frequency using '+' symbols, where each '+' represents one occurrence of that value.

## Technical Details

- Written in MIPS assembly language
- Uses two arrays:
  - Main array to store input values
  - Frequency array to track occurrences of each value
- Implements various loops and conditional branches for statistical calculations
- Memory-efficient implementation using registers for temporary storage

## Program Structure

1. Data Section

   - Includes all necessary strings and arrays
   - Predefined storage for up to 25 integers
   - Frequency array for counting occurrences

2. Text Section
   - Main input loop with sentinel check
   - Statistics calculation procedures
   - Output formatting and display
   - Bar graph generation

## Notes

- The program assumes all input is valid
- Zero (0) is not included in the statistics as it's used as the sentinel value
- If multiple values have the same highest frequency, the larger value is chosen as the mode

## Author

Sayed Abdul Ahad Ibrahimi

## Date

February 19, 2023
