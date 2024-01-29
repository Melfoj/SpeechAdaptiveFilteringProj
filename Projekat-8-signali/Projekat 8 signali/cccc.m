[audioIn,fs] = audioread("1_bez_maske.wav");
M=20;
K=round((length(audioIn)*1000)/(M*fs));
win = hann(M,"periodic");
S = stft(audioIn,"Window",win,"OverlapLength",M/2,"Centered",false);
coeffs = mfcc(S,fs,"LogEnergy","Ignore");
%mfcc(audioIn,fs)
for i=1: