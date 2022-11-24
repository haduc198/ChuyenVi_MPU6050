#include "MPU6050_tockn.h"
#include <Wire.h>
#define Length 26
double angleX, angleY, angleZ;
double displacement;
MPU6050 mpu6050(Wire);

void setup() {
  Serial.begin(115200);
  Wire.begin();
  mpu6050.begin();
mpu6050.calcGyroOffsets(true);
  // mpu6050.setGyroOffsets(-5.11, -7.3, 6.14);
}

void loop() {
  mpu6050.update();
  angleX = mpu6050.getAngleX();
  angleY = mpu6050.getAngleY();
  angleZ = mpu6050.getAngleZ();

  displacement =  Length * sin(angleY*PI/180);

  /*Serial.print("angleX : ");
  Serial.print(angleX);*/
  //Serial.print("\tangleY : ");
  //Serial.println(angleY );
   //Serial.print("\tdisplacement : ");
  Serial.print(-displacement)
  Serial.print('@');
  Serial.println(-angleX);
 // delay(100);
  /*Serial.print("\tangleZ : ");
  Serial.println(angleZ );*/
}
