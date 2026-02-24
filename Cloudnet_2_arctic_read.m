
%This program reads the Radar(Cloudnet) data. The path to the data is specified at the beginning of the
%in the main program.

clear Cloudnet NoCloudnet.Num
   
for it = 1:2    
%open file:
    try

        if it ==1
            Cloudnet_long(it).number=i;
            switch true
                case (strcmpi(station,'ACSE')==1)
                file=strxcat(yyyy(i),Monthfile(i,:),Dayfile(i,:),'_oden_categorize.nc');
                case (strcmpi(station,'AO2018')==1)
                file=strxcat(yyyy(i),Monthfile(i,:),Dayfile(i,:),'_oden_categorize.nc');
                case (strcmpi(station,'MOSAIC')==1)    
                file=strxcat(yyyy(i),Monthfile(i,:),Dayfile(i,:),'_rv-polarstern_categorize.nc');
                case (strcmpi(station,'NYA')==1)
                file=strxcat(yyyy(i),Monthfile(i,:),Dayfile(i,:),'_ny-alesund_categorize.nc');  
            end
            ncid=netcdf.open(file,'NC_NOWRITE');
            yyyyf=double(yyyy(i));
            mmf=str2num(Monthfile(i,:));
            ddf=str2num(Dayfile(i,:)); 

        elseif it==2
            Cloudnet_long(it).number=i+1;
            switch true
            case (strcmpi(station,'AO2018')==1)
            file=strxcat(yyyy(i+1),Monthfile(i+1,:),Dayfile(i+1,:),'_oden_categorize.nc');
            case (strcmpi(station,'MOSAIC')==1)
            file=strxcat(yyyy(i+1),Monthfile(i+1,:),Dayfile(i+1,:),'_rv-polarstern_categorize.nc');
            case (strcmpi(station,'NYA')==1)
            file=strxcat(yyyy(i),Monthfile(i+1,:),Dayfile(i+1,:),'_ny-alesund_categorize.nc'); 
            end
            ncid=netcdf.open(file,'NC_NOWRITE');

            yyyyf=double(yyyy(i+1));
            mmf=str2num(Monthfile(i+1,:));
            ddf=str2num(Dayfile(i+1,:)); 
        end


    varid = netcdf.inqVarID(ncid,'time');
    time = double(netcdf.getVar(ncid,varid));
    Cloudnet_long(it).N=datenum(yyyyf,mmf,ddf,time,0,0);
    Cloudnet_long(it).date=datestr(Cloudnet_long(it).N(1));

    %height in m
    varid = netcdf.inqVarID(ncid,'height');
    height = double(netcdf.getVar(ncid,varid));
    Cloudnet_long(it).height=height;

    %Radar reflectivity factor in dBz:
    varid = netcdf.inqVarID(ncid,'Z');
    Z = double(netcdf.getVar(ncid,varid));
    Z(Z <= -100) = NaN;
    Z(Z >= 100) = NaN;
    Cloudnet_long(it).Z=Z;
   

    %Radar sensitivity in dBz:
    varid = netcdf.inqVarID(ncid,'Z_sensitivity');
    Zsens = double(netcdf.getVar(ncid,varid));
    Cloudnet_long(it).Zsens=Zsens;

    %Radar sensitivity in dBz:
    varid = netcdf.inqVarID(ncid,'radar_gas_atten');
    gasatten = double(netcdf.getVar(ncid,varid));
    Cloudnet_long(it).gasatten=gasatten;

    %Attenuated backscatter coefficient in m-1 sr-1
    varid = netcdf.inqVarID(ncid,'beta');
    beta = double(netcdf.getVar(ncid,varid));
    Cloudnet_long(it).beta=beta;

    %Doppler velocity in m s-1
    v=ncread(file, 'v');             
    Cloudnet_long(it).v=v;

    %Doppler spectral width in m s-1 
    width=ncread(file, 'width');             
    Cloudnet_long(it).width=width;

    %category_bits
    category_bits=ncread(file, 'category_bits');             
    Cloudnet_long(it).category=category_bits;

    %quality_bits
    quality_bits=ncread(file, 'quality_bits');             
    Cloudnet_long(it).quality=quality_bits;

    %model_height for temperature
    model_height=ncread(file, 'model_height');             
    Cloudnet_long(it).model_height=model_height;

    temperature=ncread(file, 'temperature');             
    Cloudnet_long(it).temperature=temperature;

    %%% target_classification from clasification file
%     varid = netcdf.inqVarID(ncid,'target_classification');
%     target_classification = double(netcdf.getVar(ncid1,varid));
%     Cloudnet_long(it).target_classification=target_classification;



    netcdf.close(ncid)

    %%
    %make Cloudnet smaller, to hmax.

    %for limiting height where we look for multi-layer clouds:
    x = Cloudnet_long(it).height;
    valueToMatch = hmax*1e3;
    [minDifferenceValue, indexAtMin] = min(abs(x - valueToMatch));          % Find the closest value.

    Cloudnet(it).number=Cloudnet_long(it).number;
    Cloudnet(it).N=Cloudnet_long(it).N;
    Cloudnet(it).date=Cloudnet_long(it).date;
    Cloudnet(it).height=Cloudnet_long(it).height(1:indexAtMin,:);
    Cloudnet(it).Z=Cloudnet_long(it).Z(1:indexAtMin,:);
    Cloudnet(it).Zsens=Cloudnet_long(it).Zsens(1:indexAtMin,:);
    Cloudnet(it).beta=Cloudnet_long(it).beta(1:indexAtMin,:);
    Cloudnet(it).gasatten=Cloudnet_long(it).gasatten(1:indexAtMin,:);
    Cloudnet(it).v=Cloudnet_long(it).v(1:indexAtMin,:);
    Cloudnet(it).width=Cloudnet_long(it).width(1:indexAtMin,:);
    Cloudnet(it).category=Cloudnet_long(it).category(1:indexAtMin,:);
    Cloudnet(it).quality=Cloudnet_long(it).quality(1:indexAtMin,:);
    Cloudnet(it).model_height=Cloudnet_long(it).model_height;
    Cloudnet(it).temperature=Cloudnet_long(it).temperature;


    NoCloudnet(it).Num=0;                                %if Cloudnet exists: NoCloudnetNum=0

       %end
    %end
     catch                                           %if no Cloudnet exitst
        Cloudnet(it).number=Cloudnet_long.number;
        Cloudnet(it).N=NaN;
        Cloudnet(it).date=NaN;
        Cloudnet(it).height=NaN;
        Cloudnet(it).Z=NaN(2);
        Cloudnet(it).Zsens=NaN(2);
        Cloudnet(it).beta=NaN(2);
        Cloudnet(it).gasatten=NaN(2);
        Cloudnet(it).v=NaN(2);
        Cloudnet(it).width=NaN(2);
        Cloudnet(it).category=NaN(2);
        Cloudnet(it).quality=NaN(2);
        Cloudnet(it).model_height=NaN;
        Cloudnet(it).temperature=NaN;

        NoCloudnet(it).Num=1;                            %if no Cloudnet exitst: NoCloudnetNum=1
        disp('no Cloudnet');



    end
end
%%

clear quality_bits minDifferenceValue valueToMatch x last mmf ddf yyyyf ncid Radartime v Z width varid ...
   beta  indexAtMin category_bits model_height Radartemperature Radarheight  Zsens gasatten  lon lat
% Cloudnet_long