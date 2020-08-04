
_fibonacciCompute:
	PUSH       R28
	PUSH       R29
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 2
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;MyProject.c,26 :: 		unsigned int fibonacciCompute(unsigned char val){   //basic fibo function
;MyProject.c,28 :: 		if(val == 0)           //basic fibonacci algorithm
	PUSH       R2
	LDI        R27, 0
	CP         R2, R27
	BREQ       L__fibonacciCompute28
	JMP        L_fibonacciCompute0
L__fibonacciCompute28:
;MyProject.c,29 :: 		return 0;
	LDI        R16, 0
	LDI        R17, 0
	JMP        L_end_fibonacciCompute
L_fibonacciCompute0:
;MyProject.c,30 :: 		else if (val ==1)
	LDI        R27, 1
	CP         R2, R27
	BREQ       L__fibonacciCompute29
	JMP        L_fibonacciCompute2
L__fibonacciCompute29:
;MyProject.c,31 :: 		return 1;
	LDI        R16, 1
	LDI        R17, 0
	JMP        L_end_fibonacciCompute
L_fibonacciCompute2:
;MyProject.c,32 :: 		else if (val ==2)
	LDI        R27, 2
	CP         R2, R27
	BREQ       L__fibonacciCompute30
	JMP        L_fibonacciCompute4
L__fibonacciCompute30:
;MyProject.c,33 :: 		return 1;
	LDI        R16, 1
	LDI        R17, 0
	JMP        L_end_fibonacciCompute
L_fibonacciCompute4:
;MyProject.c,35 :: 		return fibonacciCompute(val-1)+fibonacciCompute(val-2); //recursive
	MOV        R16, R2
	SUBI       R16, 1
	PUSH       R2
	MOV        R2, R16
	CALL       _fibonacciCompute+0
	POP        R2
	STD        Y+0, R16
	STD        Y+1, R17
	MOV        R16, R2
	SUBI       R16, 2
	MOV        R2, R16
	CALL       _fibonacciCompute+0
	LDD        R18, Y+0
	LDD        R19, Y+1
	ADD        R16, R18
	ADC        R17, R19
;MyProject.c,36 :: 		}
;MyProject.c,35 :: 		return fibonacciCompute(val-1)+fibonacciCompute(val-2); //recursive
;MyProject.c,36 :: 		}
L_end_fibonacciCompute:
	POP        R2
	ADIW       R28, 1
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	POP        R29
	POP        R28
	RET
; end of _fibonacciCompute

_main:
	LDI        R27, 255
	OUT        SPL+0, R27
	LDI        R27, 0
	OUT        SPL+1, R27
	IN         R28, SPL+0
	IN         R29, SPL+1
	SBIW       R28, 16
	OUT        SPL+0, R28
	OUT        SPL+1, R29
	ADIW       R28, 1

