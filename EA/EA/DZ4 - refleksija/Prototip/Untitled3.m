clear all; close all; clc;

fs=48000;
c=340;
const=sqrt(413/(4*pi));
N=10;

hz=3; %visina zvucnika
hm=1; %visina mikofona
xm=5; %udaljenost mikrofona od zvucnika

uz=1; %usmerenost zvucnika 1-4
um=1; %usmerenost mikrofona 1-4
m=1; %materijal 1-3

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
odzivd(taud_odb)=Ad;

odzivr=zeros(1,fs);
odzivr(taur_odb)=Ar;

f = [125 250 500 1000 2000 4000 8000];
Ref = zeros(3,9);
Ref(1,:) = [0.99 0.99 0.99 0.98 0.98 0.98 0.95 0.95 0.95]; %Beton
Ref(2,:) = [0.82 0.82 0.88 0.90 0.91 0.92 0.93 0.93 0.93]; % Drvo
Ref(3,:) = [0.54 0.54 0.07 0 0 0 0 0 0]; %Panel
h = fir2(N,[0 f/(fs/2) 1],Ref(m,:));

odzivr = filter(h,1,odzivr);
odziv_ukupno = odzivr + odzivd;

t=(0:length(odziv_ukupno)-1)/fs;
figure, plot(t,odziv_ukupno);

X=fft(odziv_ukupno);
f=(0:length(X)-1)/length(X)*fs;
figure, plot(f,20*log10(abs(X))/max(abs(X)));
%ylim([-30 5]);

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
ylabel('y [m]');
legend('Zvucnik','Mikrofon','Direktna putanja - D','Reflektovana putanja - R');
axis equal

Reflektovani_ugao_u_stepenima = teta

x_okt=zeros(1,fs);
X_pom=zeros(8);
NIVO=zeros(8);
fmin=125;


for o=1:8
    
    X=fft(odziv_ukupno);
    fd=round(fmin/sqrt(2));
    fg=round(fmin*sqrt(2));
    
    x_okt(fd:fg)=1/fs^2*sum(2*abs(X(fd:fg)).^2);
    
    X_pom(o)=x_okt(fmin);
    
    fmin=fmin*2;
    
    NIVO(o)=20*log10(X_pom(o)/max(abs(X_pom(o))));
    
end

figure,
for i=1:8
    plot (f, NIVO(i)),hold on
end
