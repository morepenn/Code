function [Oe,Ose,Ov,Osv]=BPNN(norm_pca,pc)
clc;
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/p_result.mat');
load('/Users/penn/Documents/Code/Github/My_Lib/Project/data/index.mat');
[COEFF,SCORE,latent]=LPCA_p(p_result,norm_pca);
n=1;%number of PC
m=6;%m is the input number; m*n is the input size
%L=30;%neuron number of middle layer
LE=500;%parameter estimation period
p=SCORE(:,pc:pc+n-1);
%%%%%%%%%
%p=[p mei];
q=nan(length(p),1);
for i=1:length(p)
    q(i)=sin(pi*i/6);
end
p=[p  q mei  pna];
%p=[p      mei(1:length(p)) pna(1:length(p))];
%p=[p,q,mei,pna]; %not so bas pc1 0.75
%p=[p amo ao mei nao nino12 nino3 pna soi wp];
%p=[p nao mei];
%%%%%%%%%
n=size(p,2);
%{
if norm_ann==1
    for i=1:size(p,2)
        p(:,i)=normalization_1(p(:,i));
    end
elseif norm_ann==2
    for i=1:size(p,2)
        p(:,i)=normalization_2(p(:,i));
    end
end
%}
 
pe=p(1:LE,:);
pv=p(LE+1:length(p),:);
I=[];
O=[];
for i=1:length(p)-m-1
    input=reshape(p(i:i+m-1,:),[m*n,1]);
    output=p(i+m,1);
    I=[I,input];
    O=[O,output];
end

Ie=I(:,1:LE);
Iv=I(:,LE+1:length(I));
for i=1:size(Ie,1)
    Ie(i,:)=mapminmax(Ie(i,:));
end

for i=1:size(Iv,1)
    Iv(i,:)=mapminmax(Iv(i,:));
end

Oe=O(:,1:LE);
Ov=O(:,LE+1:length(O));

for i=1:size(Oe,1)
    Oe(i,:)=mapminmax(Oe(i,:));
end

for i=1:size(Ov,1)
    Ov(i,:)=mapminmax(Ov(i,:));
end

net=newff(Ie,Oe,20);
net.trainParam.epochs=100;
net.trainParam.lr=0.1;
net.trainParam.goal=0.00004;
net=train(net,Ie,Oe);
Ose=sim(net,Ie);
Osv=sim(net,Ov);
end




 