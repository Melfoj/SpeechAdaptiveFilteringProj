clear all
close all
clc

mu=0;
std=1;
br1=60000;
br2=1;
abgs = mu+ std.*randn(br1,br2);
fs_abgs=96000;

abgs=abgs/abs(max(abgs));

audiowrite('abgs.wav',abgs,fs_abgs, 'BitsPerSample',24);

[zvuk, fs] = audioread('abgs.wav');
t=(0:length(zvuk)-1)/fs;
figure, plot(t,zvuk), legend('signal x(t)');

