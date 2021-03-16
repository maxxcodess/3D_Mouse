a=instrfind
fclose(a);
%%
clear
close all

import java.awt.Robot;
import java.awt.event.*;
mouse = Robot;
s = serial('COM4', 'BaudRate',9600,'Terminator','LF')
fopen(s);
pause(1);
%set cursor on the center
xpos = 960;
xval = 0;
ypos = 540;
yval = 0;
button = 0;
errcount=0;

xfactor = 2;
yfactor = 2;
%     
%mouse.mouseMove(xpos,ypos);
for i = 1: 20000
    data = fgets(s);
    fprintf('%d \n', data)
    data = strsplit(data,',')
    xval = str2double(data(1))
    yval = str2double(data(2))
    button = str2double(data(3))
    
    
    pause(0.001);
    if isnan(xval) || isnan(yval) || isnan(button)
       errcount = errcount + 1;
    else   
       mouse.mouseMove(xpos+(xval*xfactor),ypos+(yval*yfactor));
       if button == 1
           mouse.mousePress(InputEvent.BUTTON1_MASK)
           mouse.mouseRelease(InputEvent.BUTTON1_MASK)
       end
       if button == 2
           mouse.mousePress(InputEvent.BUTTON3_MASK)
           mouse.mouseRelease(InputEvent.BUTTON3_MASK)
       end
       xpos=xpos+(xval*xfactor);
       ypos=ypos+(yval*yfactor);
       pause(0.00001);
    end
end
disp(errcount)
fclose(s);