cd 'C:\Users\chrs-134\Documents\Github\Code\My_Lib\Matlab_Lib\Course_Climate_Data\h5_Copulas';
data=load('td.txt');
precip=data(:,1);
soilm=data(:,2);


data=load('td.txt');
dp=data(:,1);
ds=data(:,2);
disp=empdis(dp);
diss=empdis(ds);

copname='Frank';
theta=copulafit(copname,[disp,diss]);
value=copulacdf(copname,[disp,diss],theta);
surf(dp,ds,value);

y=norminv(value);

value_e=emp_biv([dp,ds]);

ddp=0.01:0.01:0.99;
dds=0.01:0.01:0.99;
para_cop=[ddp',dds',copulacdf(copname,[ddp',dds'],theta)];

result=[];
for i=0.01:0.05:0.99
    dds=0.01:0.05:0.99;
    dds=dds';
    ddp=i*ones(length(dds),1);
    para_cop=copulacdf(copname,[ddp,dds],theta);
    result=[result;[ddp,dds,para_cop]];
end
