function [nivo] = z4_fft_f(X, fmin, fs)

fd=round(fmin/sqrt(2));
fg=round(fmin*sqrt(2));
x_okt=sum((2/fs*(abs(X(fd:fg)))).^2);
   
 nivo=10*log10(x_okt);

