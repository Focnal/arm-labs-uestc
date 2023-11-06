#include <stdlib.h>
#include <string.h>
#include <S3C2440.H>  
#include "2440addr.h"

#define U32 unsigned int

static void __irq Key_ISR(void); 

void delay()  
{  
	int i,j;  
	for(i=0;i<10000;i++)  
	{  
		for(j=0;j<50;j++);  
	}  
}  

void key_init(void)
{
	rGPGCON = rGPGCON & (~(0x0FFF)) | (0x0AAA) ;	    //设置EINT[8]-EINT[13]为中断
	rEXTINT1 &= ~(7<<0);	
	rEXTINT1 |= (3<<0);	            //设置EINT[8]边沿触发

	rEXTINT1 &= ~(7<<4);	
	rEXTINT1 |= (3<<4);	            //设置EINT[9]边沿平触发

	rEXTINT1 &= ~(7<<8);	
	rEXTINT1 |= (3<<8);	            //设置EINT[10]边沿平触发
	
	rEXTINT1 &= ~(7<<12);
	rEXTINT1 |= (3<<12);                //设置EINT[11]边沿平触发

	rEXTINT1 &= ~(7<<16);	
	rEXTINT1 |= (3<<16);	            //设置EINT[12]边沿平触发
	
	rEXTINT1 &= ~(7<<20);
	rEXTINT1 |= (3<<20);                //设置EINT[13]边沿平触发
	
	rEINTPEND |= (1<<8)|(1<<9)|(1<<10)|(1<<11)|(1<<12)|(1<<13);        //写1清EINT8和EINT11中断
	rEINTMASK &= ~((1<<8)|(1<<9)|(1<<10)|(1<<11)|(1<<12)|(1<<13));     //使中断不被屏蔽
	pISR_EINT8_23 = (U32)Key_ISR;       //中断服务程序
	EnableIrq(BIT_EINT8_23);            //使能中断
}

void LED_init(void)
{
	GPBCON = 0x155555;      //GBP所有端口都是输出端口
	GPBDAT |= 0x1E0; 
}

void button1press()			//点亮LED1
{
	GPBDAT |= 0x1E0;  
	GPBDAT &= 0x1C0;  //点亮LED1  
}

void button2press()			//点亮LED2
{
	GPBDAT |= 0x1E0;  
	GPBDAT &= 0x1A0;  //点亮LED2  
}

void button3press()			//点亮LED3
{
	GPBDAT |= 0x1E0;  
	GPBDAT &= 0x160;  //点亮LED3  
}

void button4press()			//点亮LED4
{
	GPBDAT |= 0x1E0;  
	GPBDAT &= 0x0E0;  //点亮LED4  
}

void button5press()			//点亮所有LED
{
	//GPBDAT |= 0x1E0; 
	GPBDAT &= 0x0;  
}

void button6press()			//关闭所有LED
{
	GPBDAT |= 0x1E0;  
}


static void __irq Key_ISR(void)      //定义中断服务程序
{
	if(rINTPND==BIT_EINT8_23) {           //INTPND同时只能有一位为1
		
		if(rEINTPEND&(1<<8)) {				      //判断EINT8是否发生中断
			rEINTPEND |= 1<< 8;               //清EINT8中断
			ClearPending(BIT_EINT8_23);				//实验证明，如果不先清零EINTPEND，而是先清零SRCPND、INTPND对应标志位，
																				//EINTPEND对应的标志位会再次引起SRCPND、INTPND对应标志位置1，从而导致第二次中断。
																				//第二次中断后，由于第一次中断中清理了EINTPEND的标志位，所以不会引起第3次中断。
			button1press();
		}

		if(rEINTPEND&(1<<9)) {			
			rEINTPEND |= 1<< 9;
			ClearPending(BIT_EINT8_23);
			button2press();
		}

		if(rEINTPEND&(1<<10)) {			
			rEINTPEND |= 1<< 10;
			ClearPending(BIT_EINT8_23);
			button3press();
		}

		if(rEINTPEND&(1<<11)) {			
			rEINTPEND |= 1<< 11;
			ClearPending(BIT_EINT8_23);
			button4press();
		}

		if(rEINTPEND&(1<<12)) {			
			rEINTPEND |= 1<< 12;
			button5press();
		}

		if(rEINTPEND&(1<<13)) {			
			rEINTPEND |= 1<< 13;
			ClearPending(BIT_EINT8_23);
			button6press();
		}
	}
}

int main()  
{
	LED_init();
	key_init();
	while(1)
	{
		delay();   
	}
}
