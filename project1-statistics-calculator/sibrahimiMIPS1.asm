# Programmer:	Sayed Abdul Ahad Ibrahimi
# Date:		02/19/2023
#
# Program Description:
#			This program takes input from the user in the form of a list of up to 25 integers, 
#			ranging from -10 to 10. The input is terminated with a sentinel value of 0. 
#			The program then calculates and displays various statistics about the input data.
#
#			First, the program displays the total number of values entered by the user, 
#			excluding the sentinel value. It then determines and displays the maximum 
#			and minimum values in the list.
#
#			Next, the program calculates the mean of the input values and displays it as an integer. 
#			To calculate the mean, the program first calculates the sum of all the input values.
#
#			The program then determines the mod. If multiple values appear with the same 
#			highest frequency, the mode is the one with the highest value.
#
#			Finally, the program displays a bar graph that shows the frequency of each value 
#			in the input list. The graph consists of a line for each input value that is 
#			represented by a '+' character. If an input value does not appear in the list, 
#			no line is printed for it. 
#			The program then displays a message indicating that it has completed successfully.
#
# Input Description:
#		    	The program takes input from the user in the form of a list of up to 25 positive 
#			and/or negative integers. The user is prompted to enter each integer individually and 
#			the list should be terminated with a zero (the sentinel value). The program will assume 
#			that all data input is correct and in the valid range of positive or negative integers 
#			between 1 and 10. The same number may appear multiple times in the list. 
#			The user is prompted for the input only once.
#
# Output Description:
# 			The program outputs several statistics and a bar graph based on the input provided by the user. 
#			The output includes:
#				- The number of values input (not including the sentinel value).
#				- The maximum value from the list of input values.
#				- The minimum value from the list of input values.
#				- The integer mean (average) of the input values.
#				- The mode (the value seen most often) of the input values.
#				- The sum of all the input values.
#				- A bar graph that shows the frequency of each value.
#
#			The bar graph is printed to the console and displays the frequency of each value in a vertical
#	 		bar chart format. The chart uses the '+' symbol to represent each occurrence of a value. 
#			For example, if the value 1 was seen twice, the chart would have two '+' symbols 
#			next to the value 1. If a value is not present in the input, the chart displays no 
#			symbols for that value.
#
#			The program also outputs a message "Program completed" after the graph indicating that 
#			the program has terminated properly.
#-------------------------------------------------------------------------------------------#
# data section
		.data
outstr:		.asciiz		"Enter upto 25 +/- integers with a range of 1 to 10: "
array:		.word		1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
freqArray:	.word		0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
numOfInputs:    .asciiz		"The number of values input: "
max:		.asciiz		"Maximum Value: "
min:		.asciiz		"Minimum Value: "
mean:		.asciiz		"Mean: "
mode:		.asciiz		"Mode: "
sum:		.asciiz		"Sum: "
endl:		.asciiz		"\n"
double_endl:	.asciiz		"\n\n"
complete:	.asciiz		"Program completed"
#----------------------------------------------------------------------------#
# text section, which is the executable code

		.text

# The main starts here
		.globl main

main:	
		
						# syscall to print the prompt
	li		$v0, 4
	la		$a0, outstr
	syscall

	li		$t0, 0			# t0 holds the 0 to compare if the user's input is a zero
	li		$t1, 0			# t1 holds the offset for array
	li		$t2, 4			# t2 holds the 4 bytes which is multiplied to index each iteration
	li		$t6, 0			# t6 holds the sum of all values
	li		$t8, 0			# t8 is counter which counts the number of input value
							# later used to get the mean (sum/num of input)
	li		$t9, 1			# adder
	li		$s0, -10		# holds the MIN_VALUE which is -10 (const) 
	li		$s1, 0			# holds the index of the array
	li		$s2, 0			# holds the offset for freqArray
	li		$s3, 0			# holds the frequency of each input value
	
