clear all;
close all;
clc;

[x, fs]=audioread('abgs.wav');
x=x(:,1);
% ako je na ulazu frekvencija 4k Hz na izlazu ce biti 2k Hz znog
% decimacije, ostale decimiram sa 
f4kd=round(4000/sqrt(2));   %donja granica 4k/sqrt(2)
f4kg=round(4000*sqrt(2));   %gornja granica 4k*sqrt(2)

wp=[f4kd f4kg]/(fs/2);    %fsnovo=fsstaro/2 to je decimacija ulaznog signala 
ws=[500 20000]/(fs/2);
[n,wn]=ellipord(wp,ws,1,50);
[b,a]=ellip(n,1,50,wn);
[H6,f]=freqz(b,a,1000,fs);   %poenta je da koristim samo jedan filtar, elipticki filtar
figure,
semilogx(f,abs(H6));    %fija semilogx se koristi za iscrtavanje, zbog decibela

y=zeros(length(x),6);
RMS=zeros(6,1);
br_rms=6;

for k=0:5
% ako je na ulazu frekvencija 4k Hz na izlazu ce biti 2k Hz zbog
% decimacije, ostale decimiram sa 2^k
    x_dec=decimate(x,2^k);
    y(1:length(x_dec),k+1)=filter(b,a,x_dec);
    
    RMS(br_rms,1)=rms(y(:,k+1));
    br_rms=br_rms-1;
    
end

%ostatak zadatka je kao u prvoj tacki

fd=round(125/sqrt(2));
fg=round(125*sqrt(2));

for k=0:5
    
    x_oktavno(fd*2^k:fg*2^k)=20*log10(RMS(k+1));
    f_oktavno(fd*2^k:fg*2^k)=fd*2^k:fg*2^k;
    
end

%stepenice

figure,
semilogx(f_oktavno, x_oktavno),
xlabel('f[Hz]'),
ylabel('Nivo[dB]'),
title('Oktavni spektar'),
grid on;

%Vremenska promena nivoa signala

t=((1:length(x))/fs);
figure,
subplot(6,1,1),plot (t, 20*log10(abs(y(:,1)))),
title('Vremenska promena nivoa signala')
subplot(6,1,2),plot (t, 20*log10(abs(y(:,2)))),
subplot(6,1,3),plot (t, 20*log10(abs(y(:,3)))),
ylabel('Nivo[dB]');
subplot(6,1,4),plot (t, 20*log10(abs(y(:,4)))),
subplot(6,1,5),plot (t, 20*log10(abs(y(:,5)))),
subplot(6,1,6),plot (t, 20*log10(abs(y(:,6)))),
xlabel('Vreme[s]');

xlswrite('Rezultati.xls', x_oktavno',1,'B2'); %druga kolona

