clear all;
close all;
clc;

[x, fs]=audioread('beli_sum.wav');
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

%125Hz-4kHz

hfvt=fvtool(Hd(3:8),'FrequencyScale', 'log', 'MagnitudeDisplay', 'Magnitude');

for br=1:6
    y(:, br)=filter(Hd(br+2), x);
    RMS(br,1)=rms(y(:,br));
end

%Stepenice xD (Oktavni spektar)

fd=round(125/sqrt(2));
fg=round(125*sqrt(2));

for k=0:5
    
    x_okt(fd*2^k:fg*2^k)=20*log10(RMS(k+1));
    f_okt(fd*2^k:fg*2^k)=fd*2^k:fg*2^k;
    
end

figure, 
semilogx(f_okt, x_okt),
xlabel('f[Hz]'),
ylabel('Nivo[dB]'),
title('Oktavni spektar'),
grid on;

%Vremenski oblik

t=((1:length(x))/fs);
figure, 
subplot(6,1,1),plot (t, 20*log10(abs(y(:,1)))),
title('Vremenska promena nivoa signala');
subplot(6,1,2),plot (t, 20*log10(abs(y(:,2)))),
subplot(6,1,3),plot (t, 20*log10(abs(y(:,3)))),
ylabel('Nivo[dB]');
subplot(6,1,4),plot (t, 20*log10(abs(y(:,4)))),
subplot(6,1,5),plot (t, 20*log10(abs(y(:,5)))),
subplot(6,1,6),plot (t, 20*log10(abs(y(:,6)))),
xlabel('Vreme[s]');

xlswrite('Eksel.xlsx', x_okt',1,'A2');
