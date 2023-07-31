#line 1 "D:/Communiation/2nd communication/Summer Training/Project/code/MyProject.c"
void interrupt(){
 int i;
 int arr[]={37,36,35,34,33,32,25,24,23,22,21,20,19,18,17,16,9,8,7,6,5,4,3,2,1,0};
 int flag=0;
 intedg_bit=1;
 trisa = 0b00000010;
 porta.b1=0;
 here:
 if(intf_bit==1){
 intf_bit=0;
 change:
 for(;;){
 if(portb.b0==0){
 intf_bit=0;
 porta.B0=0;
 porta.B2=0;
 break;
 }
 if(porta.b1==0)
 flag=0;
 if(porta.b1==1 && flag<3){
 if((portb.b1==1 && portb.B6==1) || (portb.B1==1 && portb.B5==1)){
 portb = 0b00100010 ;
 porta.B0=1;
 porta.B2=0;
 for(i=22;i<25;i++){
 if(porta.b1==1)
 flag++;
 portc = arr[i];
 delay_ms(1000);
 }
 portb = 0b00011000;
 porta.b2=1;
 goto change;
 }
 else if((portb.B3==1 && portb.b4==1) || (portb.B2==1 && portb.b4==1)){
 portb = 0b00010100 ;
 porta.B2=1;
 porta.b0=0;
 for(i=22;i<25;i++){
 flag++;
 portc = arr[i];
 delay_ms(1000);
 }
 portb = 0b01000010;
 porta.b0=1;
 goto change;
 }
 }
 }
}
}

void main() {
 int arr[]={37,36,35,34,33,32,25,24,23,22,21,20,19,18,17,16,9,8,7,6,5,4,3,2,1,0};
 int i;
 adcon1= 0x07;
 inte_bit=1;
 intedg_bit=1;
 trisa = 0b00000010;
 trisb = 0b00000000;
 trisc = 0b00000000;
 portc = 0;
 portb = 0;
 porta = 0;
 stage1:
 for(;;){
 portb = 0b01000010;
 for( i=2;i<25 ;i++){
 if(portb.b0==1){
 intf_bit=1;
 gie_bit=1;
 if(portb.b1==1 && portb.B6==1){
 i=2;
 goto stage1;
 }
 else{
 i=10;
 break;
 }
 }
 if(i==22){
 portb = 0b00100010;
 }
 portc = arr[i];
 delay_ms(1000);
 }
 portb = 0b00011000;
 stage2:
 for(i=10;i<25 ;i++){
 if(portb.b0==1){
 intf_bit=1;
 gie_bit=1;
 if(portb.b1==1 && portb.B6==1){
 i=2;
 goto stage1;
 }
 else {
 i=10;
 goto stage2;
 }
 }
 if(i==22){
 portb = 0b00010100;
 }
 portc = arr[i];
 delay_ms(1000);
 }
 }
}
