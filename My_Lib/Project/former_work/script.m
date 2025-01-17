function Os=script(L)
load('/Users/penn/Documents/Code/Github/My_Lib/Matlab_Lib/Data Processing/result.mat');
[COEFF,SCORE,latent]=LPCA_p(p_result);
n=5;%number of PC
m=12;%m is the input number; m*n is the input size
%L=30;%neuron number of middle layer
LE=500;%parameter estimation period
 
p=SCORE(:,1:n);
for i=1:size(p,2)
    p(:,i)=(mapminmax(p(:,i)'))';
end

pe=p(1:LE,:);
pv=p(LE+1:length(p),:);

I=[];
O=[];
for i=1:length(pe)-m-1
    input=reshape(pe(i:i+m-1,:),[m*n,1]);
    output=pe(i+m,:)';
    I=[I,input];
    O=[O,output];
end

R=repmat([-1 1],m*n,1);
S=[L,n];
net=newff(R,S,{'tansig','purelin'});
net.performParam.regularization=0.1;
net=train(net,I,O);

Iv=[];
Ov=[];
for i=1:length(pv)-m-1
    input=reshape(pv(i:i+m-1,:),[m*n,1]);
    output=pv(i+m,:)';
    Iv=[Iv,input];
    Ov=[Ov,output];
end

Os=sim(net,Iv);
