clear all;
    s1 = serial('COM4');                            %define serial port
    s1.BaudRate=115200;                               %define baud rate
    %data=zeros(490<)
    %open serial port
    %set(s1, 'terminator', 'LF');
    fopen(s1);
    s1.ReadAsyncMode = 'continuous';
    count =1;
    data = cell(480,10);
    evalin('data', 's1');
    readasync(s1);
    while(s1.BytesAvailable <= 0)  %wait until Arduino outputs data 
    end
    while count<100
        %while(s1.BytesAvailable > 0)
            data = fscanf(s1); %read sensor
            flushinput(s1);
            disp(data);
            %disp(count)
            count = count+1;
       % end
    end
    % close the serial port!
    fclose(s1);