Do:								# Do while loop, since 1st input is moved to min (t4) and max (t5))
	li		$v0, 5				# v0 stores user's input
	syscall
	move		$t7, $v0		# holds the current input value
	
	beq		$t7, $t0, continue  # while input is not zero, keep looping
	
	sw		$t7, array($t1)		# store t7 into array[$t1]
	
	sub		$s1, $t7, $s0		# subtract MIN_VALUE from value to get the index
	
	mul		$s2, $s1, $t2		# multiply by 4 to get the offset for freqArray
	
	lw		$s3, freqArray($s2)	# load the value to s3
	
	add		$s3, $s3, $t9		# increment by 1
	
	sw		$s3, freqArray($s2)	# store it in freqArray
	
	move		$t5, $t7		# t5 holds the maximum value
	move		$t4, $t7		# t4 holds the minimum value
	
	add		$t1, $t1, $t2		# update the index for array
	add		$t6, $t6, $t7		# update the sum of all values
	add		$t8, $t8, $t9		# update the counter
	
loop:
	li		$v0, 5				# v0 stores user's input
	syscall
	move		$t7, $v0
	
	beq		$t7, $t0, continue  # while input is not zero, keep looping
	
	sw		$t7, array($t1)		# store t7 into array[t1]
	
	sub		$s1, $t7, $s0		# subtract MIN_VALUE from value to get the index
	
	mul		$s2, $s1, $t2		# multiply by 4 to get the offset for freqArray
	
	lw		$s3, freqArray($s2)	# load the value to s3
	
	add		$s3, $s3, $t9		# increment by 1
	
	sw		$s3, freqArray($s2)	# store it in freqArray
	
	add		$t1, $t1, $t2		# update the index for array
	add		$t6, $t6, $t7		# update the sum of all values
	add		$t8, $t8, $t9		# update the counter
	
	bgt		$t7, $t5, maxValue	# if greater than maxValue, jump
	blt		$t7, $t4, minValue	# if less than minValue, jump
	
	j		loop				# back to loop

maxValue:
	move 		$t5, $t7		# update the maxValue
	
	blt		$t7, $t4, minValue	# Check if the same value is less than minValue, then jump
	
	j		loop				# back to loop

minValue:
	move 		$t4, $t7		# update the minValue
	
	j		loop				# back to loop
		
continue:
	div		$t6, $t8		# divide the sum by the number of input values
	mflo		$s7			# move the integer to s7 (the Mean)
	
findMode:
	li		$s1, 0			# holds the mode
	li		$s2, 0			# holds the modeCount
	li		$s3, 0			# holds the index of the freqArray
	li		$s4, 1			# adder
	li		$s5, 0			# counter i starts from minValue and ends at maxValue
	move		$s5, $t4		# move the minValue to i (s5)
	li		$t2, 4			# t2 holds the 4 bytes which is multiplied to s3 after every iteration
	li		$t1, 0			# holds the offset for freqArray
	li		$t3, 0			# holds the frequency of each input value
	
modeLoop:
	
	bgt		$s5, $t5, print		# if counter i is greater than maxValue, then jump to print
	
	sub		$s3, $s5, $s0		# subtract MIN_VALUE from value to get the index
	
	mul		$t1, $s3, $t2		# multiply by 4 to get the offset for freqArray
	
	lw		$t3, freqArray($t1)	# load the frequency of value to t3
	
	blt		$t3, $s2, skip		# if the frequency of value is less than modeCount, then skip
	
	move		$s1, $s5		# moves the value to the mode
	lw		$s2, freqArray($t1)	# move the frequency of value to modeCount
	
	add		$s5, $s5, $s4		# increment the i counter (check the next value)
	
	j		modeLoop			# back to modeLoop

skip:	
	add		$s5, $s5, $s4		# increment the i counter (check the next value)
	
	j		modeLoop			# back to modeLoop
	
