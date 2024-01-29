[zvuk1, fs] = audioread('govor.wav');


t=(0:length(zvuk1)-1)/fs;
figure, plot(t,zvuk1), legend('vremenski oblik govornog signala');

vremenska_analiza(zvuk1,fs);