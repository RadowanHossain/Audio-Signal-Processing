clc;
clear all;
close all;

% Extracting Recorded original Signal
[y1, Fs1] = audioread('My Name Is Radowan Hossain.m4a');

% Showing The details information about the original Signal
info = audioinfo('My Name Is Radowan Hossain.m4a')

%As the the recorded signal has 2 channel so we have taken an average of the signal
y1_mono = mean(y1, 2);

% Setting The time vector
t = 0:1/Fs1:(length(y1_mono) - 1)/Fs1;

%Ploting The Original Signal
subplot(4,1,1);
plot(t, y1_mono);
xlabel('time');
ylabel('amplitude');
title('Original Signal');

% Sampling The original Signal with twice the frequency of the original Signal
Fs2 = 2*Fs1;
y2 = resample(y1_mono, Fs2, Fs1);
t1 = 0:1/Fs2:(length(y2) - 1)/Fs2;

%Ploting The Sampled Signal
subplot(4,1,2);
stem(t1, y2);
xlabel('Discrete (n)');
ylabel('amplitude');
title('Sampling Signal');


% Quantization Of the Signal
nbits = 16; %Number of quantization label
maxa = max(y2);
in = 2 * maxa / (nbits);  %Step Size
u = maxa + in;
l = [-maxa:in:maxa];
c = [-maxa:in:u];
[index, y3] = quantiz(y2, l, c); % Quantization

%Ploting The Quantized Signal
subplot(4,1,3);
stem(t1, y3);
title('Quantized Signal');
xlabel('Disrete (n)');
ylabel('Discrete amplitude');

% Reconstruction of the signal by interpolation
yp = interp1(t1,y3,t,'spline'); %interpolation

%Ploting The Reconstructed Signal
subplot(4,1,4);
plot(t,yp);
title('Reconstructed Signal');
xlabel('time');
ylabel('amplitude');

% To Hear The Reconstructed Signal
sound(yp,Fs1);

%Comment : 

% we compared the original audio file with the reconstructed signal by 
% listening them. In the original signal, no noise was present. A recognizable 
% reproduction of the phrase "My name is Radowan Hossain" in 
% the reconstructed signal indicates a successful reconstruction.But we have 
% got some noise in the reconstructed signal. One of the primary sources of noise 
% in the reconstructed signal is quantization noise. Quantization involves 
% the mapping of the continuous range of signal values onto a finite set of 
% discrete levels. This process inherently introduces errors because the 
% quantized values cannot precisely represent the original continuous signal. 
% Some of the signal values may become distorted during quantization. When we
% interpolate the quantized signal, we are essentially filling in the gaps 
% between the quantized values to create a continuous signal. During this 
% interpolation process, some of the gaps cannot be perfectly matched like 
% the original continuous signal, as  some of the signal values are already 
% distorted when quantized  leading to signal distortion and the introduction 
% of noise.






