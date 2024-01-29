clear all; close all; clc;

fs=48000;
c=340; 
const=sqrt(413/(4*pi));
N=50;

hz=0;
hm=5;
xm=5; 

uz=1;
um=1;
m=1;

teta=atan((hz+hm)/xm);
D=sqrt((xm)^2+(hz-hm)^2);

if (teta~=0)
R1=hz/sin(teta);
R2=hm/sin(teta);
R=R1+R2;
else
    R=xm;
end

teta=teta*180/pi;

usmerenost = zeros(4,1);
usmerenost(1,1) = 1;
usmerenost(2,1) =  0.5*(1+cos(teta));
usmerenost(3,1) =  cos(teta);
usmerenost(4,1) =  0.25*(1+3*cos(teta));

Ad=const/D.*usmerenost(uz,1).*usmerenost(um, 1);
taud=D/c;
taud_odb=round(taud*fs);

Ar=const/R.*usmerenost(uz,1).*usmerenost(um, 1);
taur=R/c;
taur_odb=round(taur*fs);

odzivd=zeros(1,fs);
odzivd(taud_odb)=odzivd(taud_odb) + Ad;

odzivr=zeros(1,fs);
odzivr(taur_odb)=odzivr(taur_odb) + Ar;

f = [0 125 250 500 1000 2000 4000 8000];
f_n = f/8000;
Ref = zeros(3,8);
Ref(1,:) = [1 0.99 0.99 0.98 0.98 0.98 0.95 0.95]; %Beton
Ref(2,:) = [1 0.82 0.88 0.90 0.91 0.92 0.93 0.93]; % Drvo
Ref(3,:) = [1 0.54 0.07 0 0 0 0 0]; %Panel
h = fir2(N,f_n,Ref(m,:));

odziv_ukupno = odzivr + odzivd;
odziv_kon = filter(h,1,odziv_ukupno);

t=(0:length(odziv_kon)-1)/fs;
figure, stem(t,odziv_kon)

X=fft(odziv_kon);
f=(0:length(X)-1)/length(X)*fs;
figure, plot(f,20*log10(abs(X)))
