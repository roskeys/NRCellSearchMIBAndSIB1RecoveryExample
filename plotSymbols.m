function plotSymbols(waveform, sampleRate, nfft)
    if nargin < 3
        nfft = 512;
    end
    spectrogram(waveform,ones(nfft,1),0,nfft,'centered',sampleRate,'yaxis','MinThreshold',-130);
end