clear all;
close all;
clc;

mu=0;
std=1;
br1=60000;
br2=1;
abgs = mu+ std.*randn(br1,br2);
fs_abgs=48000;

abgs=abgs/abs(max(abgs));

audiowrite('abgs.wav',abgs,fs_abgs, 'BitsPerSample',24);

[x, fs]=audioread('abgs.wav');
x=x(:,1);

BandsPerOctave=1;
N=6;           % Red filtra
F0=1000;       % Centralna frekvencija (Hz)

f=fdesign.octave(BandsPerOctave,'Class 1','N,F0',N,F0,fs);
F0=validfrequencies(f);
Nfc=length(F0);

for i=1:Nfc,
    f.F0=F0(i);
    Hd(i)=design(f,'butter');
end


for br=1:6
    y(:, br)=filter(Hd(br+2), x);
    RMS(br,1)=rms(y(:,br));
end

%oktavni spektar

fd=round(125/sqrt(2));
fg=round(125*sqrt(2));

for k=0:5
    
    x_oktavno(fd*2^k:fg*2^k)=20*log10(RMS(k+1));
    f_oktavno(fd*2^k:fg*2^k)=fd*2^k:fg*2^k;
    
end

figure, 
title('Oktavni spektar'),
semilogx(f_oktavno, x_oktavno),
xlabel('f[Hz]'),
ylabel('Nivo[dB]'),

grid on;

%Vremenski oblik

t=((1:length(x))/fs);
figure, 
title('Vremenska promena nivoa signala');
subplot(6,1,1), plot(t, 20*log10(abs(y(:,1)))),   %125 Hz
subplot(6,1,2), plot(t, 20*log10(abs(y(:,2)))),    %250 Hz
subplot(6,1,3), plot(t, 20*log10(abs(y(:,3)))),    %500 Hz
subplot(6,1,4), plot(t, 20*log10(abs(y(:,4)))),    %1000 Hz
subplot(6,1,5), plot(t, 20*log10(abs(y(:,5)))),    %2000 Hz
subplot(6,1,6), plot(t, 20*log10(abs(y(:,6)))),    %4000 Hz
xlabel('Vreme[s]');
ylabel('Nivo[dB]');

xlswrite('Rezultati.xls', x_oktavno',1,'A2');
