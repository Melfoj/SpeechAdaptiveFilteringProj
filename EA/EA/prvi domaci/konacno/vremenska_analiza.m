function vremenska_analiza(xx,fs)


pmax=max(abs(xx));
x=xx/pmax;
t=(0:length(x)-1)/fs;
figure, plot(t,x), legend ('normalizacija signala');

%usrednjavanje
T=[0.01 0.2 1];
usrednjavanje(x,fs,T);

end