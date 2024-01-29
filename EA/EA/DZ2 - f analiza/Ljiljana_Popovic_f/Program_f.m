clear all;
close all;
clc;

[x1]=z1_banka_filtara_f();
[x2]=z2_rucno_f();
[x3]=z3_decimacija_f();
[x4]=z4_fft_f();
[x5]=z5_spektrogram_f();

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
legend('Banka filtara','Rucno pravljeni','Decimacija' ,'FFT','Spektrogram'),
grid on;