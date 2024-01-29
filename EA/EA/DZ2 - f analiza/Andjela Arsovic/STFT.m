clear all;
close all;
clc

[x, fs]=audioread('abgs.wav');
x=x(:,1);

[S,F,T,P]=spectrogram(x,512,128,fs,fs); %opciono fs

X=sum(abs(P),2);  %p je spektralna gustina energije

%donja i gornja granica
fd=round(125/sqrt(2));
fg=round(125*sqrt(2));

%ostatak zadatka je kao u prvoj tacki


for k=0:5
    
    x_oktavno(fd*2^k:fg*2^k)=sum(abs(X(fd*2^k):fg*2^k));
    f_oktavno(fd*2^k:fg*2^k)=fd*2^k:fg*2^k;
    y(:,k+1)=sum(P(fd*2^k:fg*2^k,:)); 
    
end

figure,
semilogx(f_oktavno,10*log10(x_oktavno)),
xlabel('f[Hz]'),
ylabel('Nivo[dB]'),
title('Okatvni spektar'),
grid on;

%Vremenski oblik



figure,

title('Vremenska promena nivoa signala');
subplot(6,1,1), plot(T, 20*log10(abs(y(:,1)))),   %125 Hz
subplot(6,1,2), plot(T, 20*log10(abs(y(:,2)))),    %250 Hz
subplot(6,1,3), plot(T, 20*log10(abs(y(:,3)))),    %500 Hz
subplot(6,1,4), plot(T, 20*log10(abs(y(:,4)))),    %1000 Hz
subplot(6,1,5), plot(T, 20*log10(abs(y(:,5)))),    %2000 Hz
subplot(6,1,6), plot(T, 20*log10(abs(y(:,6)))),    %4000 Hz
xlabel('Vreme[s]');
ylabel('Nivo[dB]');

xlswrite('Rezultati.xls', x_oktavno',1,'D2');
