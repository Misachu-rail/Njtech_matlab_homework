[y,fs]=audioread('matlab_useful.mp3'); %��ȡ�����ļ�
sex = 1.4;
sound(y,fs);%��������
pause(3);
x1=y(:,1); %�����y����������,ȡ��1��
sound(voice(x1,sex),fs);
N=length(voice(x1,sex)); %����
n=0:N-1;
w=2*n*pi/N;
y1=fft(voice(x1,sex)); %��ԭʼ�ź���FFT�任
subplot(2,1,1);
plot(n,voice(x1,sex)) %��ԭʼ�����źŵ�ʱ����ͼ
title('���������ź�ʱ��ͼ');
xlabel('ʱ��t');
ylabel('��ֵ');
subplot(2,1,2); %��ԭʼ�����źŵ�Ƶ��ͼ
plot(w/pi,abs(y1));
title('���������ź�Ƶ��')
xlabel('Ƶ��');
ylabel('����');
