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

prompt = {'Unesite zeljenu frekvenciju za prikaz usmerenosti:'};
dlg_title = ' ';
num_lines = 1;
defaultans = {'1000'};
answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
g=answer(1);
f0=str2double(g{1});

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
    ampl(i, :)=const.*usmerenost(u,:)./rast(i);
    tau(i, :)=ceil(fs*rast(i)/c);
    
end

nivo=zeros(1, M);
nivo_okt = zeros(8,M);

for m=1:M
    
    odziv=zeros(1,fs);
    
    for n=1:N
        odziv(tau(n,m))=odziv(tau(n,m))+ ampl(n,m);
    end
    
    X=fft(odziv);
    nivo(1,m)=20*log10(abs(X(f0)));
    nivo_norm=nivo./max(nivo);
    
    fmin=125;
    
    for o=1:8
               
        nivo_okt(o,m) = z4_fft_f(X, fmin, fs);    
        fmin = fmin*2;
        
    end
    
    nivo_okt_norm=nivo_okt./max(nivo_okt);
      
end

figure, mmpolar(teta, nivo_norm)
figure, mmpolar(teta, nivo_okt_norm)

