clear all;
close all;
clc

[x, fs]=audioread('beli_sum.wav');
x=x(:,1);

[S,F,T,P]=spectrogram(x,512,128,fs,fs);

X=sum(abs(P),2);

fd=round(125/sqrt(2));
fg=round(125*sqrt(2));

for k=0:5
    
    x_okt(fd*2^k:fg*2^k)=sum(abs(X(fd*2^k):fg*2^k));
    f_okt(fd*2^k:fg*2^k)=fd*2^k:fg*2^k;
    y(:,k+1)=sum(P(fd*2^k:fg*2^k,:)); 
    
end

figure,
semilogx(f_okt,10*log10(x_okt)),
xlabel('f[Hz]'),
ylabel('Nivo[dB]'),
title('Okatvni spektar'),
grid on;

%Vremenski oblik

figure,
subplot(6,1,1),plot (T, 20*log10(abs(y(:,1)))),
title('Vremenska promena nivoa signala')
subplot(6,1,2),plot (T, 20*log10(abs(y(:,2)))),
subplot(6,1,3),plot (T, 20*log10(abs(y(:,3)))),
ylabel('Nivo[dB]');
subplot(6,1,4),plot (T, 20*log10(abs(y(:,4)))),
subplot(6,1,5),plot (T, 20*log10(abs(y(:,5)))),
subplot(6,1,6),plot (T, 20*log10(abs(y(:,6)))),
xlabel('Vreme[s]');

xlswrite('Rezultati.xlsx', x_okt',1,'E2');


