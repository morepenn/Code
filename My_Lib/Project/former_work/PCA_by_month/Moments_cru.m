function [mean,variance]=Moments_cru(data)
mean=zeros(size(data,1),size(data,2),12);
variance=zeros(size(data,1),size(data,2),12);
years=size(data,3)/12-47.0;
for i=(47*12+1):size(data,3)
    month=mod(i,12);
    if month==0
        month=12;
    end
    mean(:,:,month)=mean(:,:,month)+data(:,:,i)/years;
end
for i=(47*12+1):size(data,3)
    month=mod(i,12);
    if month==0
        month=12;
    end
    variance(:,:,month)=variance(:,:,month)+(data(:,:,i)-mean(:,:,month)).^2;
end
variance=variance/(years-1.0);
months=['Jan';'Feb'; 'Mar'; 'Apr' ;'May' ;'Jun'; 'Jul'; 'Aug'; 'Sep'; 'Oct' ;'Nov'; 'Dec'];
%draw%
for i=1:12
    surf(squeeze(mean(:,:,i))');
    axis off;
    caxis([4,35])
%    colorbar;
    view([0,90]);
    grid off;
    title(months(i,:));
    saveas(gcf,['tt_','mean_',months(i,:), '.png']);
    
    
    surf(squeeze(variance(:,:,i))');
    axis off;
    caxis([0,5])
%     colorbar;
    view([0,90]);
    grid off;
    title(months(i,:));
    saveas(gcf,['tt_','variance_',months(i,:), '.png']);
end