;MyProject.c,37 :: 		void main(){
;MyProject.c,38 :: 		while(1){     //while true
	PUSH       R2
	PUSH       R3
	PUSH       R4
	PUSH       R5
L_main6:
;MyProject.c,44 :: 		unsigned int error=0xffff;// the value should be stored for overflow
	LDI        R27, 255
	STD        Y+14, R27
	STD        Y+15, R27
;MyProject.c,45 :: 		DDRC=00;               //make portc to output
	LDI        R27, 0
	OUT        DDRC+0, R27
;MyProject.c,46 :: 		num=PINC;       //read it and store it to num
	IN         R16, PINC+0
	STD        Y+12, R16
	LDI        R27, 0
	STD        Y+13, R27
;MyProject.c,47 :: 		MCUCR = 0x80;   //enable the exmem
	LDI        R27, 128
	OUT        MCUCR+0, R27
;MyProject.c,48 :: 		Lcd_Init();                        // Initialize LCD
	CALL       _Lcd_Init+0
;MyProject.c,49 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;MyProject.c,50 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);          // Cursor off
	LDI        R27, 12
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;MyProject.c,51 :: 		if(num==0){             //if num is zero
	LDD        R16, Y+12
	LDD        R17, Y+13
	CPI        R17, 0
	BRNE       L__main32
	CPI        R16, 0
L__main32:
	BREQ       L__main33
	JMP        L_main8
L__main33:
;MyProject.c,52 :: 		Lcd_Out(1,1,"0 Entered");         //print lcd
	LDI        R27, #lo_addr(?lstr1_MyProject+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr1_MyProject+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.c,53 :: 		Lcd_Out(2,1,"Make it Bigger");    //print lcd
	LDI        R27, #lo_addr(?lstr2_MyProject+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr2_MyProject+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.c,54 :: 		Delay_ms(160);        //call delay
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main9:
	DEC        R16
	BRNE       L_main9
	DEC        R17
	BRNE       L_main9
	DEC        R18
	BRNE       L_main9
	NOP
;MyProject.c,55 :: 		continue;     //then continue
	JMP        L_main6
;MyProject.c,56 :: 		}
L_main8:
;MyProject.c,58 :: 		if(num>=0)   //if number is positive
	LDD        R16, Y+12
	LDD        R17, Y+13
	CPI        R17, 0
	BRNE       L__main34
	CPI        R16, 0
L__main34:
	BRSH       L__main35
	JMP        L_main11
L__main35:
;MyProject.c,60 :: 		for(i=0;i<=num;i++){     // calculate fibonacci
	LDI        R27, 0
	STS        _i+0, R27
L_main12:
	LDS        R18, _i+0
	LDD        R16, Y+12
	LDD        R17, Y+13
	CP         R16, R18
	LDI        R27, 0
	CPC        R17, R27
	BRSH       L__main36
	JMP        L_main13
L__main36:
;MyProject.c,61 :: 		if(i<=23){              // if smaller than 23
	LDS        R17, _i+0
	LDI        R16, 23
	CP         R16, R17
	BRSH       L__main37
	JMP        L_main15
L__main37:
;MyProject.c,62 :: 		myval=fibonacciCompute(i);     //call fibonacci
	LDS        R2, _i+0
	CALL       _fibonacciCompute+0
	STD        Y+10, R16
	STD        Y+11, R17
;MyProject.c,63 :: 		sprintf(mystr,"%d",myval); // convert it string
	MOVW       R18, R28
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_3_MyProject+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_3_MyProject+0)
	PUSH       R27
	PUSH       R19
	PUSH       R18
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 6
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;MyProject.c,64 :: 		Lcd_Out(1,1,"Calculating");//print lcd
	LDI        R27, #lo_addr(?lstr4_MyProject+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr4_MyProject+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.c,65 :: 		Lcd_Out(2,1,"The Sequence ...");//print lcd
	LDI        R27, #lo_addr(?lstr5_MyProject+0)
	MOV        R4, R27
	LDI        R27, hi_addr(?lstr5_MyProject+0)
	MOV        R5, R27
	LDI        R27, 1
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.c,66 :: 		}
L_main15:
;MyProject.c,67 :: 		if(i>=24)
	LDS        R16, _i+0
	CPI        R16, 24
	BRSH       L__main38
	JMP        L_main16
L__main38:
;MyProject.c,68 :: 		memloc[i]=error;//load ffff to detect error
	LDS        R16, _i+0
	MOV        R18, R16
	LDI        R19, 0
	LSL        R18
	ROL        R19
	LDS        R16, _memloc+0
	LDS        R17, _memloc+1
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LDD        R16, Y+14
	LDD        R17, Y+15
	ST         Z+, R16
	ST         Z+, R17
	JMP        L_main17
L_main16:
;MyProject.c,70 :: 		*(memloc+i)=myval; // load value into pointer
	LDS        R16, _i+0
	MOV        R18, R16
	LDI        R19, 0
	LSL        R18
	ROL        R19
	LDS        R16, _memloc+0
	LDS        R17, _memloc+1
	MOVW       R30, R18
	ADD        R30, R16
	ADC        R31, R17
	LDD        R16, Y+10
	LDD        R17, Y+11
	ST         Z+, R16
	ST         Z+, R17
L_main17:
;MyProject.c,60 :: 		for(i=0;i<=num;i++){     // calculate fibonacci
	LDS        R16, _i+0
	SUBI       R16, 255
	STS        _i+0, R16
;MyProject.c,71 :: 		}
	JMP        L_main12
L_main13:
;MyProject.c,73 :: 		}
L_main11:
;MyProject.c,74 :: 		Lcd_Cmd(_LCD_CLEAR); // clear lcd
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Cmd+0
;MyProject.c,76 :: 		for(i=0;i<num;i++) // print loop
	LDI        R27, 0
	STS        _i+0, R27
L_main18:
	LDS        R16, _i+0
	LDD        R18, Y+12
	LDD        R19, Y+13
	LDI        R17, 0
	CP         R16, R18
	CPC        R17, R19
	BRLO       L__main39
	JMP        L_main19
