[x,fs]=audioread('nansheng.wav'); %�������ź�
sound(x,fs); %���������ź�
N=length(x); %����
n=0:N-1;
w=2*n*pi/N;
y1=fft(x); %��ԭʼ�ź���FFT�任
subplot(2,1,1);
plot(n,x) %��ԭʼ�����źŵ�ʱ����ͼ
title('ԭʼ�����ź�ʱ��ͼ');
xlabel('ʱ��t');
ylabel('��ֵ');
subplot(2,1,2); %��ԭʼ�����źŵ�Ƶ��ͼ
plot(w/pi,abs(y1));
title('ԭʼ�����ź�Ƶ��')
xlabel('Ƶ��Hz');
ylabel('����');