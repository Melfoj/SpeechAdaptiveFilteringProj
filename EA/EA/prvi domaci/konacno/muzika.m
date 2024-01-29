[zvuk2, fs] = audioread('orkestar.wav');


t=(0:length(zvuk2)-1)/fs;
figure, plot(t,zvuk2), legend('vremenski oblik simfonijske muzike');

vremenska_analiza(zvuk2,fs);