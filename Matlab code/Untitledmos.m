a=instrfind
fclose(a);
%%
clear
close all

import java.awt.Robot;
mouse = Robot;
s = serial('COM8', 'BaudRate',9600,'Terminator','LF')
fopen(s);
pause(1);
%set cursor on the center
xpos = 960;
ypos = 540;
errcount=0;
%mouse.mouseMove(xpos,ypos);
for i = 1: 1000
    data = str2double(fgets(s))
    pause(0.001);
    if isnan(data)
        errcount = errcount + 1;
 
    else
        
       fprintf('%d \n',data)
       mouse.mouseMove(xpos+data,0);
       xpos=xpos+data;
       pause(0.00001);
    end
end
disp(errcount)
fclose(s);