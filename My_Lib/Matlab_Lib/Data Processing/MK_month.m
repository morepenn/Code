function [ptr,ttr]=MK_month(p_result,t_result)
ptr=1000*ones(size(p_result,2),size(p_result,3),12);
ttr=1000*ones(size(t_result,1),size(t_result,2),12);
%pmonth=zeros(size(p_result,1)/12,size(p_result,2),size(p_result,3));
%tmonth=zeros(size(t_result,1),size(t_result,2),size(t_result,3)/12-47);
for i=1:12
    pmonth=p_result(i:12:size(p_result,1),:,:);
    tmonth=t_result(:,:,i:12:size(t_result,3));
    [ptr(:,:,i),ttr(:,:,i)]=p_trendtest(pmonth,tmonth);
end

 
