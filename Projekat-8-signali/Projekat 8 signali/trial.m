clear all; close all; clc;

pkg load signal;

[y11,fs] = audioread('1_hirurska.wav');
Y=abs(fft(y11));
f = length(Y)*fs/linspace(-1,1,fs);
figure,plot(f,Y);