function [x2] = z2_rucno_f()

[x, fs]=audioread('muzika.wav');
x=x(:,1);
f0=[125 250 500 1000 2000 4000];

%1
wp1=[f0(1)/sqrt(2) f0(1)*sqrt(2)]/(fs/2);
ws1=[1 1000]/(fs/2);

[n1, wn1]=ellipord(wp1, ws1, 1, 50);
[b1, a1]=ellip (n1, 1, 50, wn1);
[H1, f]=freqz(b1, a1, 1000, fs);
figure, 
semilogx(f, abs(H1)), hold on

%2
wp2=[f0(2)/sqrt(2) f0(2)*sqrt(2)]/(fs/2);
ws2=[10 1000]/(fs/2);

[n2, wn2]=ellipord(wp2, ws2, 1, 50);
[b2, a2]=ellip (n2, 1, 50, wn2);
[H2, f]=freqz(b2, a2, 1000, fs);
semilogx(f, abs(H2)), hold on

%3
wp3=[f0(3)/sqrt(2) f0(3)*sqrt(2)]/(fs/2);
ws3=[100 5000]/(fs/2);

[n3, wn3]=ellipord(wp3, ws3, 1, 50);
[b3, a3]=ellip (n3, 1, 50, wn3);
[H3, f]=freqz(b3, a3, 1000, fs);
semilogx(f, abs(H3)), hold on

%4
wp4=[f0(4)/sqrt(2) f0(4)*sqrt(2)]/(fs/2);
ws4=[150 10000]/(fs/2);

[n4, wn4]=ellipord(wp4, ws4, 1, 50);
[b4, a4]=ellip (n4, 1, 50, wn4);
[H4, f]=freqz(b4, a4, 1000, fs);
semilogx(f, abs(H4)), hold on

%5
wp5=[f0(5)/sqrt(2) f0(5)*sqrt(2)]/(fs/2);
ws5=[250 15000]/(fs/2);

[n5, wn5]=ellipord(wp5, ws5, 1, 50);
[b5, a5]=ellip (n5, 1, 50, wn5);
[H5, f]=freqz(b5, a5, 1000, fs);
semilogx(f, abs(H5)), hold on

%6
wp6=[f0(6)/sqrt(2) f0(6)*sqrt(2)]/(fs/2);
ws6=[500 20000]/(fs/2);

[n6, wn6]=ellipord(wp6, ws6, 1, 50);
[b6, a6]=ellip (n6, 1, 50, wn6);
[H6, f]=freqz(b6, a6, 1000, fs);
semilogx(f, abs(H6)), hold on

b=[b1' b2' b3' b4' b5' b6'];
a=[a1' a2' a3' a4' a5' a6'];

for k=1:6
    y(:,k)=filter(b(:,k), a(:,k),x);
    RMS (k,1)=rms(y(:,k));

end

%Kopija iz prvog zadatka

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
title('Vremenska promena nivoa signala')
subplot(6,1,2),plot (t, 20*log10(abs(y(:,2)))),
subplot(6,1,3),plot (t, 20*log10(abs(y(:,3)))),
ylabel('Nivo[dB]');
subplot(6,1,4),plot (t, 20*log10(abs(y(:,4)))),
subplot(6,1,5),plot (t, 20*log10(abs(y(:,5)))),
subplot(6,1,6),plot (t, 20*log10(abs(y(:,6)))),
xlabel('Vreme[s]');

x2=x_okt;