
clc
clear



river1 = xlsread('river.xls');
for i = 1:size(river1,1)-2
    for j = 1:2
        river(i,j) = river1(i+j-1);
    end
end

input = river(1:700,1:2)
output = river1(3:702);
output  = output';
input_test = river(701:size(river,1),1:2);
output_test = river1(703:size(river1,1));
output_test = output_test';

%ѡ����������������ݹ�һ��
[inputn,inputps]=mapminmax(input);
[outputn,outputps]=mapminmax(output);

%% BP����ѵ��
% %��ʼ������ṹ
net=newff(inputn,outputn,5);

net.trainParam.epochs=100;
net.trainParam.lr=0.1;
net.trainParam.goal=0.001;

%����ѵ��
net=train(net,inputn,outputn);

%% BP����Ԥ��
%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test,inputps);
 
%����Ԥ�����
an=sim(net,inputn_test);
 
%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);

%% �������

figure(1)
plot(BPoutput,'r*:')
hold on
plot(output_test,'bo--');
title('Ԥ�⾶����','fontsize',12)
legend('Ԥ�⾶����','ʵ�ʾ�����','fontsize',12)
xlabel('ʱ���')
ylabel('������')
%Ԥ�����

