clear all; close all; clc;

[x, fs]=audioread('abgs.wav');
x=x(:,1);

N=length(x); %posto je 1s trajanje signala, mislim da ce da izracuna za ceo signal

X=fft(x, N); %FFT filtar      % N je rezolucija u spektru
f=(0:N-1)*fs/N;

fd=round(125/sqrt(2));
fg=round(125*sqrt(2));

for k=0:5
    
   x_oktavno(fd*2^k:fg*2^k)=sum((2/N*(abs(X(fd*2^k:fg*2^k)))).^2); %amplitude dizem na kvadrat i sumiram, to je rms
   f_oktavno(fd*2^k:fg*2^k)=fd*2^k:fg*2^k;                        %mora da se skalira jer je dvostani spektar sa N/2
      
end

 figure, semilogx(f_oktavno,10*log10(x_oktavno)),
 title('Oktavni spektar'),
 xlabel('f[Hz]'), 
 ylabel('Nivo[dB]'),
 grid on;   
 
xlswrite('Rezultati.xls', x_oktavno',1,'C2'); %treca kolona
