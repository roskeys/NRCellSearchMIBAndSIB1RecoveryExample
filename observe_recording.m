% samples_file = "records/srsran_423400_10MHz_15KHz/srsran_band1_10MHz_15KHz_dl_conn1.fc32";
samples_file = "/home/roskey/Documents/MATLAB/NRCellSearchMIBAndSIB1RecoveryExample/records/srsran_band1_423400_10MHz_15KHz/srsran_band1_10MHz_15KHz_dl_conn.fc32";
sampleRate = 23040000; % Hz
frameSize = sampleRate * 10e-3;

windowSize = frameSize * 4;
stepSize = frameSize;

nrbSSB = 20;
scsSSB = 30;
ofdmInfo = nrOFDMInfo(nrbSSB,scsSSB,'SampleRate',sampleRate);
nfft = ofdmInfo.Nfft;

fid = fopen(samples_file, 'rb');
if fid == -1
    fprintf("Failed to open file!\n"); 
end


buffer = readIQSamplesFromFile(fid, windowSize);
offset = 2;

for i=0:50000 
    spectrogram(buffer, ones(nfft,1),0,nfft,'centered',sampleRate,'yaxis','MinThreshold',-130) ;
    fprintf("Current offset %d\n", offset);
    secondHalf = buffer(stepSize:end);
    newStep = readIQSamplesFromFile(fid, stepSize);
    if size(newStep, 1) == 0     
        break
    end
    buffer = cat(1, secondHalf, newStep);
    offset = offset + 1;
    pause(0.2);
end
fclose(fid);