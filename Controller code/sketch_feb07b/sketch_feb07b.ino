#include "MPU9250.h"

MPU9250 IMU(Wire,0x68);
int status;

int i=0, j=0, k=0, l=0, button=0;
int x1=0, _y1=0, xbuff1=0, ybuff1=0, buf1=2;
int x2=0, y2=0, xbuff2=0, ybuff2=0, buf2=2;
int x3=0, y3=0, xbuff3=0, ybuff3=0, buf3=2;
int x4=0, y4=0, xbuff4=0, ybuff4=0, buf4=2;
bool buttonPressed = false;

void setup() {
  Serial.begin(9600);
  pinMode(LED_BUILTIN, OUTPUT);
  digitalWrite(LED_BUILTIN, LOW);
  pinMode(D5, INPUT_PULLUP);         // buttonPins PULLUP
  pinMode(D6, INPUT_PULLUP);
  
while(!Serial) {yield();
    Serial.println("hey1");
    }

  status = IMU.begin();
  if (status < 0) {
    Serial.println("IMU initialization unsuccessful");
    Serial.println("Check IMU wiring or try cycling power");
    Serial.print("Status: ");
    Serial.println(status);
    while(1) {yield();
    Serial.println("hey2");
    delay(500);
    status = IMU.begin();
    }
  }
  //Serial.println("Connected");
}

void loop() {
  IMU.readSensor();
  
  xbuff1 += (int)IMU.getAccelY_mss();
  ybuff1 += (int)IMU.getAccelZ_mss()+9;
  
  if(i++>buf1) {
    x1 = xbuff1/buf1;
    _y1 = ybuff1/buf1;
    i=0;
    xbuff1 = 0;
    ybuff1 = 0;
    xbuff2 += x1;
    ybuff2 += _y1;
  }
  if(j++>buf2) {
    x2 = xbuff2/buf2;
    y2 = ybuff2/buf2;
    xbuff2 = 0;
    ybuff2 = 0;
    xbuff3 += x2;
    ybuff3 += y2;
  }
  if(k++>buf3) {
    x3 = xbuff3/buf3;
    y3 = ybuff3/buf3;
    xbuff3 = 0;
    ybuff3 = 0;
    xbuff4 += x3;
    ybuff4 += y3;
  }
  if(l++>buf4) {
    x4 = xbuff4/buf4;
    y4 = ybuff4/buf4;
    xbuff4 = 0;
    ybuff4 = 0;
  }

  if(!digitalRead(D5)) {
    button=1;
    buttonPressed = true;
    delay(10);
  } 
  if(!digitalRead(D6)) {
    button=2;
    buttonPressed = true;
    delay(10);
  }
 
 
 if(x4>5  ||  x4<-5  ||  y4>5  ||  y4<-5  ||  buttonPressed){
    Serial.print(x4);
    Serial.print(",");
    Serial.print(y4);
    Serial.print(",");
    Serial.println(button);
    x4 = 0;
    y4 = 0;
    button=0;
    buttonPressed = false;
 }
  yield();

}