L__main39:
;MyProject.c,78 :: 		myval=memloc[i];  // store to display text
	LDS        R22, _i+0
	MOV        R16, R22
	LDI        R17, 0
	LSL        R16
	ROL        R17
	LDS        R20, _memloc+0
	LDS        R21, _memloc+1
	MOVW       R30, R16
	ADD        R30, R20
	ADC        R31, R21
	LD         R18, Z+
	LD         R19, Z+
	STD        Y+10, R18
	STD        Y+11, R19
;MyProject.c,79 :: 		myval2=memloc[i+1];   //store to display text
	MOV        R16, R22
	LDI        R17, 0
	SUBI       R16, 255
	SBCI       R17, 255
	LSL        R16
	ROL        R17
	MOVW       R30, R16
	ADD        R30, R20
	ADC        R31, R21
	LD         R16, Z+
	LD         R17, Z+
; myval2 start address is: 20 (R20)
	MOVW       R20, R16
;MyProject.c,80 :: 		if(myval==0xffff)      //if error value entered
	CPI        R19, 255
	BRNE       L__main40
	CPI        R18, 255
L__main40:
	BREQ       L__main41
	JMP        L_main21
L__main41:
;MyProject.c,81 :: 		Lcd_Out(1,6,errors);  // print error message
	LDI        R27, #lo_addr(_errors+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_errors+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
	JMP        L_main22
L_main21:
;MyProject.c,83 :: 		sprintf(mystr,"%d",myval); // print the fibbo numbers
	MOVW       R18, R28
	LDD        R16, Y+10
	LDD        R17, Y+11
	PUSH       R21
	PUSH       R20
	PUSH       R17
	PUSH       R16
	LDI        R27, hi_addr(?lstr_6_MyProject+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_6_MyProject+0)
	PUSH       R27
	PUSH       R19
	PUSH       R18
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 6
	OUT        SPL+0, R26
	OUT        SPL+1, R27
	POP        R20
	POP        R21
;MyProject.c,84 :: 		Lcd_Out(1,6,mystr);     //print first line
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 1
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.c,85 :: 		}
L_main22:
;MyProject.c,86 :: 		if(myval2==0xffff)     // if error value
	CPI        R21, 255
	BRNE       L__main42
	CPI        R20, 255
L__main42:
	BREQ       L__main43
	JMP        L_main23
L__main43:
; myval2 end address is: 20 (R20)
;MyProject.c,88 :: 		Lcd_Out(2,6,errors);  //then print error
	LDI        R27, #lo_addr(_errors+0)
	MOV        R4, R27
	LDI        R27, hi_addr(_errors+0)
	MOV        R5, R27
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.c,89 :: 		}
	JMP        L_main24
L_main23:
;MyProject.c,91 :: 		sprintf(mystr,"%d",myval2); //copy to string
; myval2 start address is: 20 (R20)
	MOVW       R16, R28
	PUSH       R21
	PUSH       R20
; myval2 end address is: 20 (R20)
	LDI        R27, hi_addr(?lstr_7_MyProject+0)
	PUSH       R27
	LDI        R27, #lo_addr(?lstr_7_MyProject+0)
	PUSH       R27
	PUSH       R17
	PUSH       R16
	CALL       _sprintf+0
	IN         R26, SPL+0
	IN         R27, SPL+1
	ADIW       R26, 6
	OUT        SPL+0, R26
	OUT        SPL+1, R27
;MyProject.c,92 :: 		Lcd_Out(2,6,mystr);    //display second line of lcd
	MOVW       R16, R28
	MOVW       R4, R16
	LDI        R27, 6
	MOV        R3, R27
	LDI        R27, 2
	MOV        R2, R27
	CALL       _Lcd_Out+0
;MyProject.c,93 :: 		}
L_main24:
;MyProject.c,94 :: 		Delay_ms(160);       //call delay
	LDI        R18, 9
	LDI        R17, 30
	LDI        R16, 229
L_main25:
	DEC        R16
	BRNE       L_main25
	DEC        R17
	BRNE       L_main25
	DEC        R18
	BRNE       L_main25
	NOP
;MyProject.c,76 :: 		for(i=0;i<num;i++) // print loop
	LDS        R16, _i+0
	SUBI       R16, 255
	STS        _i+0, R16
;MyProject.c,95 :: 		}
	JMP        L_main18
L_main19:
;MyProject.c,97 :: 		}
	JMP        L_main6
;MyProject.c,98 :: 		}
L_end_main:
	POP        R5
	POP        R4
	POP        R3
	POP        R2
L__main_end_loop:
	JMP        L__main_end_loop
; end of _main
