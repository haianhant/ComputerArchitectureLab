# Laboratory Exercise 5, Assignment 1 
.data 
test: .asciz "Hello World" 
.text 
	li  a7, 4 
	la  a0, test 
	ecall