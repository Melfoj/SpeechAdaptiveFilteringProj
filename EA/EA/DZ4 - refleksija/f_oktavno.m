function [f_oktavno,p]=oktavni_spektar(x,fs)

X=fft(x);
N=length(X);

fc=[125 250 500 1000 2000 4000 8000];
f1=round(fc(1)/sqrt(2));
f2=round(fc(1)*sqrt(2));
br_oktava=length(fc);

for br=1:br_oktava
    
    p(f1*2^(br-1):f2*2^(br-1))=1/N^2*sum(2*abs(X(f1*2^(br-1):f2*2^(br-1))).^2);
    f_oktavno(f1*2^(br-1):f2*2^(br-1))=[f1*2^(br-1):f2*2^(br-1)];
    
end

p=10*log10(p);

end