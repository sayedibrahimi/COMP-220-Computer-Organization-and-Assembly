# Programmer:	Sayed Abdul Ahad Ibrahimi
# Date:		04/02/2023
#
# Program Description:	This program simulates a gas pump that takes user input to sell gas. 
#			The program prompts the user to choose between two payment options, and 
#			then select the type of gas and the number of gallons required. 
#			The program calculates the total cost, subtracting 10 cents per gallon 
#			if the user chooses to pay with the SmahtPay option. The final cost is 
#			then rounded to the nearest penny, and a receipt is displayed that 
#			includes all of the input information and the final cost of the gas. 
#			If the total cost is more than $50.00, an advertising message is also displayed.
#
# Input Description:	The program prompts the user to enter three inputs. 
#			First, the user must select between two payment options by entering 
#			the corresponding integer value (1 for SmahtPay or 2 for credit purchase). 
#			Second, the user must select the type of gas by entering the 
#			corresponding integer value (1 for Regular, 2 for Plus, or 3 for Super).
#			Third, the user must enter the number of gallons required as a floating-point number.
#
# Output Description:	The program outputs a receipt that displays the input information, 
#			including the gas type, number of gallons, and payment method. 
#			The final cost is displayed, rounded to the nearest penny, 
#			and adjusted by a 10 cents per gallon discount if the user 
#			selects the SmahtPay payment option. If the final cost is more 
#			than $50.00, an advertising message is displayed as well. 
#			Finally a message is displayed when the user ends the pump simulation. 
#			All output is presented in a formatted and easy-to-read manner.
#-------------------------------------------------------------------------------------------#
# data section
		.data
paymentMethod:	.asciiz		"Enter payment method (1 = SmahtPay, 2 = Credit, 3 = End): "
fuel:			.asciiz		"Enter gas type (1 = Regular, 2 = Plus, 3 = Super): "
numOfGallons:	.asciiz		"Enter number of gallons: "
regularPrice:	.float		3.259
plusPrice:		.float		3.579
superPrice:		.float		4.169
SmahtPayDisc:	.float		0.1
hundred:		.float		100.0
thousand:		.float		1000.0
fifty:			.float		50.00
receipt:		.asciiz 	"Thank you for shopping at Cowberland Farms!\n"
regular:		.asciiz 	"Fuel type:    Regular\n"
plus:			.asciiz 	"Fuel type:    Plus\n"
super:			.asciiz 	"Fuel type:    Super\n"
numGallon:		.asciiz		"Gallons:      "
costPerGallon:	.asciiz		"Cost/gallon:  "
credit:			.asciiz 	"Credit/debit: Credit\n"
SmahtPay:		.asciiz 	"Credit/debit: SmahtPay\n"
total:			.asciiz 	"Total due:    "
membership:		.asciiz 	"Check out our special Awards Membership!\n"
shutdown:		.asciiz		"pump is shutdown"
newline:		.asciiz 	"\n"
#----------------------------------------------------------------------------#
		.text
		
		.globl main

main:	
						
Loop:
    					
    	li 		$v0, 4				# prompt for payment method
    	la 		$a0, paymentMethod
    	syscall
    
    	li 		$v0, 5				# $v0 holds user input
    	syscall
    
    	move 		$t0, $v0		# move user input (payment method) to $t0
    				
    	beq 		$t0, 3, End		# end the while loop if the input is 3
    
    	jal		FuelType			# here is a procedure call (FuelType)
    
    	mov.s 		$f1, $f0		# move the returned price per gallon to $f1
    	move		$t1, $v0		# move the returned gas type to $t1	
    	
    	bne		$t0, 1, Skip		# if the payment method is not SmahtPay jump to Skip
    						
    								# otherwise continue
    	
    	mov.s 		$f12, $f1		# argument 1 (price per gallon)
    	
    	jal		Discount			# here is a procedure call (Discount)
    	
    	mov.s		$f1, $f0		# move the returned dicounted price per gallon to $f1
    	
Skip:								# continue the loop
								
    	li 		$v0, 4				# prompt for number of gallons
    	la 		$a0, numOfGallons
    	syscall
    
    	li 		$v0, 6				# $f0 holds user input
    	syscall
    
    	mov.s 		$f2, $f0      	# move user input (number of gallons) to $f2
    	
    	li 		$v0, 4				# syscall to print a new line
    	la 		$a0, newline
    	syscall
   	
    	li 		$v0, 4				# syscall to print the thank you note on the receipt
    	la 		$a0, receipt
    	syscall
    	
    	beq 		$t1, 1, PrintRegular	# if the input is 1 jump to PrintRegular 
    	beq 		$t1, 2, PrintPlus		# if the input is 2 jump to PrintPlus 
    	beq 		$t1, 3, PrintSuper		# if the input is 3 jump to PrintSuper 
    	
PrintRegular:

	li 		$v0, 4				# syscall to print regualr fuel type 
    	la 		$a0, regular
    	syscall
    	
    	j		Continue1		# jump to Continue1
    	
PrintPlus:

	li 		$v0, 4				# syscall to print plus fuel type 
    	la 		$a0, plus
    	syscall
    	
    	j		Continue1		# jump to Continue1
    	
PrintSuper:

	li 		$v0, 4				# syscall to print super fuel type
    	la 		$a0, super
    	syscall
    	
    	j		Continue1		# jump to Continue1

