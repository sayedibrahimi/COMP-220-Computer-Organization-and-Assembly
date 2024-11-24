# MIPS Gas Pump Simulator

## Description

A MIPS assembly program that simulates a gas station pump interface. The program handles fuel purchases, payment methods, and provides detailed receipts with optional discounts for SmahtPay users.

## Features

- Multiple payment options:
  - SmahtPay (includes $0.10/gallon discount)
  - Credit/Debit
- Three fuel types with different prices:
  - Regular ($3.259/gallon)
  - Plus ($3.579/gallon)
  - Super ($4.169/gallon)
- Detailed receipt generation
- Special membership advertisement for purchases over $50.00
- Price calculations rounded to nearest penny
- Pump shutdown functionality

## Usage

1. Select payment method:
   - Enter 1 for SmahtPay
   - Enter 2 for Credit/Debit
   - Enter 3 to end simulation
2. Choose fuel type:
   - Enter 1 for Regular
   - Enter 2 for Plus
   - Enter 3 for Super
3. Enter desired number of gallons
4. Review receipt with transaction details

## Input Requirements

- Payment method: Integer (1, 2, or 3)
- Fuel type: Integer (1, 2, or 3)
- Gallons: Floating-point number
- All inputs must be valid numbers within specified ranges

## Output Format

The program generates a receipt containing:

```
Thank you for shopping at Cowberland Farms!
Fuel type:    [Selected fuel]
Gallons:      [Amount requested]
Cost/gallon:  [Price per gallon]
Credit/debit: [Payment method]
Total due:    [Final amount]

[Optional membership message if purchase > $50.00]
```

## Technical Details

- Written in MIPS assembly language
- Implements floating-point operations
- Uses procedures for modular code organization:
  - `FuelType`: Handles fuel selection and pricing
  - `Discount`: Calculates SmahtPay discounts
  - `TotalCost`: Computes final price and handles receipt generation
- Rounds calculations to ensure accurate pricing
- Includes error prevention for invalid inputs

## Program Structure

1. Data Section

   - Constant values for fuel prices
   - Text strings for user interface
   - Floating-point values for calculations

2. Text Section
   - Main loop for transaction processing
   - Separate procedures for specific functionalities
   - Receipt generation and display

## Notes

- SmahtPay discount is automatically applied when selected
- Prices are displayed with 3 decimal places
- Final totals are rounded to 2 decimal places
- Program continues running until user selects shutdown option (3)

## Author

Sayed Abdul Ahad Ibrahimi

## Date

April 2, 2023
