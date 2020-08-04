
// LCD module connections
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
// End LCD module connections

char errors[] = "Overflow";//the text should be displayed when error


unsigned int *memloc = 1100; //starting memory location

unsigned char i;   //my loop counter


 unsigned int fibonacciCompute(unsigned char val){   //basic fibo function

     if(val == 0)           //basic fibonacci algorithm
            return 0;
     else if (val ==1)
          return 1;
     else if (val ==2)
          return 1;
     else
         return fibonacciCompute(val-1)+fibonacciCompute(val-2); //recursive
}
void main(){
  while(1){     //while true
  char mystr[10];        // my temporary array
  unsigned int *fibo;// my fibonacci array whose values will be stored in exmem

  unsigned int myval,myval2;//the text will be displayed first line and second line of the lcd
  unsigned int num;//the number which will be read from pinc
  unsigned int error=0xffff;// the value should be stored for overflow
  DDRC=00;               //make portc to output
  num=PINC;       //read it and store it to num
  MCUCR = 0x80;   //enable the exmem
  Lcd_Init();                        // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
  if(num==0){             //if num is zero
  Lcd_Out(1,1,"0 Entered");         //print lcd
  Lcd_Out(2,1,"Make it Bigger");    //print lcd
  Delay_ms(160);        //call delay
  continue;     //then continue
  }

  if(num>=0)   //if number is positive
  {
  for(i=0;i<=num;i++){     // calculate fibonacci
  if(i<=23){              // if smaller than 23
    myval=fibonacciCompute(i);     //call fibonacci
    sprintf(mystr,"%d",myval); // convert it string
    Lcd_Out(1,1,"Calculating");//print lcd
    Lcd_Out(2,1,"The Sequence ...");//print lcd
    }
    if(i>=24)
     memloc[i]=error;//load ffff to detect error
    else
     *(memloc+i)=myval; // load value into pointer
    }

  }
  Lcd_Cmd(_LCD_CLEAR); // clear lcd

  for(i=0;i<num;i++) // print loop
  {
  myval=memloc[i];  // store to display text
  myval2=memloc[i+1];   //store to display text
  if(myval==0xffff)      //if error value entered
    Lcd_Out(1,6,errors);  // print error message
  else{       // if no error
  sprintf(mystr,"%d",myval); // print the fibbo numbers
  Lcd_Out(1,6,mystr);     //print first line
  }
  if(myval2==0xffff)     // if error value
  {
  Lcd_Out(2,6,errors);  //then print error
  }
  else{                       //if no error
  sprintf(mystr,"%d",myval2); //copy to string
  Lcd_Out(2,6,mystr);    //display second line of lcd
  }
  Delay_ms(160);       //call delay
  }

  }
}