

				PRESERVE8
				GET 2440addr.inc
		
_ISR_STARTADDRESS	EQU 0x301fff00
;��ʵ�鶨���RAM�Ǵ�0x3000 0000��ʼ��sizeΪ��0x20 0000�����Զ����ж���������RAM�ĸ߶ˣ���0x301fff00��ʼ��

				AREA  IRQ_ISR, CODE, READONLY
			
IRQ_Handler     PROC
                EXPORT  IRQ_Handler

IsrIRQ
				sub	sp,sp,#4       		;reserved for PC����һ����ջ��Ԫ�����ڴ��PC��ֵ��Ϊ��ջ��PC��׼��
				stmfd	sp!,{r8-r9}

				ldr	r9,=INTOFFSET		;INTOFFSET �Ĵ�����ֵ˵����INTPND�Ĵ�������һ��IRQģʽ���ж�������Ч
				ldr	r9,[r9]
				ldr	r8,=HandleEINT0		;��ȡ�Զ���IRQ��������׵�ַ����EINT0��Ӧ�ĵ�ַ
				add	r8,r8,r9,lsl #2		;�Զ���IRQ��������׵�ַ+��Ӧ��ƫ����
				ldr	r8,[r8]				;�Ӷ�Ӧ��IRQ��������ȡ���жϷ��������ڵ�ַ
				str	r8,[sp,#8]			;�ѻ�õ��жϷ��������ڵ�ַ����Ԥ���Ķ�ջ��Ԫ��
				ldmfd	sp!,{r8-r9,pc}	;��ջ�������ָ�r8��r9��ԭʼֵ�������жϷ��������ڵ�ַ���뵽PC�У�ת����Ӧ�жϷ������ִ�С�

                ENDP			
			
;=============�����Զ���IRQ�ж���������==============
				ALIGN

				AREA RamData, DATA, READWRITE

				^   _ISR_STARTADDRESS		; _ISR_STARTADDRESS=0x33FF_FF00���ж�������0x33FF_FF00��ʼ���
HandleReset 	#   4
HandleUndef 	#   4
HandleSWI		#   4
HandlePabort    #   4
HandleDabort    #   4
HandleReserved  #   4
HandleIRQ		#   4
HandleFIQ		#   4

;Do not use the label 'IntVectorTable',
;The value of IntVectorTable is different with the address you think it may be.
;IntVectorTable
;@0x33FF_FF20
HandleEINT0		#   4
HandleEINT1		#   4
HandleEINT2		#   4
HandleEINT3		#   4
HandleEINT4_7	#   4
HandleEINT8_23	#   4
HandleCAM		#   4		; Added for 2440.
HandleBATFLT	#   4
HandleTICK		#   4
HandleWDT		#   4
HandleTIMER0 	#   4
HandleTIMER1 	#   4
HandleTIMER2 	#   4
HandleTIMER3 	#   4
HandleTIMER4 	#   4
HandleUART2  	#   4
;@0x33FF_FF60
HandleLCD 		#   4
HandleDMA0		#   4
HandleDMA1		#   4
HandleDMA2		#   4
HandleDMA3		#   4
HandleMMC		#   4
HandleSPI0		#   4
HandleUART1		#   4
HandleNFCON		#   4		; Added for 2440.
HandleUSBD		#   4
HandleUSBH		#   4
HandleIIC		#   4
HandleUART0 	#   4
HandleSPI1 		#   4
HandleRTC 		#   4
HandleADC 		#   4
;@0x33FF_FFA0			
			
			END
			