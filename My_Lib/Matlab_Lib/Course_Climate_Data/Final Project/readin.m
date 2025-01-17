function readin()
cd '/Users/penn/Documents/Data/fianl_project';
filename='/Users/penn/Documents/Data/monthly_P_T/Climate Research Unit/cru_ts3.23.1901.2014.pre.dat.nc';
lon=ncread(filename,'lon');
lat=ncread(filename,'lat');

scales=[1,3,6,12];
s_repeat=1;
s_real=1;

for i=1:length(lon)
    for j=1:length(lat)
        x=squeeze(ncread(filename,'pre',[i,j,1],[1,1,24]));
        if not(isnan(x))&&isequal(x(1:12),x(13:24))
            fakeposition(s_repeat,:)=[i,j];
            s_repeat=s_repeat+1;
        elseif not(isnan(x))
            realposition(s_real,:)=[i,j];
            pre=squeeze(ncread(filename,'pre',[i,j,1],[1,1,inf]));
            for k=1:4
                %aggregate
                pre_a=aggregate(pre,scales(k));
                %calculate
                spi_np{s_real}{k}=SPI_np(pre_a,scales(k));
                spi_p{s_real}{k}=SPI_p(pre_a,scales(k));
                disp([i,j,k]);
            end
            s_real=s_real+1;
        end
    end
end
save('spi_np.mat','spi_np');
save('spi_p.mat','spi_p');
end