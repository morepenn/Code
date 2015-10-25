function [longtitude,latitude,result]=Shapefile_cali(filename,target)
%boundary description
    %---------rectangle--------
    lon_min=235.56666667;
    lon_max=245.86666667;
    lat_min=32.533333333;
    lat_max=42.0;
    %---------slash-----------
    %slash=[start,end,position] position=-1 means keep the left, position=1
    %means keep the right
    slash1={[39 240] [42 240] -1};
    slash2={[39 240] [34 245.87] -1};

 
%data readin 
    ds=ncdataset(filename);
    lon=ncread(filename,'lon');
    lat=ncread(filename,'lat');
    result=ds.data(target);



%shape file
    lon_scale=lon(2)-lon(1);
    lat_scale=lat(2)-lat(1);
    factor=0.5;
    a=find(lon>=(lon_min-factor*lon_scale)&lon<=(lon_max+factor*lon_scale));
    b=find(lat>=(lat_min-factor*lat_scale)&lat<=(lat_max+factor*lat_scale));
    
    
    
    
    lon_num=length(a);
    lat_num=length(b);
    
%    longtitude=linspace(lon_min,lon_max,(lon_max-lon_min)/(lon(2)-lon(1)));
%    latitude=linspace(lat_min,lat_max,(lat_max-lat_min)/(lat(2)-lat(1)));
    result=result(:,b(1):b(lat_num),a(1):a(lon_num));
end


