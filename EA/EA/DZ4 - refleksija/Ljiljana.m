clear all; close all; clc;

hz=5; %visina zvucnika u metrima
hm=1; %visina mikofona u metrima
xm=1; %udaljenost mikrofona od zvucnika u metrima

uz=4; %usmerenost zvucnika: 1 omnidirekciona 2 kardioida 3 bidirekciona 4 hiperkardioida
um=4; %usmerenost mikrofona 1 omnidirekciona 2 kardioida 3 bidirekciona 4 hiperkardioida
m=2; %materijal 1 beton 2 drvo 3 panel

fs=48000;
c=340;
const=sqrt(413/(4*pi));
N=10;

teta=atan((hz+hm)/xm);
D=sqrt((xm)^2+(hz-hm)^2);

if (xm==0)
    disp('Zvucnik i mikrofon moraju biti razmaknuti!')
    return
end

if (teta==0 || isnan(teta))
    R=xm;
    r1=xm;
    
else
    R1=hz/sin(teta);
    r1=hz*xm/(hm+hz);
    R2=hm/sin(teta);
    R=R1+R2;
end

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
odzivd(taud_odb)=Ad;

odzivr=zeros(1,fs);
odzivr(taur_odb)=Ar;

f = [125 250 500 1000 2000 4000 8000];
Ref = zeros(3,9);
Ref(1,:) = [0.99 0.99 0.98 0.98 0.98 0.98 0.95 0.95 0.95]; %Beton
Ref(2,:) = [0.82 0.82 0.88 0.90 0.91 0.92 0.93 0.93 0.93]; % Drvo
Ref(3,:) = [0.54 0.54 0.07 0 0 0 0 0 0]; %Panel
h = fir2(N,[0 f/(fs/2) 1],Ref(m,:));

odzivr = filter(h,1,odzivr);
odziv_ukupno = odzivr + odzivd;

t=(0:length(odziv_ukupno)-1)/fs;
figure, plot(t,odziv_ukupno);
title('Impulsni odzivi u prijemnoj tacki')
xlabel('Vreme[s]');


X=fft(odziv_ukupno);
f=(0:length(X)-1)/length(X)*fs;
figure, plot(f,20*log10(abs(X)/max(abs(X))));
title('Frekvencijski odziv u prijemnoj tacki')
xlabel('Frekvencija[Hz]'), ylabel('Nivo[dB]')
ylim([-30 5]);

th = 0:pi/50:2*pi;
r=0.25;
x0 = r * cos(th);
y0 = r * sin(th) + hz;

x2 = [xm-0.25, xm+0.25, xm+0.25, xm-0.25, xm-0.25];
y2 = [hm-0.25, hm-0.25, hm+0.25, hm+0.25, hm-0.25];

figure,
plot(x0, y0, 'r');
hold all
plot(x2, y2, 'c');
hold all
plot([0 xm], [hz hm],'b');
hold all
plot([0 r1 xm],[hz 0 hm],'g');
hold all
plot([-1 xm+1], [0 0],'k', 'LineWidth',3);
grid
xlabel('x [m]');
ylabel('h [m]');
legend('Zvucnik','Mikrofon','Direktna putanja - D','Reflektovana putanja - R');
axis equal
title('Model sistema sa jednom refleksijom')

teta=teta*180/pi;

Reflektovani_ugao_u_stepenima = teta

[X_pom, fokt]=f_oktavno(odziv_ukupno,fs);
figure, semilogx(X_pom,fokt);
title('Frekvencijski odziv po oktavama u prijemnoj tacki')
xlabel('Frekvencija[Hz]'), ylabel('Nivo[dB]')