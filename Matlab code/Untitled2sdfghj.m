sFile = 'AcceDualAxis.csv';
 if exist(sFile) == 0 ; % if the file does not exists, read instrumentation
    delete(instrfindall);   %pre-emptively close all ports
    s1 = serial('COM4');    %define serial port to read the Arduino
    s1.BaudRate=115200;     %define baud rate
    fopen(s1);
    s1.ReadAsyncMode = 'continuous';
    readasync(s1);
    while(s1.BytesAvailable <= 0)  %wait until Arduino outputs data 
        %
    end
    mData = [];
    for i=1:1000 %while if constant acquisition is needed. 
            sSerialData = fscanf(s1); %read sensor
            flushinput(s1);
            t = strsplit(sSerialData,'\t'); % same character as the Arduino code
            mData(i,1) = str2double(t(1)); 
            mData(i,2) = str2double(t(2));
    end    
    delete(instrfindall);    % close the serial port
    csvwrite(sFile,mData);   % save the data to a CSV file
 else                         % if the file exists, load it
    mData = csvread(sFile);  
 end