print:	
						# syscall to print a new line
	li		$v0, 4
	la		$a0, endl
	syscall
						# syscall to print the number of values input
	li		$v0, 4
	la		$a0, numOfInputs
	syscall
	
	li		$v0, 1
	move 		$a0, $t8
	syscall
	
	li		$v0, 4
	la		$a0, endl
	syscall
	
	
						# syscall to print the maximum value
	li		$v0, 4			 
	la		$a0, max
	syscall					
	
	li		$v0, 1
	move 		$a0, $t5
	syscall					
	
	li		$v0, 4
	la		$a0, endl
	syscall
	
	
						# syscall to print the minimum value
	li		$v0, 4
	la		$a0, min
	syscall
	
	li		$v0, 1
	move 		$a0, $t4
	syscall					
	
	li		$v0, 4
	la		$a0, endl
	syscall
	
	
						# syscall to print the mean
	li		$v0, 4
	la		$a0, mean
	syscall
	
	li		$v0, 1
	move 		$a0, $s7
	syscall
	
	li		$v0, 4
	la		$a0, endl
	syscall
	
	
						# syscall to print the mode
	
	li		$v0, 4
	la		$a0, mode
	syscall
	
	li		$v0, 1
	move 		$a0, $s1
	syscall
	
	li		$v0, 4
	la		$a0, endl
	syscall
	
	
						# syscall to print the sum of all values
	li		$v0, 4
	la		$a0, sum
	syscall
	
	li		$v0, 1
	move 		$a0, $t6
	syscall				
	
	li		$v0, 4
	la		$a0, double_endl
	syscall
					
					
	li		$s3, 0			# holds the index of the freqArray
	li		$s4, 1			# adder
	li		$s5, 0			# counter i starts from minValue and ends at maxValue
	li		$s6, 0			# counter j starts from zero and counts the frequency of each value
	move		$s5, $t4		# move the minValue to i (s5)
	li		$t2, 4			# holder for 4 bytes
	li		$t1, 0			# holds the offset for freqArray
	li		$t3, 0			# holds the frequency of each input value
	
	
for_loop_i:
	
	beq		$s5, $zero, skipZero	# if counter i is equal to 0, then jump to skipZero
	
	bgt		$s5, $t5, done			# if counter i is greater than maxValue, then jump to print
	
									# syscall to print the value
	move 		$a0, $s5
    	li 		$v0, 1
    	syscall
    	
    								# syscall to print the space
        li 		$a0, ' '
        li 		$v0, 11
        syscall
    	
    	sub		$s3, $s5, $s0		# subtract MIN_VALUE from value to get the index
	
	mul		$t1, $s3, $t2			# multiply by 4 to get the offset for freqArray
	
	lw		$t3, freqArray($t1)		# load the value to t3
    	
 for_loop_j:
	
	bge		$s6, $t3, end_for_j		# if the counter j is greater than or equal to maxValue, end_for_j
	
									# syscall to print '+' character
        li 		$a0, '+'
        li 		$v0, 11
        syscall
        
        add		$s6, $s6, $s4		# increment the j counter
        
        j		for_loop_j			# back to for_loop_j
        
end_for_j:
									# syscall to print a new line
        li 		$v0, 4
    	la		$a0, endl
    	syscall
	
	add		$s5, $s5, $s4	# increment the i counter (move to next frequency of the value)
	
	li		$s6, 0			# resets the j counter back to zero
	
	j		for_loop_i		# loop back to for_loop_i
	
skipZero:

	add		$s5, $s5, $s4	# increment the i counter (move to next frequency of the value)
	
	j		for_loop_i		# loop back to for_loop_i
	
	
done:
							# syscall to print a new line
	li 		$v0, 4
    	la		$a0, endl
    	syscall
	
	li		$v0, 4
	la		$a0, complete
	syscall
							# syscall to print a new line
	li 		$v0, 4
    	la		$a0, endl
    	syscall
	
	# Last step is to halt the program
	li		$v0, 10		# 10 = system call code for halting program
	syscall				# call system function 10: exit
