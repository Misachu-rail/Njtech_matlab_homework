%ԭ��Ƶ�ź�
[y,Fs]=audioread('matlab_useful.mp3');%�ڴ�����Matlab����Ŀ¼�µ���Ƶ�ļ����ƣ�����Ҳ������������·��
sound(y,Fs);%��������
figure(11) 
plot(y);%����ԭʼ����ʱ��ͼ
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ');    
title('ԭʼ����ʱ��ͼ');
Y1=fft(y);
Y=abs(Y1);
figure(12)
plot(Y);%����ԭʼ������FFT�任��Ƶ��ͼ
xlabel('Ƶ��'); 
ylabel('��ֵ');
title('ԭʼ������FFT�任��Ƶ��ͼ');
%%
%FIR��ͨ�˲���
wp=2*pi*1000/Fs;
ws=2*pi*1200/Fs;
Rp=1;
Rs=100;
wdelta=ws-wp;
N=ceil(8*pi/wdelta);%ȡ��
wn=(wp+ws)/2;
[b,a]=fir1(N,wn/pi,hamming(N+1));%ѡ�񴰺���������һ����ֹƵ��
figure(21)
freqz(b,a,512);
title('FIR��ͨ�˲���');
        
y1=filter(b,a,y);
figure(22)
%subplot(2,1,1)
plot(y)
title('FIR��ͨ�˲����˲�ǰ��ʱ����');
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
%subplot(2,1,2)
plot(y1);
title('FIR��ͨ�˲����˲����ʱ����');
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ');    
        
sound(y1,Fs);%�����˲���������ź�
        
