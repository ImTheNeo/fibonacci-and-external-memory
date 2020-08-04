#line 1 "C:/Users/asus/Desktop/2256006_fibo_final_of_final/MyProject.c"


sbit LCD_RS at PORTD2_bit;
sbit LCD_EN at PORTD3_bit;
sbit LCD_D4 at PORTD4_bit;
sbit LCD_D5 at PORTD5_bit;
sbit LCD_D6 at PORTD6_bit;
sbit LCD_D7 at PORTD7_bit;

sbit LCD_RS_Direction at DDD2_bit;
sbit LCD_EN_Direction at DDD3_bit;
sbit LCD_D4_Direction at DDD4_bit;
sbit LCD_D5_Direction at DDD5_bit;
sbit LCD_D6_Direction at DDD6_bit;
sbit LCD_D7_Direction at DDD7_bit;


char errors[] = "Overflow";


unsigned int *memloc = 1100;

unsigned char i;


 unsigned int fibonacciCompute(unsigned char val){

 if(val == 0)
 return 0;
 else if (val ==1)
 return 1;
 else if (val ==2)
 return 1;
 else
 return fibonacciCompute(val-1)+fibonacciCompute(val-2);
}
void main(){
 while(1){
 char mystr[10];
 unsigned int *fibo;

 unsigned int myval,myval2;
 unsigned int num;
 unsigned int error=0xffff;
 DDRC=00;
 num=PINC;
 MCUCR = 0x80;
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
 if(num==0){
 Lcd_Out(1,1,"0 Entered");
 Lcd_Out(2,1,"Make it Bigger");
 Delay_ms(160);
 continue;
 }

 if(num>=0)
 {
 for(i=0;i<=num;i++){
 if(i<=23){
 myval=fibonacciCompute(i);
 sprintf(mystr,"%d",myval);
 Lcd_Out(1,1,"Calculating");
 Lcd_Out(2,1,"The Sequence ...");
 }
 if(i>=24)
 memloc[i]=error;
 else
 *(memloc+i)=myval;
 }

 }
 Lcd_Cmd(_LCD_CLEAR);

 for(i=0;i<num;i++)
 {
 myval=memloc[i];
 myval2=memloc[i+1];
 if(myval==0xffff)
 Lcd_Out(1,6,errors);
 else{
 sprintf(mystr,"%d",myval);
 Lcd_Out(1,6,mystr);
 }
 if(myval2==0xffff)
 {
 Lcd_Out(2,6,errors);
 }
 else{
 sprintf(mystr,"%d",myval2);
 Lcd_Out(2,6,mystr);
 }
 Delay_ms(160);
 }

 }
}
