function [ y ] = fitnessLogistic_nclasses(x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

traing_data=importdata('training_data.mat');
A = [traing_data(:,1:9),traing_data(:,13)];
nbug=traing_data(:,10);
cost=traing_data(:,12);
result=A*x(:,2:11)'+repmat(x(:,1)',length(A(:,1)),1);%x�������е�һ��  length(A(:,1))��1��
pred=Logistic(result);
y(:,1)=(pred>0.5)'*cost;
y(:,2)=-(pred>0.5)'*real(nbug>0);%real(nbug>0) nbug�Ƿ����0 ����1��0��

function Output = Logistic(Input)
Output = 1 ./ (1 + exp(-Input));
end
end


