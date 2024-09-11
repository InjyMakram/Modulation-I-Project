clc
clear all
close all

%read and play the sound
[Mt,Fs]=audioread('Audio.mp3');
sound(Mt,Fs);
Ts=1/Fs;
N=length(Mt);

%generate a carrier signal
Ac=10;
Fc=Fs/10;
t=linspace(0,Ts*N,N);
Ct=Ac.*cos(2*pi*Fc*t);

%plot modulating signal time domain
figure;
plot(t,Mt);
title('modulating signal time domain');
xlabel('time');
ylabel('Mt');

%plot modulating signal freq domain
nfft=1024;
f=linspace(0,Fs,nfft);

Mf=abs(fftshift(fft(Mt,nfft)));

figure;
plot(f,Mf);
title('modulating signal freq domain');
xlabel('frequency');
ylabel('Mf');

%Conventional AM modulation
ka=1;
St_AM=(1+ka*Mt).*transpose(Ct);
Sf_AM=abs(fftshift(fft(St_AM,nfft)));
 
figure; %time domain
plot(t,St_AM);
title('AM modulated signal time domain');
xlabel('time');
ylabel('St_AM');

figure; %freq domain
plot(f,Sf_AM);
title('AM modulated signal freq domain');
xlabel('frequency');
ylabel('Sf_AM');

%AWGN channel AM
Ch1_AM=awgn(St_AM,-10,'measured');
Ch2_AM=awgn(St_AM,20,'measured');
Ch1f_AM=abs(fftshift(fft(Ch1_AM,nfft)));
Ch2f_AM=abs(fftshift(fft(Ch2_AM,nfft)));

%plots of modulated signal with noise (AM)

figure; %time domain awgn -10db
plot(t,Ch1_AM);
title('AM modulated signal with noise time domain -10db');
xlabel('time');
ylabel('St_AM with noise -10db');
figure; %freq domain awgn -10db
plot(f,Ch1f_AM);
title('AM modulated signal with noise freq domain -10db');
xlabel('frequency');
ylabel('Sf_AM with noise -10db');

figure; %time domain awgn 20db
plot(t,Ch2_AM);
title('AM modulated signal with noise time domain 20db');
xlabel('time');
ylabel('St_AM with noise 20db');
figure; %freq domain awgn 20db
plot(f,Ch2f_AM);
title('AM modulated signal with noise freq domain 20db');
xlabel('frequency');
ylabel('Sf_AM with noise 20db');


%Conventional AM demodulation
S1t_10dbAM=Ch1_AM.*transpose(Ct); %10db awgn
S2t_10dbAM=lowpass(S1t_10dbAM,Fc,Fs)-Ac/2;
S2f_10dbAM=abs(fftshift(fft(S2t_10dbAM,nfft)));
 
figure; %time domain
plot(t,S2t_10dbAM);
title('AM demodulated signal time domain with noise -10db');
xlabel('time');
ylabel('St_AM10db');
 
figure; %freq domain
plot(f,S2f_10dbAM);
title('AM demodulated signal freq domain with noise -10db');
xlabel('frequency');
ylabel('Sf_AM10db');


S1t_20dbAM=Ch2_AM.*transpose(Ct); %20db awgn
S2t_20dbAM=lowpass(S1t_20dbAM,Fc,Fs)-Ac/2;
S2f_20dbAM=abs(fftshift(fft(S2t_20dbAM,nfft)));

figure; %time domain
plot(t,S2t_20dbAM);
title('AM demodulated signal time domain with noise 20db');
xlabel('time');
ylabel('St_AM20db');
 
figure; %freq domain
plot(f,S2f_20dbAM);
title('AM demodulated signal freq domain with noise 20db');
xlabel('frequency');
ylabel('Sf_AM20db');


%DSB modulation

St_DSB= Mt.*transpose(Ct);
Sf_DSB=abs(fftshift(fft(St_DSB,nfft)));

figure; %time domain
plot(t,St_DSB);
title('DSB modulated signal time domain');
xlabel('time');
ylabel('St_DSB');

figure; %freq domain
plot(f,Sf_DSB);
title('DSB modulated signal freq domain');
xlabel('frequency');
ylabel('Sf_DSB');

%AWGN channel DSB
Ch1_DSB=awgn(St_DSB,-10,'measured');
Ch2_DSB=awgn(St_DSB,20,'measured');
Ch1f_DSB=abs(fftshift(fft(Ch1_DSB,nfft)));
Ch2f_DSB=abs(fftshift(fft(Ch2_DSB,nfft)));

