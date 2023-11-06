	AREA TEST, CODE, READONLY
	ENTRY

start
	msr cpsr_f, #0xff
	mrs r0, cpsr
	
	
	
	
quit
	b quit
	END