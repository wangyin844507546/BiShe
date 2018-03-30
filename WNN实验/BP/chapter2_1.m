
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

%选连样本输入输出数据归一化
[inputn,inputps]=mapminmax(input);
[outputn,outputps]=mapminmax(output);

%% BP网络训练
% %初始化网络结构
net=newff(inputn,outputn,5);

net.trainParam.epochs=100;
net.trainParam.lr=0.1;
net.trainParam.goal=0.001;

%网络训练
net=train(net,inputn,outputn);

%% BP网络预测
%预测数据归一化
inputn_test=mapminmax('apply',input_test,inputps);
 
%网络预测输出
an=sim(net,inputn_test);
 
%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);

%% 结果分析

figure(1)
plot(BPoutput,'r*:')
hold on
plot(output_test,'bo--');
title('预测径流量','fontsize',12)
legend('预测径流量','实际径流量','fontsize',12)
xlabel('时间点')
ylabel('径流量')
%预测误差

