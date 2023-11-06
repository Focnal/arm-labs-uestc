#define GPBCON (*(volatile unsigned long *)0x56000010)
#define GPBDAT (* (volatile unsigned long *)0x56000014)
#define ROUNDS 60000 //定义循环次数来控制间隔时间
void init()
{
	GPBDAT |= 0x1e0; //将输入数据寄存器设置为0b111100000
	GPBCON |= 0x1555551; //将GPB1设置为输入模式, 除此以外的端口全设置为输出模式
}

void delay() //通过空循环来实现间隔
{
	int i = ROUNDS;
	for(;i>0;i--);
}

void start_cycle_forward()
{
		GPBDAT |= 0x1e0; //让所有灯的端口输出高电平, 即熄灭所有灯
		GPBDAT ^= 0x20; //反转led1端口的位, 使其输出低电平
		delay();
		GPBDAT ^= 0x60; //点亮led2并熄灭led1
		delay();
		GPBDAT ^= 0xc0; //点亮led3并熄灭led2
		delay();
		GPBDAT ^= 0x180; //点亮led4并熄灭led3
		delay();
		GPBDAT ^= 0x100; //熄灭led4
}

void start_cycle_reverse()
{
		GPBDAT |= 0x1e0;
		GPBDAT ^= 0x100;  //点亮led4
		delay();
		GPBDAT ^= 0x180;  //点亮led3并熄灭led4
		delay();
		GPBDAT ^= 0xc0; //点亮led2并熄灭led3
		delay();
		GPBDAT ^= 0x60; //点亮led1并熄灭led2
		delay();
		GPBDAT ^= 0x20; //熄灭led1
}
int main(void)
{
	init();
	while(1)
	{
		if(GPBDAT & 0x2){ //如果GPB1输入为高电平就正向循环点亮led
			start_cycle_forward();
		}
		else
		{
			start_cycle_reverse(); //否则反向循环点亮led
		}
		delay();
	}
	return 0;
}
