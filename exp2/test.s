	AREA MID_FILTERING, CODE
	ENTRY
start
	mov r10, #7
	ldr r2, =0x40000400
	mov sp, r2
	ldr r2, =0x40000000
init_loop
	cmp r10, #0
	beq end_init
	str r10,[r2], #4
	sub r10, r10, #1
	b 	init_loop
end_init

	mov r0,#7
	ldr r2, =0x40000000
	; -----------------------
	bl 	bubble_sort
	bl 	get_mid
	b	quit

bubble_sort
	push {r0, r3, r4, r5, r6, lr}

loop_i
	sub r0, r0, #1
	cmp r0,#0
	ble end_bubble_sort

	mov r3, #0

loop_j
	cmp 	r3, r0
	beq 	loop_i
	
	mov 	r6, #0
	add 	r6, r2, r3, lsl #2
	ldr 	r4, [r6]
	ldr 	r5,	[r6, #4]
	
	cmp 	r4, r5
	strgt 	r4, [r6, #4]
	strgt 	r5, [r6]
	
	add 	r3, r3, #1
	b loop_j

	b loop_i
	
end_bubble_sort
	pop {r0, r3, r4, r5, r6, lr}
	

get_mid
	push {r0, lr}
	lsr r0, #1
	
	ldr r1, [r2, r0, lsl #2]
	
	pop {r0, lr}

quit
	b	quit
	NOP
	END