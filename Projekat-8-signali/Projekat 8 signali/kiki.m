clear all; close all; clc;

pkg load signal;

[y11,fs] = audioread('1_hirurska.wav');
Y=fft(y11);                
T = 1/fs;             % Sampling period       
L = length(y11);             % Length of signal
t = (0:L-1)*T;
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
figure,plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')