%plots of modulated signal with noise (DSB)
figure; %time domain awgn -10db
plot(t,Ch1_DSB);
title('DSB modulated signal with noise time domain -10db');
xlabel('time');
ylabel('St_DSB with noise -10db');
figure; %freq domain awgn -10db
plot(f,Ch1f_DSB);
title('DSB modulated signal with noise freq domain -10db');
xlabel('frequency');
ylabel('Sf_DSB with noise -10db');

figure; %time domain awgn 20db
plot(t,Ch2_DSB);
title('DSB modulated signal with noise time domain 20db');
xlabel('time');
ylabel('St_DSB with noise 20db');
figure; %freq domain awgn 20db
plot(f,Ch2f_DSB);
title('DSB modualted signal with noise freq domain 20db');
xlabel('frequency');
ylabel('Sf_DSB with noise 20db');




%DSB demodulation
S1t_10dbDSB=Ch1_DSB.*transpose(Ct); %10db awgn
S2t_10dbDSB=lowpass(S1t_10dbDSB,Fc,Fs);
S2f_10dbDSB=abs(fftshift(fft(S2t_10dbDSB,nfft)));
 
figure; %time domain
plot(t,S2t_10dbDSB);
title('DSB demodulated signal time domain with noise -10db');
xlabel('time');
ylabel('St_DSB10db');
 
figure; %freq domain
plot(f,S2f_10dbDSB);
title('DSB demodulated signal freq domain with noise 10db');
xlabel('frequency');
ylabel('Sf_DSB10db');


S1t_20dbDSB=Ch2_DSB.*transpose(Ct); %20db awgn
S2t_20dbDSB=lowpass(S1t_20dbDSB,Fc,Fs);
S2f_20dbDSB=abs(fftshift(fft(S2t_20dbDSB,nfft)));

figure; %time domain
plot(t,S2t_20dbDSB);
title('DSB demodulated signal time domain with noise 20db');
xlabel('time');
ylabel('St_DSB20db');
 
figure; %freq domain
plot(f,S2f_20dbDSB);
title('DSB demodulated signal freq domain with noise 20db');
xlabel('frequency');
ylabel('Sf_DSB20db');

%SSB modulation
C2t=Ac.*sin(2*pi*Fc*t);
M2t=hilbert(Mt);
St_LSB=(Mt.*transpose(Ct))+(imag(M2t).*transpose(C2t));
St_USB=(Mt.*transpose(Ct))-(imag(M2t).*transpose(C2t));
Sf_LSB=abs(fftshift(fft(St_LSB,nfft)));
Sf_USB=abs(fftshift(fft(St_USB,nfft)));

figure; %time domain LSB
plot(t,St_LSB);
title('LSB modulated signal time domain');
xlabel('time');
ylabel('St_LSB');

figure; %freq domain LSB
plot(f,Sf_LSB);
title('LSB modulated signal freq domain');
xlabel('frequency');
ylabel('Sf_LSB');

figure; %time domain USB
plot(t,St_USB);
title('USB modulated signal time domain');
xlabel('time');
ylabel('St_USB');

figure; %freq domain USB
plot(f,Sf_USB);
title('USB modulated signal freq domain');
xlabel('frequency');
ylabel('Sf_USB');

%AWGN channel SSB
Ch1_LSB=awgn(St_LSB,-10,'measured');
Ch2_LSB=awgn(St_LSB,20,'measured');
Ch1f_LSB=abs(fftshift(fft(Ch1_LSB,nfft)));
Ch2f_LSB=abs(fftshift(fft(Ch2_LSB,nfft)));

Ch1_USB=awgn(St_USB,-10,'measured');
Ch2_USB=awgn(St_USB,20,'measured');
Ch1f_USB=abs(fftshift(fft(Ch1_USB,nfft)));
Ch2f_USB=abs(fftshift(fft(Ch2_USB,nfft)));

%plots of modulated signal with noise (SSB)
%LSB
figure; %time domain awgn -10db
plot(t,Ch1_LSB);
title('LSB modulated signal with noise time domain -10db');
xlabel('time');
ylabel('St_LSB with noise -10db');
figure; %freq domain awgn -10db
plot(f,Ch1f_LSB);
title('LSB modulated signal with noise freq domain -10db');
xlabel('frequency');
ylabel('Sf_LSB with noise -10db');

