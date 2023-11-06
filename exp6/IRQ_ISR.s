

				PRESERVE8
				GET 2440addr.inc
		
_ISR_STARTADDRESS	EQU 0x301fff00
;本实验定义的RAM是从0x3000 0000开始，size为：0x20 0000，把自定义中断向量放在RAM的高端，从0x301fff00开始。

				AREA  IRQ_ISR, CODE, READONLY
			
IRQ_Handler     PROC
                EXPORT  IRQ_Handler

IsrIRQ
				sub	sp,sp,#4       		;reserved for PC保留一个堆栈单元，用于存放PC的值，为出栈到PC做准备
				stmfd	sp!,{r8-r9}

				ldr	r9,=INTOFFSET		;INTOFFSET 寄存器的值说明了INTPND寄存器中哪一个IRQ模式的中断请求有效
				ldr	r9,[r9]
				ldr	r8,=HandleEINT0		;获取自定义IRQ向量表的首地址，即EINT0对应的地址
				add	r8,r8,r9,lsl #2		;自定义IRQ向量表的首地址+对应的偏移量
				ldr	r8,[r8]				;从对应的IRQ向量表中取得中断服务程序入口地址
				str	r8,[sp,#8]			;把获得的中断服务程序入口地址存入预留的堆栈单元中
				ldmfd	sp!,{r8-r9,pc}	;出栈操作，恢复r8和r9的原始值，并把中断服务程序入口地址弹入到PC中，转到对应中断服务程序执行。

                ENDP			
			
;=============用于自定义IRQ中断向量设置==============
				ALIGN

				AREA RamData, DATA, READWRITE

				^   _ISR_STARTADDRESS		; _ISR_STARTADDRESS=0x33FF_FF00，中断向量从0x33FF_FF00开始存放
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
			