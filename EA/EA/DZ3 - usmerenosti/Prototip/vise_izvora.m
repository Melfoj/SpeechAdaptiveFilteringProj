clear all; close all; clc;

N=4; % Broj izvora

fs=48000;
r=10; % Rastojanje u metrima
c=340; % Brzina zvuka u vazduhu
ro=413;
Pa=1;
d=0.5; % Rastojanje izmedju izvora u metrima
const=sqrt(Pa*ro/(4*pi));
dteta=5*pi/180;
teta=0*pi/180;
f0=125;

A=const/r;
z_osa=(-(N-1)/2*d:d:(N-1)/2*d);

odziv=zeros(1,fs);
ampl=zeros(1,N);
rast=zeros(1,N);
tau=zeros(1,N);

for i=1:N
    
    rast(i)=sqrt(z_osa(i)^2+r^2-2*r*z_osa(i)*sin(teta));
    ampl(i)=const./rast(i);
    tau(i)=ceil(fs*rast(i)/c);
    odziv(tau(i))=odziv(tau(i))+ampl(i);
    
end

X=fft(odziv);
nivo=20*log10(abs(X));

t=(0:length(odziv)-1)/fs;
figure, stem(t,odziv)
title('Impulsni odziv','FontSize',12)
xlabel('Vreme (s)','FontSize',11)
ylabel('Amplituda','FontSize',11)


f=(0:length(X)-1)/length(X)*fs;
figure, plot(f,20*log10(nivo))
title('Frekvencijska karakterisika','FontSize',12)
xlabel('Frekvencija (Hz)','FontSize',11)
ylabel('Nivo (dB)','FontSize',11)