figure; %time domain awgn 20db
plot(t,Ch2_LSB);
title('LSB modulated signal with noise time domain 20db');
xlabel('time');
ylabel('St_LSB with noise 20db');
figure; %freq domain awgn 20db
plot(f,Ch2f_LSB);
title('LSB modulated signal with noise freq domain 20db');
xlabel('frequency');
ylabel('Sf_LSB with noise 20db');

%USB
figure; %time domain awgn -10db
plot(t,Ch1_USB);
title('USB modulated signal with noise time domain -10db');
xlabel('time');
ylabel('St_USB with noise -10db');
figure; %freq domain awgn -10db
plot(f,Ch1f_USB);
title('USB modulated signal with noise freq domain -10db');
xlabel('frequency');
ylabel('Sf_USB with noise -10db');

figure; %time domain awgn 20db
plot(t,Ch2_USB);
title('USB modulated signal with noise time domain 20db');
xlabel('time');
ylabel('St_USB with noise 20db');
figure; %freq domain awgn 20db
plot(f,Ch2f_USB);
title('USB modulated signal with noise freq domain 20db');
xlabel('frequency');
ylabel('Sf_SB with noise 20db');


%SSB demodulation
S1t_10dbLSB=Ch1_LSB.*transpose(Ct); %10db awgn
S2t_10dbLSB=lowpass(S1t_10dbLSB,Fc,Fs);
S2f_10dbLSB=abs(fftshift(fft(S2t_10dbLSB,nfft)));

S1t_10dbUSB=Ch1_USB.*transpose(Ct); %10db awgn
S2t_10dbUSB=lowpass(S1t_10dbUSB,Fc,Fs);
S2f_10dbUSB=abs(fftshift(fft(S2t_10dbUSB,nfft)));

figure; %time domain LSB
plot(t,S2t_10dbLSB);
title('LSB demodulated signal time domain with noise -10db');
xlabel('time');
ylabel('St_LSB10db');
 
figure; %freq domain LSB
plot(f,S2f_10dbLSB);
title('LSB demodulated signal freq domain with noise -10db');
xlabel('frequency');
ylabel('Sf_LSB10db');

figure; %time domain USB
plot(t,S2t_10dbUSB);
title('USB demodulated signal time domain with noise -10db');
xlabel('time');
ylabel('St_USB10db');
 
figure; %freq domain USB
plot(f,S2f_10dbUSB);
title('USB demodulated signal freq domain with noise 20db');
xlabel('frequency');
ylabel('Sf_USB10db');

S1t_20dbLSB=Ch2_LSB.*transpose(Ct); %20db awgn
S2t_20dbLSB=lowpass(S1t_20dbLSB,Fc,Fs);
S2f_20dbLSB=abs(fftshift(fft(S2t_20dbLSB,nfft)));

S1t_20dbUSB=Ch2_USB.*transpose(Ct); %20db awgn
S2t_20dbUSB=lowpass(S1t_20dbUSB,Fc,Fs);
S2f_20dbUSB=(fftshift(fft(S2t_20dbUSB,nfft)));

figure; %time domain LSB
plot(t,S2t_20dbLSB);
title('LSB demodulated signal time domain with noise -10db');
xlabel('time');
ylabel('St_LSB20db');
 
figure; %freq domain LSB
plot(f,S2f_20dbLSB);
title('LSB demodulated signal freq domain with noise -10db');
xlabel('frequency');
ylabel('Sf_LSB20db');

figure; %time domain USB
plot(t,S2t_20dbUSB);
title('USB demodulated signal time domain with noise 20db');
xlabel('time');
ylabel('St_USB20db');
 
figure; %freq domain USB
plot(f,S2f_20dbUSB);
title('USB demodulated signal freq domain with noise 20db');
xlabel('frequency');
ylabel('Sf_USB20db');


%sounds after demodulation
% sound(S2t_10dbAM,Fs); %after AM demodulation with noise -10db 
%sound(S2t_20dbAM,Fs); %after AM demodulation with noise 20db
%sound(S2t_10dbDSB,Fs);%after DSB demodulation with noise -10db
sound(S2t_20dbDSB,Fs);%after DSB demodulation with noise 20db
% sound(S2t_10dbLSB,Fs);%after LSB demodulation with noise -10db
% sound(S2t_20dbLSB,Fs);%after LSB demodulation with noise 20db
% sound(S2t_10dbUSB,Fs);%after USB demodulation with noise -10db
 %sound(S2t_20dbUSB,Fs);%after USB demodulation with noise 20db

%when hearing the sounds after modulation please comment the rest of the
%sounds to hear 1 by 1, thank you.



 





