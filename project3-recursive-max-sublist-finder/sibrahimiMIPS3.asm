# Programmer:	Sayed Abdul Ahad Ibrahimi
# Date:		04/18/2023
#
# Program Description:	This program prompts the user to enter the size of a sublist 
#						and then finds the maximum value in the sublist. The sublist 
#						is a predefined list of integers.
#
# Input Description:	The program prompts the user to enter an integer between 1 
#						and 50, which represents the size of the sublist.
#
# Output Description:	The program outputs the maximum value of the sublist.
#----------------------------------------------------------------------------------#
# data section
		.data
		
list:		.word		0 45 -20 74 5 24 30 -70 89 49 21 41 57 23 18 10 25 77 72 
						38 27 65 51 67 91 93 71 -2 8 37 46 95 88 -55 80 96 13 100 
						12 90 16 64 22 50 97 68 34 60 73 7
sizePrompt:	.asciiz		"Enter the size of the sublist (1-50): "
maxVal:		.asciiz		"The maximum value of the sublist is "
newline:	.asciiz		"\n"
#----------------------------------------------------------------------------#
		.text
		
		.globl main

main:
	
	li 		$v0, 4				# syscall to print prompt for sublist size
	la 		$a0, sizePrompt
    syscall
    	
    li		$v0, 5				# v0 stores user's input
	syscall
    	
    move 	$a0, $v0         	# argument 1 (size of the sublist)
    	
    la 		$a1, list      		# argument 2 (load the address of the first element)
    	
    jal 	findMax         	# recursively find maximum value in sublist
    	
    move	$t0, $v0			# move the returned value (maximum value) to $t0

    li 		$v0, 4             	# syscall to print a new line
	la 		$a0, newline
    syscall
    	
    li 		$v0, 4             	# syscall to print maximum value
	la 		$a0, maxVal
    syscall
    	
    li		$v0, 1			
	move 		$a0, $t0
	syscall
    	
    						
	li		$v0, 10				# syscall to halt the program
	syscall


# Description:	The findMax function is a recursive function that finds the maximum 
#				value in a sublist. It takes two parameters, the size of the sublist 
#				and a pointer to the sublist. The function returns the maximum value 
#				in the sublist.
# Parameters:	a0: size of the sublist
#				a1: pointer to the first element of the sublist
# Return:		v0: maximum value in the sublist

	.data

	.text
	
findMax:

					
	subu		$sp, $sp, 32		# create stack frame

	sw			$ra, 20($sp)		# store return address

	sw			$fp, 16($sp)		# store frame pointer

	addu		$fp, $sp, 28		# reset frame pointer
								
	sw			$a0, -4($fp)		# store argument (size of the sublist); same as 24($sp)
	
	sw			$a1, 0($fp)			# store the address of the sublist; same as 28($sp)
	
	lw 			$t0, 0($a1)       	# load first value of sublist
	
	sw			$t0, 12($sp)		# store the first value as local variable	
	
	li			$t2, 1				# load 1 into $t2
	
	beq 		$a0, $t2, end      	# base case: sublist has only one element
	
	addi 		$a0, $a0, -1    	# decrement size of sublist by one
    	
    addi 		$a1, $a1, 4     	# increment address of the list to next value in sublist
	
	jal 		findMax				# recursively find maximum value in sublist
	
	
	lw 			$t1, 12($sp)       	# load the next value from recursive call
	
    bge 		$t1, $v0, setMax    # compare first value with maximum value
	
	j			end2				# jump to end2
	
setMax:
    	move    $v0, $t1        	# update maximum value
    	j 		end2				# jump to end2

end:
	
	lw 			$v0, 12($sp)		# load the first value as a max value into $v0
end2:
	lw			$ra, 20($sp)		# load the return address
	lw			$fp, 16($sp)		# load the frame pointer
	addu		$sp, $sp, 32		# delete the stack frame
	jr			$ra					# jump back to main's address