F0=fft(y1);
f=Fs*(0:511)/1024;
figure(23)
y2=fft(y);
subplot(2,1,1);
plot(abs(y2));
title('FIR��ͨ�˲����˲�ǰ��Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
subplot(2,1,2)
F2=plot(abs(F0));
title('FIR��ͨ�˲����˲����Ƶ��');
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
%%
%FIR��ͨ�˲���
wp=2*pi*5000/Fs;
ws=2*pi*4800/Fs;
Rp=1;
Rs=100;
wdelta=wp-ws;
N=ceil(8*pi/wdelta);%ȡ��
wn=(wp+ws)/2;
[b,a]=fir1(N,wn/pi,'high');     
figure(24)
freqz(b,a,512);
title('FIR��ͨ�˲���');
        
y1=filter(b,a,y);
figure(25)
subplot(2,1,1)
plot(y)
title('FIR��ͨ�˲����˲�ǰ��ʱ����');
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ');
subplot(2,1,2)
plot(y1);
title('FIR��ͨ�˲����˲����ʱ����');
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ');
        
sound(y1,Fs);%�����˲���������ź�
        
F0=fft(y1,3000);
f=Fs*(0:511)/1024;
figure(26)
y2=fft(y,1024);
subplot(2,1,1);
plot(f,abs(y2(1:512)));
title('FIR��ͨ�˲����˲�ǰ��Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
subplot(2,1,2)
plot(f,abs(F0(1:512)));
title('FIR��ͨ�˲����˲����Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
%%
%FIR��ͨ�˲���
wp1=2*pi*1200/Fs;wp2=2*pi*3000/Fs;
ws1=2*pi*1000/Fs;ws2=2*pi*3200/Fs;
Rp=1;
Rs=100;
wp=(wp1+ws1)/2;ws=(wp2+ws2)/2;
wdelta=wp1-ws1;
N=ceil(8*pi/wdelta);%ȡ��
wn=[wp ws];
[b,a]=fir1(N,wn/pi,'bandpass');      
figure(27)
freqz(b,a,512);
title('FIR��ͨ�˲���');
        
y1=filter(b,a,y);
figure(28)
subplot(2,1,1)
plot(y);
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
title('FIR��ͨ�˲����˲�ǰ��ʱ����');
subplot(2,1,2)
plot(y1);
title('FIR��ͨ�˲����˲����ʱ����');
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
        
sound(y1,Fs);%�����˲���������ź�
        
F0=fft(y1,3000);
f=Fs*(0:511)/1024;
figure(29)
y2=fft(y,1024);
subplot(2,1,1);
plot(f,abs(y2(1:512)));
title('FIR��ͨ�˲����˲�ǰ��Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
subplot(2,1,2)
plot(f,abs(F0(1:512)));
title('FIR��ͨ�˲����˲����Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
%%
%IIR��ͨ�˲���
Ts=1/Fs;
R1=10;
wp=2*pi*1000/Fs;
ws=2*pi*1200/Fs;
Rp=1;
Rl=100;
wp1=2/Ts*tan(wp/2);%��ģ��ָ��ת��������ָ��
ws1=2/Ts*tan(ws/2); 
[N,Wn]=buttord(wp1,ws1,Rp,R1,'s');  %ѡ���˲�������С����
[Z,P,K]=buttap(N);  %����butterworthģ���˲���
[Bap,Aap]=zp2tf(Z,P,K);
[b,a]=lp2lp(Bap,Aap,Wn);   
[bz,az]=bilinear(b,a,Fs); %��˫���Ա任��ʵ��ģ���˲����������˲�����ת��
[H,W]=freqz(bz,az); 
figure(31)
plot(W*Fs/(2*pi),abs(H))
grid
xlabel('Ƶ�ʣ�Hz');
ylabel('Ƶ����Ӧ����');
title('IIR��ͨ�˲���');
       
       
f1=filter(bz,az,y);
figure(32)
subplot(2,1,1)%�����˲�ǰ��ʱ��ͼ
plot(y); 
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
title('IIR��ͨ�˲����˲�ǰ��ʱ����');
subplot(2,1,2)
plot(f1);%�����˲����ʱ��ͼ
title('IIR��ͨ�˲����˲����ʱ����');
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ');
       
sound(f1,Fs);%�����˲�����ź�
       
F0=fft(f1,3000);
f=Fs*(0:511)/1024;
figure(33)
y2=fft(y,1024);
subplot(2,1,1);
plot(f,abs(y2(1:512)));%�����˲�ǰ��Ƶ��ͼ
title('IIR��ͨ�˲����˲�ǰ��Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
subplot(2,1,2)
f=Fs*(0:511)/1024;
F1=plot(f,abs(F0(1:512)));%�����˲����Ƶ��ͼ
title('IIR��ͨ�˲����˲����Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
%%
%IIR��ͨ�˲���
Ts=1/Fs;
R1=50;
Wp=2*pi*5000/Fs;
Ws=2*pi*3000/Fs;
Rp=1;
Rl=100;
Wp1=2/Ts*tan(Wp/2);%��ģ��ָ��ת��������ָ��
Ws1=2/Ts*tan(Ws/2); 
[N,Wn]=cheb2ord(Wp1,Ws1,Rp,Rl,'s');%ѡ���˲�������С����
[Z,P,K]=cheb2ap(N,Rl);  %�����б�ѩ��ģ���˲���
[Bap,Aap]=zp2tf(Z,P,K);
[b,a]=lp2hp(Bap,Aap,Wn);   
[bz,az]=bilinear(b,a,Fs); %��˫���Ա任��ʵ��ģ���˲����������˲�����ת��
[H,W]=freqz(bz,az); %����Ƶ����Ӧ����
figure(34)
plot(W*Fs/(2*pi),abs(H));
grid
xlabel('Ƶ�ʣ�Hz');
ylabel('Ƶ����Ӧ����');
title('IIR��ͨ�˲���');
        
f1=filter(bz,az,y);
figure(35)
subplot(2,1,1)
plot(y);%�����˲�ǰ��ʱ��ͼ
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
title('IIR��ͨ�˲����˲�ǰ��ʱ����');
subplot(2,1,2)
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
plot(f1);
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
title('IIR��ͨ�˲����˲����ʱ����');
        
sound(f1,Fs);  %�����˲�����ź�
        
F0=fft(f1,1024);
figure(36)
y2=fft(y,1024);
subplot(2,1,1);
plot(f,abs(y2(1:512)));  %�����˲�ǰ��Ƶ��ͼ
title('IIR��ͨ�˲����˲�ǰ��Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
subplot(2,1,2)
f=Fs*(0:511)/1024;
plot(f,abs(F0(1:512)));  %�����˲����Ƶ��ͼ
title('IIR��ͨ�˲����˲����Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
%%
%IIR��ͨ�˲���
Ts=1/Fs;
R1=30;
fb1=1200;
fb2=3000;
fc1=1000;
fc2=3200;
Fs=22050;
W1=2*fb1*pi/Fs;
W2=2*fc1*pi/Fs;
W3=2*fb2*pi/Fs;
W4=2*fc2*pi/Fs;
Wp=[W1,W3];
Ws=[W2,W4];
Rp=1;
Rl=100;
Wp1=2/Ts*tan(Wp/2); %��ģ��ָ��ת��������ָ��
Ws1=2/Ts*tan(Ws/2); 
[N,Wn]=cheb2ord(Wp1,Ws1,Rp,R1,'s');  %ѡ���˲�������С����
[Z,P,K]=cheb2ap(N,Rl);   %�����б�ѩ��ģ���˲���
[Bap,Aap]=zp2tf(Z,P,K);
[b,a]=lp2bp(Bap,Aap,2100*2*pi,1800*2*pi);   
[bz,az]=bilinear(b,a,Fs); %��˫���Ա任��ʵ��ģ���˲����������˲�����ת��
[H,W]=freqz(bz,az);  %����Ƶ����Ӧ����
figure(37)
plot(W*Fs/(2*pi),abs(H));
grid
xlabel('Ƶ�ʣ�Hz');
ylabel('Ƶ����Ӧ����');
title('IIR��ͨ�˲���');
       
f1=filter(bz,az,y);
figure(38)
subplot(2,1,1)
plot(y); %�����˲�ǰ��ʱ��ͼ
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
title('IIR��ͨ�˲����˲�ǰ��ʱ����');
subplot(2,1,2)
F0=fft(f1,1024);
f=Fs*(0:511)/1024;
plot(f1);
title('IIR��ͨ�˲����˲����ʱ����');
xlabel('ʱ�䣨ms)'); 
ylabel('��ֵ'); 
       
sound(f1,Fs);  %�����˲�����ź�
       
F0=fft(f1,3000);
figure(39)
y2=fft(y,1024);
f=Fs*(0:511)/1024;
subplot(2,1,1);
plot(f,abs(y2(1:512)));  %�����˲�ǰ��Ƶ��ͼ
title('IIR��ͨ�˲����˲�ǰ��Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');
subplot(2,1,2)
plot(f,abs(F0(1:512))); %�����˲����Ƶ��ͼ
title('IIR��ͨ�˲����˲����Ƶ��')
xlabel('Ƶ��/Hz');
ylabel('��ֵ');