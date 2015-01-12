/* to be used with http://energia.nu/
NIRpixel firmware is designed to be used with Energia environment and TI Launchpad boards.
At defined intervals the firmware outputs space delimited analog measurements of specified channels via serial port available via USB and another serial port if bluetooth-serial converter is present.

Copyright Institute IRNAS Rače 2014 - info@irnas.eu

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.*/

//counter for averaging
long count = 0;

//analog input pins listed in teh order we wish to read them
uint8_t pins = 9;
uint8_t analogin[pins] = {A0,A1,A2,A5,A4,A3,A6,A7,A8};
//array to store the sum of measurements
unsigned long pixel_meas[pins];
//timing variables
unsigned long previousMillis = 0;

void setup() {
  Serial.begin(115200);
  Serial3.begin(9600);  
}

void loop() {
  
  //measure all analog values evers ms
  for(char i=0;i<pins;i++){
    pixel_meas[i]+=analogRead(analogin[i]);
  }
  count++;
  delay(1);
  
  // define interval at which the measurements should be printed out
  unsigned long currentMillis = millis();
  if(currentMillis - previousMillis > 100) {
    previousMillis = currentMillis; 
    //print space delimited values
    for(char i=0;i<pins;i++){
      float var = (float)(pixel_meas[i]/count);
      Serial.print(var); 
      Serial.print(" ");
      Serial3.print(var); 
      Serial3.print(" ");
      //reset the sum to 0
      pixel_meas[i]=0;
    }
    Serial.println("");
    Serial3.println(""); 
    //reset counter 
    count=0;
  }
}
