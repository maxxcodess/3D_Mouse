# 3D Mouse
### _Discription_

The Project shows how we can interact with our PCs more interactivly with the use of 3-dimentional Gesture contol. As Hardware we have used MPU 9250, contolled by ESP D1 mini. 

### _Working_

 **1. Hardware :**
 
The ESP8266 Controller reads the motion of hand from the MPU. Then the algorithm determines the type of motion based on the changing values of X, Y and Z axises. Based on the intensity of the motion the algorithm computes a vector (displacement + direction) and sends it to the PC via UART protocol.

 **2. Software :**
 
 Software we use is MATLAB which reads the vector input from Controller and changes the Mouse cursor position accordingly. It aslo suppport Left and Right click.
 
