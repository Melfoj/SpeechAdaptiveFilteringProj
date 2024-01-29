clear all;
close all;
clc;

[a,txt,raw]=xlsread('Eksel.xlsx');

x1=a(:,1);
x2=a(:,2);
x3=a(:,3);
x4=a(:,4);
x5=a(:,5);

fd=round(125/sqrt(2));
fg=round(125*sqrt(2));

for br=1:6
    f_okt(fd*2^(br-1):fg*2^(br-1))=fd*2^(br-1):fg*2^(br-1);
end

figure,
semilogx(f_okt,x1, 'b'),hold on
semilogx(f_okt,x2,'g'),hold on
semilogx(f_okt,x3,'r'),hold on
semilogx(f_okt,10*log10(x4),'c'), hold on
semilogx(f_okt,10*log10(x5),'m'), hold on
legend('Banka filtara','Rucno pravljeni','Decimacija' ,'FFT','Spektrogram');