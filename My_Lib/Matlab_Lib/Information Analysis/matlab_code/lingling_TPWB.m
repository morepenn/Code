function [result,result_s,nash]=lingling_TPWB()
lag_max=7;
NUM=90;
result_s=ones(NUM,1);
result=ones(NUM,1);
nash=ones(NUM,1);
d=data(1,0);
m=size(d,1);
m=m-NUM*10*(lag_max+1);
for i=370:10:NUM*10
d=data(i,lag_max);
nsample=ceil(m/i);
dd=d(1:nsample,:);
y=dd(:,3*(lag_max+1));
x=dd(:,(lag_max*3+1):(lag_max*3+2));
[z,S]=TPWB(x,y); 
average=mean(y)*ones(nsample,1);
ddd=(y-average)'*(y-average);
nash(i/10)=1-(y-z)'*(y-z)/ddd;
result(i/10)=leonenko_mi(z,y);
d=size(x,1);
zz=[x S(1:d,:)];
result_s(i/10)=MI(zz,y);
end
end
 