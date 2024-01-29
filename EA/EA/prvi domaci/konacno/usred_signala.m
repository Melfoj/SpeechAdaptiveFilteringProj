function usrednjavanje(x,fs,T)
T1=T(1);
T2=T(2);
T3=T(3);
    
usr1=usrednjifunkc(x,fs,T1);
usr2=usrednjifunkc(x,fs,T2);
usr3=usrednjifunkc(x,fs,T3);

n1=length(usr1);
n2=length(usr2);
n3=length(usr3);

t1=(0:n1-1)/fs;
t2=(0:n2-1)/fs;
t3=(0:n3-1)/fs;

figure,plot(t1,mag2db(usr1),t2,mag2db(usr2),'g',t3,mag2db(usr3),'r');

xlabel('Vreme (s)');
ylabel('Nivo [dB]');
hold off
end