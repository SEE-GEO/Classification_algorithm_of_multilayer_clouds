% read own data 
% 20.08.2018 - 14.09.2018
% 26 days
function [Rasohelp,lDate,idx_dayl,day, month, year, hour, minute, sek,altitude,temp,press,RHl,lat,lon,NoRasoNum,idx_dayk] = Raso_1_arctic_read(filename_RS,i,measday,measmonthunique,im,station,Myfileinfo,ix)
clear NoRasoNum Raso

NoRasoNum=0;       %NoRasoNum=0: a radiosounding exists, NoRasoNum=1=no raso exists for this day i.

%%

%addpath('Inputdata/'); diffrent readin Fles due to different radiosonde
%data formates. Need to be adjusted indeividually
switch true
    case (strcmpi(station,'AO2018')==1)
        [ETIM, hour, minute, sek, press, temp, RHl, lat, lon, altitude, day, month, year] = textread(filename_RS,'%f %u:%u:%u %f %f %f %*f %*f %*f %*f %*f %f %f %*f %f %*f %*f %*f %*f %*f %u.%u.%u','headerlines', 15);
    case (strcmpi(station,'ACSE')==1)
        [ETIM, hour, minute, sek, press, temp, RHl, lat, lon, altitude, day, month, year, PotTemp] = readInRS_2(filename_RS,i,station,ix);
    case (strcmpi(station,'MOSAIC')==1)
        [ETIM, hour, minute, sek, press, temp, RHl, lat, lon, altitude, day, month, year, PotTemp] = readInRS_2(filename_RS,i,station,ix);
    case (strcmpi(station,'NYA')==1)
        [ETIM, hour, minute, sek, press, temp, RHl, lat, lon, altitude, day, month, year, PotTemp] = readInRS_2(filename_RS,i,station,ix); 
    case (strcmpi(station,'Utq')==1)
        [ETIM, hour, minute, sek, press, temp, RHl, lat, lon, altitude, day, month, year, PotTemp] = readInRS2_Ut_single(filename_RS,i,station,Myfileinfo);   
end
lRaso=length(year);                 %counts the length of the file entries
%%
    k=1;
    l=1;
 for j=1:lRaso    
      %collect all indicies (idx_dayk) for one day: 
     if day(j)==measday(i) %going through the file
         idx_dayk(k)=j;                      %all indicies of raso launch
         k=k+1;
     end
 end
%% 
     if exist('idx_dayk','var')==0                           %if no Raso
        disp('no Radiosonde');
     end
%%    
if exist('idx_dayk','var') == 1
     idx_dayk2 = find(month(idx_dayk) == measmonthunique(im));
     idx_dayk = idx_dayk(idx_dayk2);
     if isempty(idx_dayk) == 0   
          %for jx = 1 : length(idx_dayk2)
             switch true
                 case (strcmpi(station,'AO2018')==1)
                    idx_dayl2 = find(ETIM(idx_dayk) == 0); %(to fine the start of the radiosonding. Needs to be adjusted to different datases
                 case (strcmpi(station,'MOSAIC')==1)
                    idx_dayl2 = find(altitude(idx_dayk) == 10);  
                 case (strcmpi(station,'ACSE')==1)
                    idx_dayl2 = find(altitude(idx_dayk) == 13);    
                 case (strcmpi(station,'NYA')==1)
                    idx_dayl2 = find(ETIM(idx_dayk) == 0); 
                    if length(idx_dayl2) == 0
                        idx_dayl2 = find(ETIM(idx_dayk) == 1);
                    end
                 case (strcmpi(station,'Utq')==1)                    
                    idx_dayl2 = find(altitude(idx_dayk) >= 8 & altitude(idx_dayk) <= 10);%8.5);                    
              end
         %end

         idx_dayl = idx_dayk(idx_dayl2);
         ind_dayl = find(diff(idx_dayl) == 1);
         idx_dayl(ind_dayl +1) = [];
         a = isnan(idx_dayl);
         if a == 1
             idx_dayl  =[];
         end
         l = length(idx_dayl);

    clear idx_dayk2 idx_dayl2


       if l==0                                    %If there is no Raso at this day
            disp('no Raso')
            NoRasoNum=1;
            Rasohelp.Ndate=NaN;
            Rasohelp.date=NaN;  
            Rasohelp.RasoNum = 0;
            lDate = 1;
            idx_dayl = NaN;
            sek = NaN;
            altitude = NaN;
            temp = NaN;
            press = NaN;
            RHl = NaN;
            lat = NaN;
            lon = NaN;
            %NoRasoNum = NaN;
            idx_dayk = NaN;


       else                                       %If there are Raso at this day

        %Raso Begins:
         Rasohelp.Ndate=datenum(year(idx_dayl),month(idx_dayl),day(idx_dayl),hour(idx_dayl),minute(idx_dayl),sek(idx_dayl));
         Rasohelp.date=datestr(Rasohelp.Ndate);       % calculate Time of Raso begin
         Rasohelp.RasoNum = l;
         sR=size(Rasohelp.date);
         lDate=(sR(1));                               % Starttime
         
       end 
     else
        disp('no Raso')
        NoRasoNum=0;
        Rasohelp.Ndate=NaN;
        Rasohelp.date=NaN;  
        Rasohelp.RasoNum = 0;
        lDate = 1;
        idx_dayl = NaN;
        sek = NaN;
        altitude = NaN;
        temp = NaN;
        press = NaN;
        RHl = NaN;
        lat = NaN;
        lon = NaN;
        idx_dayk = NaN;
     end
     
else
    disp('no Raso')
    NoRasoNum=0;
    Rasohelp.Ndate=NaN;
    Rasohelp.date=NaN;  
    Rasohelp.RasoNum = 0;
    lDate = 1;
    idx_dayl = NaN;
    sek = NaN;
    altitude = NaN;
    temp = NaN;
    press = NaN;
    RHl = NaN;
    lat = NaN;
    lon = NaN;
    idx_dayk = NaN;
    
end
end
