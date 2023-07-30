
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;MyProject.c,1 :: 		void interrupt(){
;MyProject.c,3 :: 		int arr[]={37,36,35,34,33,32,25,24,23,22,21,20,19,18,17,16,9,8,7,6,5,4,3,2,1,0};
	MOVLW      ?ICSinterrupt_arr_L0+0
	MOVWF      ___DoICPAddr+0
	MOVLW      hi_addr(?ICSinterrupt_arr_L0+0)
	MOVWF      ___DoICPAddr+1
	MOVLW      interrupt_arr_L0+0
	MOVWF      FSR
	MOVLW      54
	MOVWF      R0+0
	CALL       ___CC2DW+0
;MyProject.c,5 :: 		intedg_bit=1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;MyProject.c,6 :: 		trisa = 0b00000010;
	MOVLW      2
	MOVWF      TRISA+0
;MyProject.c,7 :: 		porta.b1=0;
	BCF        PORTA+0, 1
;MyProject.c,9 :: 		if(intf_bit==1){
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt0
;MyProject.c,10 :: 		intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,11 :: 		change:
___interrupt_change:
;MyProject.c,12 :: 		for(;;){
L_interrupt1:
;MyProject.c,13 :: 		if(portb.b0==0){
	BTFSC      PORTB+0, 0
	GOTO       L_interrupt4
;MyProject.c,14 :: 		intf_bit=0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,15 :: 		porta.B0=0;
	BCF        PORTA+0, 0
;MyProject.c,16 :: 		porta.B2=0;
	BCF        PORTA+0, 2
;MyProject.c,17 :: 		break;
	GOTO       L_interrupt2
;MyProject.c,18 :: 		}
L_interrupt4:
;MyProject.c,19 :: 		if(porta.b1==0)
	BTFSC      PORTA+0, 1
	GOTO       L_interrupt5
;MyProject.c,20 :: 		flag=0;
	CLRF       interrupt_flag_L0+0
	CLRF       interrupt_flag_L0+1
L_interrupt5:
;MyProject.c,21 :: 		if(porta.b1==1 && flag<3){
	BTFSS      PORTA+0, 1
	GOTO       L_interrupt8
	MOVLW      128
	XORWF      interrupt_flag_L0+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt67
	MOVLW      3
	SUBWF      interrupt_flag_L0+0, 0
L__interrupt67:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt8
L__interrupt62:
;MyProject.c,22 :: 		if((portb.b1==1 && portb.B6==1) || (portb.B1==1 && portb.B5==1)){
	BTFSS      PORTB+0, 1
	GOTO       L__interrupt61
	BTFSS      PORTB+0, 6
	GOTO       L__interrupt61
	GOTO       L__interrupt59
L__interrupt61:
	BTFSS      PORTB+0, 1
	GOTO       L__interrupt60
	BTFSS      PORTB+0, 5
	GOTO       L__interrupt60
	GOTO       L__interrupt59
L__interrupt60:
	GOTO       L_interrupt15
L__interrupt59:
;MyProject.c,23 :: 		portb =  0b00100010 ;
	MOVLW      34
	MOVWF      PORTB+0
;MyProject.c,24 :: 		porta.B0=1;
	BSF        PORTA+0, 0
;MyProject.c,25 :: 		porta.B2=0;
	BCF        PORTA+0, 2
;MyProject.c,26 :: 		for(i=22;i<26;i++){
	MOVLW      22
	MOVWF      R3+0
	MOVLW      0
	MOVWF      R3+1
L_interrupt16:
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt68
	MOVLW      26
	SUBWF      R3+0, 0
L__interrupt68:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt17
;MyProject.c,27 :: 		if(porta.b1==1)
	BTFSS      PORTA+0, 1
	GOTO       L_interrupt19
;MyProject.c,28 :: 		flag++;
	INCF       interrupt_flag_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       interrupt_flag_L0+1, 1
L_interrupt19:
;MyProject.c,29 :: 		portc = arr[i];
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      interrupt_arr_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,30 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt20:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt20
	DECFSZ     R12+0, 1
	GOTO       L_interrupt20
	DECFSZ     R11+0, 1
	GOTO       L_interrupt20
	NOP
	NOP
;MyProject.c,26 :: 		for(i=22;i<26;i++){
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
;MyProject.c,31 :: 		}
	GOTO       L_interrupt16
L_interrupt17:
;MyProject.c,32 :: 		portb = 0b00011000;
	MOVLW      24
	MOVWF      PORTB+0
;MyProject.c,33 :: 		porta.b2=1;
	BSF        PORTA+0, 2
;MyProject.c,34 :: 		goto change;
	GOTO       ___interrupt_change
;MyProject.c,35 :: 		}
L_interrupt15:
;MyProject.c,36 :: 		else if((portb.B3==1 && portb.b4==1) || (portb.B2==1 && portb.b4==1)){
	BTFSS      PORTB+0, 3
	GOTO       L__interrupt58
	BTFSS      PORTB+0, 4
	GOTO       L__interrupt58
	GOTO       L__interrupt56
L__interrupt58:
	BTFSS      PORTB+0, 2
	GOTO       L__interrupt57
	BTFSS      PORTB+0, 4
	GOTO       L__interrupt57
	GOTO       L__interrupt56
L__interrupt57:
	GOTO       L_interrupt28
L__interrupt56:
;MyProject.c,37 :: 		portb =  0b00010100 ;
	MOVLW      20
	MOVWF      PORTB+0
;MyProject.c,38 :: 		porta.B2=1;
	BSF        PORTA+0, 2
;MyProject.c,39 :: 		porta.b0=0;
	BCF        PORTA+0, 0
;MyProject.c,40 :: 		for(i=22;i<26;i++){
	MOVLW      22
	MOVWF      R3+0
	MOVLW      0
	MOVWF      R3+1
L_interrupt29:
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__interrupt69
	MOVLW      26
	SUBWF      R3+0, 0
L__interrupt69:
	BTFSC      STATUS+0, 0
	GOTO       L_interrupt30
;MyProject.c,41 :: 		flag++;
	INCF       interrupt_flag_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       interrupt_flag_L0+1, 1
;MyProject.c,42 :: 		portc = arr[i];
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      interrupt_arr_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,43 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_interrupt32:
	DECFSZ     R13+0, 1
	GOTO       L_interrupt32
	DECFSZ     R12+0, 1
	GOTO       L_interrupt32
	DECFSZ     R11+0, 1
	GOTO       L_interrupt32
	NOP
	NOP
;MyProject.c,40 :: 		for(i=22;i<26;i++){
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
;MyProject.c,44 :: 		}
	GOTO       L_interrupt29
L_interrupt30:
;MyProject.c,45 :: 		portb = 0b01000010;
	MOVLW      66
	MOVWF      PORTB+0
;MyProject.c,46 :: 		porta.b0=1;
	BSF        PORTA+0, 0
;MyProject.c,47 :: 		goto change;
	GOTO       ___interrupt_change
;MyProject.c,48 :: 		}
L_interrupt28:
;MyProject.c,49 :: 		}
L_interrupt8:
;MyProject.c,50 :: 		}
	GOTO       L_interrupt1
L_interrupt2:
;MyProject.c,51 :: 		}
L_interrupt0:
;MyProject.c,52 :: 		}
L_end_interrupt:
L__interrupt66:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;MyProject.c,54 :: 		void main() {
;MyProject.c,55 :: 		int arr[]={37,36,35,34,33,32,25,24,23,22,21,20,19,18,17,16,9,8,7,6,5,4,3,2,1,0};
	MOVLW      ?ICSmain_arr_L0+0
	MOVWF      ___DoICPAddr+0
	MOVLW      hi_addr(?ICSmain_arr_L0+0)
	MOVWF      ___DoICPAddr+1
	MOVLW      main_arr_L0+0
	MOVWF      FSR
	MOVLW      52
	MOVWF      R0+0
	CALL       ___CC2DW+0
;MyProject.c,57 :: 		adcon1= 0x07;
	MOVLW      7
	MOVWF      ADCON1+0
;MyProject.c,58 :: 		inte_bit=1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;MyProject.c,59 :: 		intedg_bit=1;
	BSF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;MyProject.c,60 :: 		trisa = 0b00000010;
	MOVLW      2
	MOVWF      TRISA+0
;MyProject.c,61 :: 		trisb = 0b00000000;
	CLRF       TRISB+0
;MyProject.c,62 :: 		trisc = 0b00000000;
	CLRF       TRISC+0
;MyProject.c,63 :: 		portc = 0;
	CLRF       PORTC+0
;MyProject.c,64 :: 		portb = 0;
	CLRF       PORTB+0
;MyProject.c,65 :: 		porta = 0;
	CLRF       PORTA+0
;MyProject.c,66 :: 		stage1:
___main_stage1:
;MyProject.c,67 :: 		for(;;){
L_main33:
;MyProject.c,68 :: 		portb = 0b01000010;
	MOVLW      66
	MOVWF      PORTB+0
;MyProject.c,69 :: 		for( i=2;i<26 ;i++){
	MOVLW      2
	MOVWF      R3+0
	MOVLW      0
	MOVWF      R3+1
L_main36:
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main71
	MOVLW      26
	SUBWF      R3+0, 0
L__main71:
	BTFSC      STATUS+0, 0
	GOTO       L_main37
;MyProject.c,70 :: 		if(portb.b0==1){
	BTFSS      PORTB+0, 0
	GOTO       L_main39
;MyProject.c,71 :: 		intf_bit=1;
	BSF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,72 :: 		gie_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,73 :: 		if(portb.b1==1 && portb.B6==1){
	BTFSS      PORTB+0, 1
	GOTO       L_main42
	BTFSS      PORTB+0, 6
	GOTO       L_main42
L__main64:
;MyProject.c,74 :: 		i=2;
	MOVLW      2
	MOVWF      R3+0
	MOVLW      0
	MOVWF      R3+1
;MyProject.c,75 :: 		goto stage1;
	GOTO       ___main_stage1
;MyProject.c,76 :: 		}
L_main42:
;MyProject.c,78 :: 		i=10;
	MOVLW      10
	MOVWF      R3+0
	MOVLW      0
	MOVWF      R3+1
;MyProject.c,79 :: 		break;
	GOTO       L_main37
;MyProject.c,81 :: 		}
L_main39:
;MyProject.c,82 :: 		if(i==22){
	MOVLW      0
	XORWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main72
	MOVLW      22
	XORWF      R3+0, 0
L__main72:
	BTFSS      STATUS+0, 2
	GOTO       L_main44
;MyProject.c,83 :: 		portb = 0b00100010;
	MOVLW      34
	MOVWF      PORTB+0
;MyProject.c,84 :: 		}
L_main44:
;MyProject.c,85 :: 		portc = arr[i];
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      main_arr_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,86 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main45:
	DECFSZ     R13+0, 1
	GOTO       L_main45
	DECFSZ     R12+0, 1
	GOTO       L_main45
	DECFSZ     R11+0, 1
	GOTO       L_main45
	NOP
	NOP
;MyProject.c,69 :: 		for( i=2;i<26 ;i++){
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
;MyProject.c,87 :: 		}
	GOTO       L_main36
L_main37:
;MyProject.c,88 :: 		portb = 0b00011000;
	MOVLW      24
	MOVWF      PORTB+0
;MyProject.c,89 :: 		stage2:
___main_stage2:
;MyProject.c,90 :: 		for(i=10;i<26 ;i++){
	MOVLW      10
	MOVWF      R3+0
	MOVLW      0
	MOVWF      R3+1
L_main46:
	MOVLW      128
	XORWF      R3+1, 0
	MOVWF      R0+0
	MOVLW      128
	SUBWF      R0+0, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main73
	MOVLW      26
	SUBWF      R3+0, 0
L__main73:
	BTFSC      STATUS+0, 0
	GOTO       L_main47
;MyProject.c,91 :: 		if(portb.b0==1){
	BTFSS      PORTB+0, 0
	GOTO       L_main49
;MyProject.c,92 :: 		intf_bit=1;
	BSF        INTF_bit+0, BitPos(INTF_bit+0)
;MyProject.c,93 :: 		gie_bit=1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;MyProject.c,94 :: 		if(portb.b1==1 && portb.B6==1){
	BTFSS      PORTB+0, 1
	GOTO       L_main52
	BTFSS      PORTB+0, 6
	GOTO       L_main52
L__main63:
;MyProject.c,95 :: 		i=2;
	MOVLW      2
	MOVWF      R3+0
	MOVLW      0
	MOVWF      R3+1
;MyProject.c,96 :: 		goto stage1;
	GOTO       ___main_stage1
;MyProject.c,97 :: 		}
L_main52:
;MyProject.c,99 :: 		i=10;
	MOVLW      10
	MOVWF      R3+0
	MOVLW      0
	MOVWF      R3+1
;MyProject.c,100 :: 		goto stage2;
	GOTO       ___main_stage2
;MyProject.c,102 :: 		}
L_main49:
;MyProject.c,103 :: 		if(i==22){
	MOVLW      0
	XORWF      R3+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main74
	MOVLW      22
	XORWF      R3+0, 0
L__main74:
	BTFSS      STATUS+0, 2
	GOTO       L_main54
;MyProject.c,104 :: 		portb = 0b00010100;
	MOVLW      20
	MOVWF      PORTB+0
;MyProject.c,105 :: 		}
L_main54:
;MyProject.c,106 :: 		portc = arr[i];
	MOVF       R3+0, 0
	MOVWF      R0+0
	MOVF       R3+1, 0
	MOVWF      R0+1
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	MOVF       R0+0, 0
	ADDLW      main_arr_L0+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTC+0
;MyProject.c,107 :: 		delay_ms(1000);
	MOVLW      11
	MOVWF      R11+0
	MOVLW      38
	MOVWF      R12+0
	MOVLW      93
	MOVWF      R13+0
L_main55:
	DECFSZ     R13+0, 1
	GOTO       L_main55
	DECFSZ     R12+0, 1
	GOTO       L_main55
	DECFSZ     R11+0, 1
	GOTO       L_main55
	NOP
	NOP
;MyProject.c,90 :: 		for(i=10;i<26 ;i++){
	INCF       R3+0, 1
	BTFSC      STATUS+0, 2
	INCF       R3+1, 1
;MyProject.c,108 :: 		}
	GOTO       L_main46
L_main47:
;MyProject.c,109 :: 		}
	GOTO       L_main33
;MyProject.c,110 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
