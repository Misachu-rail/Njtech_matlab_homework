[y,Fs] = audioread('matlab_useful.mp3');
figure;
plot(y);%ԭyƵ��
title('ԭyƵ��');
disp(Fs);
figure;
plot(abs(fft(y)));
title('fft��');