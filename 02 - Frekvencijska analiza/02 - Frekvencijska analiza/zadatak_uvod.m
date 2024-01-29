clear all; close all; clc;
pkg load signal;

[x fs]=wavread('signal_domaci.wav');
x=x(:,1);

%% Digitalni filtar
wp=[5656 11313]/(fs/2);
ws=[4500 12500]/(fs/2);
[n,wn]=cheb1ord(wp,ws,0.1,50);
[b,a]=cheby1(n,1,wn);
[H,f]=freqz(b,a,1000);

figure,plot(f/pi*fs/2,abs(H)),
xlabel('f[Hz]','FontSize',12),ylabel('Amplituda','FontSize',12);
title('Amplitudska karakteristika filtra','FontSize',14);

figure,plot(f/pi*fs/2,(angle(H))),
xlabel('f[Hz]','FontSize',12),ylabel('Amplituda','FontSize',12);
title('Fazna karakteristika filtra','FontSize',14);

y=filter(b,a,x);
% wavplay(x,fs)
% wavplay(y,fs)

%% FFT

X=fft(x);
f=(0:length(X)-1)/length(X)*fs;
figure, plot(f,abs(X))
xlabel('f[Hz]','FontSize',12),ylabel('Amplituda','FontSize',12);
title('Amplitudskai spektar','FontSize',14);

%% Spektrogram

[S,F,T,P]=spectrogram(x,4800,0,fs,fs);

% figure,
surf(T,F,10*log10(P),'edgecolor','none'); 
view(0,90);