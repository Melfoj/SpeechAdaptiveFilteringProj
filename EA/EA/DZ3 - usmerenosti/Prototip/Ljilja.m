clear all; close all; clc;

prompt = {'Unesite broj izvora:'};
dlg_title = ' ';
num_lines = 1;
defaultans = {'2'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
a=answer(1);
N=str2double(a{1});

prompt = {'Unesite rastojanje izmedju izvora u metrima:'};
dlg_title = ' ';
num_lines = 1;
defaultans = {'0.34'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
b=answer(1);
d=str2double(b{1});

prompt = {'Unesite rezoluciju za crtanje dijagrama usmerenosti:'};
dlg_title = ' ';
num_lines = 1;
defaultans = {'5'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
c=answer(1);
dteta=str2double(c{1});
dteta=dteta*pi/180;

prompt = {'Usmerenost antene: 1-Omnidirekciona 2-Kardioida 3-Osmica 4-Hiper-kardioida?'};
dlg_title = ' ';
num_lines = 1;
defaultans = {'1'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
e=answer(1);
u=str2double(e{1});

fs=48000;
r=10;
c=340;
ro=413;
Pa=1;
const=sqrt(Pa*ro/(4*pi));

z_osa=(-(N-1)/2*d:d:(N-1)/2*d);

teta=0:dteta:2*pi;
M=length(teta);

ampl=zeros(N,M);
rast=zeros(N,M);
tau=zeros(N,M);

usmerenost = zeros(4,M);
usmerenost(1,:) = 1;
usmerenost(2,:) =  0.5*(1+cos(teta(:)));
usmerenost(3,:) =  cos(teta(:));
usmerenost(4,:) =  0.25*(1+3*cos(teta(:)));

for i=1:N
    
    rast(i,:) = sqrt((r*cos(teta(:))).^2+(r*sin(teta(:))-z_osa(i)).^2);
    ampl(i, :)=const.*usmerenost(u,:)*const/rast(i);
    tau(i, :)=ceil(fs*rast(i)/c);
    
end

for m=1:M
    
    odziv=zeros(M,fs);
    
    for n=1:N
        odziv(m, tau(n,m))=odziv(m, tau(n,m))+ ampl(n,m);
    end
    
end

x_okt=zeros(1,fs);

X_pom=zeros(M,8);

for m=1:M
    
    fmin=125;
    
    
    for o=1:8
        
        X=fft(odziv(m, :));
        fd=round(fmin/sqrt(2));
        fg=round(fmin*sqrt(2));
        
        x_okt(fd:fg)=1/fs^2*sum(2*abs(X(fd:fg)).^2);
        
        X_pom(m,o)=x_okt(fmin);
        
        fmin=fmin*2;
        
    end
    
end

X_pom=X_pom';
NIVO=zeros(8,M);

for o=1:8
    NIVO(o,:)=10*log10(X_pom(o,:)/max(abs(X_pom(o,:))));
end

figure, subplot(2,4,1), mmpolar(teta, NIVO(1,:)),hold on
subplot(2,4,2), mmpolar(teta, NIVO(2,:)),hold on
subplot(2,4,3), mmpolar(teta, NIVO(3,:)),hold on
subplot(2,4,4), mmpolar(teta, NIVO(4,:)),hold on
subplot(2,4,5), mmpolar(teta, NIVO(5,:)),hold on
subplot(2,4,6), mmpolar(teta, NIVO(6,:)),hold on
subplot(2,4,7), mmpolar(teta, NIVO(7,:)),hold on
subplot(2,4,8), mmpolar(teta, NIVO(8,:))

