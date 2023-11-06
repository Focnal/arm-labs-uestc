	AREA AVG_FILTERING, CODE, READONLY
	ENTRY start
start
	mov r10, #6
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

	mov r0,#6
	ldr r2, =0x40000000
	; -----------------------
	bl 	bubble_sort
	bl 	get_avg
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
	

get_avg
	push {r0, r2, r3, r4, r5, lr}
	mov r5, r0
	mov r4, #0
sum_loop
	cmp r0, #2
	ble end_sum
	sub r0, r0, #1
	
	
	ldr r3, [r2, #4]!
	add r4, r4, r3
	b	sum_loop
end_sum
	cmp r5, #2
	beq end_get_avg
	sub r5, r5, #2
	mov r1, #0
	
division_loop
	cmp r4, r5
	blt end_get_avg
	sub r4, r4, r5
	add r1, r1, #1
	b 	division_loop
	
end_get_avg
	pop {r0, r2, r3, r4, r5, lr}

quit
	b	quit
	NOP
	END