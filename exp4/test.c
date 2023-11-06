
__asm int fun(int a, int b, int c, int d, int e, int f)
{
    add r0, r0, r1 // r0 = a + b
    add r0, r0, r2 // r0 = a + b + c
    add r0, r0, r3 // r0 = a + b + c + d

    ldmfd sp!, {r1, r2}
    mul r3, r0, r1 // r3 = (a + b + c + d) * e
		mov r0, r3		 // r0 = r3
    sub r0, r0, r2 // r0 = (a + b + c + d) * e - f

    bx lr // Return
}


int main(void)
{
	fun(1,2,3,4,5,6);
	return 0;
}