Continue1:						# continue the loop
    	
    	li 		$v0, 4			# syscall to print number of gallons label
    	la 		$a0, numGallon
    	syscall
    
    	mov.s		$f12, $f2	# syscall to print number of gallons
    	li 		$v0, 2			
    	syscall
    	
    	li 		$v0, 4			# syscall to print a new line
    	la 		$a0, newline
    	syscall
    	
    	li 		$v0, 4			# syscall to print cost/gallon label
    	la 		$a0, costPerGallon
    	syscall
    	
    	mov.s		$f12, $f1	# syscall to print cost/gallon
    	li 		$v0, 2			
    	syscall
    	
    	li 		$v0, 4			# syscall to print a new line
    	la 		$a0, newline
    	syscall
    	
    	beq		$t0, 1, PrintSmahtPay	# if the payment method is SmahtPay jump to PrintSmahtPay
	
	li 		$v0, 4				# otherwise syscall to print payment method as credit
    	la 		$a0, credit
    	syscall
    	
    	j		Continue2		# jump to Continue2
    	
PrintSmahtPay:
	li 		$v0, 4				# syscall to print SmahtPay
    	la 		$a0, SmahtPay
    	syscall
    	
Continue2:						# continue the loop
			
    	mov.s		$f12, $f2 	# argument 1 (number of gallons)
    	
    	mov.s		$f13, $f1	# argument 2 (price per gallon)
    	
    	jal		TotalCost		# here is a procedure call (TotalCost)
	
	j 		Loop				# loop back

End:	

	li 		$v0, 4				# syscall to print a new line
    	la		$a0, newline
    	syscall
	
	li		$v0, 4				# syscall to display the pump is shutdown
	la		$a0, shutdown
	syscall
	
	li 		$v0, 4				# syscall to print a new line
    	la		$a0, newline
    	syscall
								# Last step is to halt the program
	li		$v0, 10				# 10 = system call code for halting program
	syscall						# call system function 10: exit


# Description:	Procedure to prompt the user for gas type and return the price per gallon with the gas type
# Parameters:	none
# Return:	$f0 (price per gallon) and $v0 (gas type)

	.data

	.text
	
FuelType:

	li 		$v0, 4			# prompt for gas type
    	la 		$a0, fuel
    	syscall
    	
    	li 		$v0, 5			# $v0 stores user input
    	syscall
    
    	beq 		$v0, 1, Regular		# jump to Regular if the input is 1
    	beq 		$v0, 2, Plus		# jump to Plus if the input is 2
    	beq 		$v0, 3, Super		# jump to Super if the input is 3
    	
Regular:

	l.s 		$f0, regularPrice	# load the regular price into $f0
    	j 		return
    	
Plus:

	l.s 		$f0, plusPrice		# load the plus price into $f0
    	j 		return
    	
Super:

	l.s 		$f0, superPrice		# load the super price into $f0
    	j 		return

return:	
					
	jr		$ra			# jump back to main's address


# Description:	Procedure to reduce the price per gallon by 0.1 and 
#		return the float without extra zeros after 3 decimal place
# Parameters:	$f12 (price per gallon)
# Return: 	$f0 (reduced price per gallon)

	.data
	
	.text

Discount:
	
	l.s		$f7, SmahtPayDisc	# load 0.1 into $f7
	
	sub.s		$f0, $f12, $f7		# $f0 = cost per gallon - 0.1
	
	l.s		$f3, thousand		# load 1000.0 into $f30
	
	mul.s 		$f0, $f0, $f3		# $f0 = $f0 * 1000.0
	
	cvt.w.s 	$f4, $f0		# convert to float to integer
	
	cvt.s.w 	$f0, $f4		# convert back to float
	
	div.s		$f0, $f0, $f3		# divide by 1000.0
    		
	jr		$ra			# jump back to main's address


# Description:	Procedure call to display the total cost rounded to the 2 digits after decimal place and
#		print membership award if the total cost is > 50.00
# Parameters:	$f12 (number of gallons) and $f13 (price per gallon)
# Return: 	none

	.data

	.text
	
TotalCost:
	
	mul.s		$f0, $f12, $f13		# $f0 = gallons * price
	
	l.s		$f3, hundred			# load 100.0 into $f3
	
	mul.s 		$f0, $f0, $f3		# $f0 = $f0 * 100.0
	
	cvt.w.s 	$f4, $f0			# convert float to integer
	
	cvt.s.w 	$f0, $f4			# convert back to float
	
	div.s		$f0, $f0, $f3		# divide by 100.0
	
	li 		$v0, 4					# syscall to print the total cost label
    	la 		$a0, total
    	syscall
	
	mov.s		$f12, $f0			# syscall to print the total cost
    	li 		$v0, 2			
    	syscall
	
	li 		$v0, 4					# syscall to print a new line
    	la 		$a0, newline
    	syscall
    	
    	li 		$v0, 4				# syscall to print a new line
    	la 		$a0, newline
    	syscall
	
	l.s		$f3, fifty				# load 50.00 into $f3
	
	c.lt.s 		$f0, $f3			# if $f0 < $f3 (cc flag 1)
	
	bc1f 		PrintMembership		# if cc flag true (1) jump to PrintMembership (cc flag 0 is assumed)
	
	jr		$ra
	
PrintMembership:
	
	li 		$v0, 4					# syscall to print the membership award	
    	la 		$a0, membership
    	syscall
	
	li 		$v0, 4					# syscall to print a new line
    	la 		$a0, newline
    	syscall
	
	jr		$ra						# jump back to main's address
		
