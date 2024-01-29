clear all; close all; clc;

N=4; % Broj izvora
fs=48000;
r=10; % Rastojanje u metrima
c=340; % Brzina zvuka u vazduhu
ro=413;
Pa=1;
d=0.34; % Rastojanje izmedju izvora u metrima
const=sqrt(Pa*ro/(4*pi));

f0=125;

dteta=5*pi/180;
teta=0:dteta:2*pi;
M=length(teta);

usmerenost_1=1;
usmerenost_2=cos(teta);
usmerenost_3=0.5*(1+cos(teta));
usmerenost_4=0.25*(1+3*cos(teta));

z_osa=(-(N-1)/2*d:d:(N-1)/2*d);

ampl=zeros(N,M);
rast=zeros(N,M);
tau=zeros(N,M);

for i=1:N
    
    rast(i, :)=sqrt(z_osa(i)^2+r^2-2*r*z_osa(i)*sin(teta));
    ampl(i, :)=usmerenost_3*const./rast(i);
    tau(i, :)=ceil(fs*rast(i)/c);    
    
end

nivo=zeros(1, M);

for m=1:M
    
    odziv=zeros(1,fs);
    for n=1:N
        odziv(tau(n,m))=odziv(tau(n,m))+ ampl(n,m);
    end
    
    X=fft(odziv);
    nivo(1,m)=20*log10(abs(X(f0)));
    
%     nivo_db=10*log10(nivo./max(nivo));
    
end

% mmpolar(teta, nivo_db)
mmpolar(teta, nivo)

