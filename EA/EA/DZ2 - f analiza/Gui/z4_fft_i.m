function []= z4_fft_i(x, fs)

x=x(:,1);

N=length(x); 

X=fft(x, N); 
df=fs/N; 
f=(0:N-1)*fs/N;

figure,
plot(f(1:N/2), abs(X(1:N/2))/max(abs(X))), 
xlabel('f(Hz)'), 
ylabel('Amplitudski spektar do fs/2'); 

fd=round(125/sqrt(2));
fg=round(125*sqrt(2));

for k=0:5
    
   x_okt(fd*2^k:df:fg*2^k)=sum((2/N*(abs(X(fd*2^k:df:fg*2^k)))).^2);
   f_okt(fd*2^k:df:fg*2^k)=fd*2^k:df:fg*2^k;
      
end

 figure, 
 semilogx(f_okt,10*log10(x_okt)), 
 xlabel('f[Hz]'), 
 ylabel('Nivo[dB]'),
 title('Okatvni spektar'), 
 grid on;

x4=x_okt;