# assembly-matrix-row-averages
Assembly program for calculating the average value of each row in a 3×3 matrix.

## About

The program allows the user to enter the elements of the array and calculates the average value of each row. The project was developed as part of university work during the second year of university.

## Key Variables

* array - 3×3 array containing 9 input elements;
* avg1 - average value of the first row;
* avg2 - average value of the second row;
* avg3 - average value of the third row;
* message - message requesting input of array elements;
* result1 - output message for the first row average;
* result2 - output message for the second row average;
* result3 - output message for the third row average;
* newline - line break string;
* si - register used as a pointer to array elements;
* cx - loop counter;
* ax - register used for calculations;
* al - register containing the sum or average value;
* dl - register used as the divisor and for character output.

## Procedures

* calc_averages - calculates and stores the average values of all three rows.
* sum_row - calculates the sum of three elements in the current row and divides the result by 3.
* print_results - displays the calculated average values for all three rows.
* print_number - converts the numerical result to an output character and displays it using a DOS interrupt.

## How to Run

Assemble and run the program using a compatible MASM/TASM environment or DOS-compatible emulator.
After launching the program, enter 9 numerical elements of the 3×3 array.

## Example

For an input matrix:

```text
1 2 3
4 5 6
7 8 9
```

The program calculates:

```text
Average of row 1: 2
Average of row 2: 5
Average of row 3: 8
```
