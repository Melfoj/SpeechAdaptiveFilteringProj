function [x_okt] = z4(odziv, fmin, fs)

X=fft(odziv);
fd=round(fmin/sqrt(2));
fg=round(fmin*sqrt(2));
x_okt=zeros(0:fs);

for o=1:8
 x_okt(fd:fg)=sum((2/fs*(abs(X(fd:fg)))).^2);

end
   
x_okt=x_okt(fmin);


