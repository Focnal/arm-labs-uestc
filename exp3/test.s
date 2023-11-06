	PRESERVE8
	AREA TEST, CODE, READONLY
	IMPORT fun
	ENTRY

main
	ldr r0, =0x40000030
	mov sp, r0
	mov lr, pc
	str lr, [sp, #-4]!
	mov r0, #1
	mov r1, #2
	mov r2, #5
	mov r3, #6
	stmfd sp!, {r2, r3}
	mov r2, #3
	mov r3, #4
	bl fun

	add sp, sp, #8
	ldr pc, [sp], #4
	END