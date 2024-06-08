close all; clear all;clc;
[x,fs]=audioread('Signali/5_hirurska.wav'); %trebalo mi je fs
fosa=load('fosa');
a=load('slabljenje');
fosa=fosa.f_oktavno;
a=a.RMScor;

N_filter=50; %privremeni red filtra, posle mozemo da bazdarimo
wp=fosa./fs*2; % fs/2 nam je pi 
wd=[0 wp 1]; %zahteva nam da osa pocinje od nule i zavrsava se jedinicom
h=[];
for i=2:5 
s=a(:,i); %slabljenje za datu masku ocitano iz datoteke
s=s';
s=-s;
ap=[];
for j=1:length(s)
    ap(j)=10^(s(j)/20); %prevodjenje slabljenja iz dB u osnovne jedinice
end

ad=[ap(1) ap 0]; %da bi imalo isti broj clanova kao osa
h(:,i)=fir2(N_filter,wd,ad); %filtri, stavlja se svako u svoju kolonu
end