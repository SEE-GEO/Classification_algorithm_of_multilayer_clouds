%MLC_classification for own data

%The structure of this program is the following:
%1.Settings for the classification
%2.Name: Used as ending for MLC_classification.mat and for saved plots
%3.Date: Defines the time period of the classification.
%4.Single day or loop over time period
%5.Radiosonde evaluation#
%6.Sublimation calculation 
%7.Cloudnet (Radar) evaluation as additional information
%8.Pieplots 
%9.Skill scores
%Turn on/off specific programs for the specific need.

clearvars %-except MLC_classification

%Some extra Matlab programs are needed:
addpath('/home/pachtert/Classification_MLC/Radiosonde/');
load cm.mat;                                                %line colors
Myfileinfo = 1
station = 'ACSE'; %Utq NYA MOSAIC AO2018
per = '_leg2_aug_final_';
    switch true
    case (strcmpi(station,'ACSE')==1)
        
        addpath('/projekt6/aerocloud/Mamip_projekt/ACSE/swerus-2014-cloudnet/categorize/'); 
        filename_RS = '/projekt6/aerocloud/Mamip_projekt/ACSE/RS/SondDataFL_leg2_v2.mat';
    case (strcmpi(station,'AO2018')==1)
        addpath('/projekt6/aerocloud/Peggy/Mamip/AO2018/ao2018-cloudnet-4/categorize/2018/'); 
        filename_RS = '/projekt6/aerocloud/Peggy/Mamip/Mosaic/datasets/edt_1s_2018_all.txt';
    case (strcmpi(station,'MOSAIC')==1)
        addpath('/projekt6/aerocloud/Mamip_projekt/Mosaic/datasets/'); 
        filename_RS ='/projekt6/aerocloud/Mamip_projekt/Mosaic/datasets/PS122_5_radiosonde_202009.tab';
        addpath('/projekt6/aerocloud/Mamip_projekt/Mosaic/datasets/radar/'); 
    case (strcmpi(station,'NYA')==1)
        filename_RS ='/projekt6/aerocloud/Peggy/Mamip/Mosaic/datasets/NYA_radiosonde/NYA_radiosonde_2017-11.tab';
        addpath('/projekt6/aerocloud/Peggy/Mamip/Mosaic/datasets/radar/');  
    case (strcmpi(station,'Utq')==1)
        %Myfileinfo =dir('/projekt2/remsens/data_new/site-campaign/utqiagvik-nsa/INTERPOLATEDSONDE/2018/*201801*.nc');
        Myfileinfo =dir('/projekt6/aerocloud/Mamip_projekt/ARM/Cloudfraction/nsasondewnpnC1.b1.201403*.cdf');
        filename_RS =Myfileinfo;
        addpath('/projekt6/aerocloud/Mamip_projekt/ARM/'); 
        
end
%%
%1.Settings:
%Here you can adjust some settings (max height, relative humidity threshold, etc.):


hmin=0.13;                %Minimum height at groud [m]. Std: hmin=0.2228, oden = 13m
hmax=10;                    %Maximum height [km] upto where it is searched for. Std: hmax=10; 
Rs = [100, 200, 400];
for isize = 2%1 : 3
Rsize=Rs(isize);                 %Radius of ice crystal [mikrometer]. Std Rsize=100 

rhthres=100.0;              %100% before Relative Humidity threshold [%]. Std rhgrenze=100.0 
minsub=150;                 %Minimum thickness of subsaturated layer [m]. Std:20
minsuperc=500.0;             %Minimum thickness cirrus of supersaturated layer [m]. Std:100
minsuperl=100.0;             %Minimum thickness of supersaturated layer [m]. Std:100
%uncert=0.0;                 %Raso uncertainty -5.0, 0.0, 5.0
gap_min=30;                 %This number [min] defines the timeperiod for evaluation of Cloudnet. %Std:30min, for test: 15min
ending='MHP_WC';                %MHP_WC: Mitchell, 1994: Hexagonal plate; Witchell, 2008: capacitance
                            %AG: Aggregate, RC: rimed column, SP: star particle
%%
%2.Name:
%Define an name/ending here. This will be used as ending for the struct MLC_classification....mat and
%for the generated plots.
%It is recommended to change the name if the settings are changed.

%name=strxcat('r',Rsize,ending);                         %Used as Std
name=strxcat(Rsize,'_msub',minsub','_RH',rhthres,'_',hmax,'_',station, per,ending);      %Alternative, if RH is changed
%name=strxcat(Rsize,'_msub',minsub,'uncert95');         %Alternative, if minsub is changed
%name=strxcat(Rsize,'_minsuper',minsuper);              %Alternative, if minsuper is changed
%name=strxcat(Rsize,'_avgtime',gap_min);                %Alternative, if average time is changed 

%%
%3.Date:
%Chose the time period for the analysis: Define the length and start date of the analysed time period.
ii=1:31;
switch true
    case (strcmpi(station,'ACSE')==1)
    NCloudnet=datenum(2014,08,00+ii,00,00,00); % 7 6 ,8 21
    case (strcmpi(station,'AO2018')==1)
    NCloudnet=datenum(2018,08,00+ii,00,00,00);           %Dataset start date (use one day before actual start date), [year, month, day] Std: 2016,06,9 => 10.6.16-9.6.17
    case (strcmpi(station,'MOSAIC')==1)
    NCloudnet=datenum(2020,9,00+ii,00,00,00);           %Dataset start date (use one day before actual start date), [year, month, day] Std: 2016,06,9 => 10.6.16-9.6.17
    case (strcmpi(station,'NYA')==1)
    NCloudnet=datenum(2017,12,00+ii,00,00,00);
    case (strcmpi(station,'Utq')==1)
    NCloudnet=datenum(2014,03,00+ii,00,00,00);
end

[timestruct,dd1,Monthfile,yyyy,Dayfile] = Cloudnet_1_calcN(NCloudnet,ii);       %This function prepares the time for further use, not changed yet
measday = str2num(datestr(NCloudnet,'dd'));
measday = measday(1:end);
measmonthunique = unique(str2num(datestr(NCloudnet,'mm')));
measmonth = str2num(datestr(NCloudnet,'mm'));
measmonth = measmonth(1:end);
MLC_classification = [];
MLC_classification.number_i = [];
%%
%4.Loop: 
% first only raso data 
for im = 1%1 %length(measmonthunique) statt 1
    ix = find(measmonth == measmonthunique(im));
    switch true
        case (strcmpi(station,'ACSE')==1)
            ix = 1 : 167; %74;%length(ii);
    end
    for i=  1 : length(ix)  
        i = ix(i);
        disp(strxcat('Date:',timestruct.time(i,:)));
        %% 5.Radiosonde evaluation  
        [Rasohelp,lDate,idx_dayl,day,month,year,hour,minute,sek,altitude,temp,press,RHl,lat,lon,NoRasoNum,idx_dayk] = Raso_1_arctic_read(filename_RS,i,measday,measmonthunique,im,station,Myfileinfo,ix);
             %%
        if Rasohelp.RasoNum >= 1
        %%
        Cloudixd = NaN;
        Raso10km = NaN;
        if i >= 2
        firstday = MLC_classification(end).number_i;
        end
          for iDate = 1 : lDate 
              if iDate == 1
                [Raso,NoRasoNum] = Raso_2_test_loop(Rasohelp,idx_dayl,day,month,year,hour,minute,sek,altitude,temp,press,RHl,lat,lon,NoRasoNum,idx_dayk,iDate,lDate); 
                else 
                [Raso,NoRasoNum] = Raso_2_test_loop2(Raso,Rasohelp,idx_dayl,day,month,year,hour,minute,sek,altitude,temp,press,RHl,lat,lon,NoRasoNum,idx_dayk,iDate,lDate); 
              end
              if NoRasoNum == 0
                 if i==1
                      kDate=iDate;
                         
                 else
                           kDate=firstday + iDate; 
       
                 end
               
                   kDate_end(i)=kDate;
                   Raso_3_arctic_layers              
                   
                   layer_anzahl(iDate)=layers;
                  
                   Raso_6_arctic_advection

                   zDate=lDate-1;
                   
               clear a c d d3 dhelp dlambda dN dN3 dphi folder idx idx_nonnan ii lambda1 lambda2 lambda3 lat1 lat2 ...
                 lat3 lon1 lon2 lon3 phi1 phi2 phi3 tadv v3

                 % 6.Sublimation calculation plots 
                 try
                  Sublimation_2_arctic_radii
                 catch
                 end
              else
                  disp('no radiosonde file for that timestep')
                  if i == 1
                    kDate_end = 1;
                    iDate = 1;
                    MLC_classification(i).number_i = i;
                    MLC_classification(i).day=i;
                    MLC_classification(i).date=datestr(NCloudnet(i));
                    MLC_classification(i).datenum=NCloudnet(i);
                   else
                    kDate_end(i) = kDate_end(i-1)+1;
                    iDate(i) = iDate + 1;
                    MLC_classification(i).number_i = i;
                    MLC_classification(i).day=i;
                    MLC_classification(i).date=datestr(NCloudnet(i));
                    MLC_classification(i).datenum=NCloudnet(i);
                   end
              end
          end 

          %%
%           clear starttime Rasoyear Rasoday  Rasomonth Rasohour Rasomin Rasosek rhl temp time timestep press alt
%           clear altitude day ETIM i1st idx_begin idx_dayl idx_dayl2 idx_dayk k l idx_last lDate lRaso hour j ...
%           min month press promt Rasohelp RHl sek sR step temp year logei logew lat lon kDate layers
% 
%           clear layer ii j r1 Sublimation tC Seeding maxtime TK1 TK_nocloud RHmax_nocloud RHi_nocloud RHi1 ...
%           Press_nocloud P1 maxtime H_falldown H_fallbeginn z1 Sublimation50 Sublimation100 Sublimation150 ...
%           maxtime50 maxtime100 maxtime150 layer k maxtime400

    %% 7. Including Cloudnet (Radar) for evaluation 
    if NoRasoNum == 0
            yDate=kDate_end(i)-zDate;
          
             for xDate = yDate:kDate_end(i)
                
                   if i==1
                      jDate=xDate;
                   else
                      jDate=abs(xDate-kDate_end(i-1));
                      if jDate == 0
                          jDate = 1;
                      end
                   end
                    switch true
                        case (strcmpi(station,'AO2018')==1)
                            Cloudnet_2_arctic_read
                        case (strcmpi(station,'ACSE')==1)
                            Cloudnet_2_arctic_read 
                        case (strcmpi(station,'Mosaic')==1)
                            Cloudnet_2_arctic_read
                        case (strcmpi(station,'NYA')==1)
                            Cloudnet_2_arctic_read    
                        case (strcmpi(station,'Utq')==1)    
                            Mosaic_arctic_read
                    end
                    
                    if (NoCloudnet(1).Num == 0) && (NoCloudnet(2).Num == 0)
                     Cloudnet_2_arctic_short
                     Cloudnet_4_arctic_preparation_adv
                     Cloudnet_4_arctic_evaluation
                   
              
                         if indexAtStart ~= indexAtEnd
                             Cloudnet_4_arctic_plot_sectionlines   
                         else
                             indexAtStart = indexAtStart -1;
                             if indexAtStart > 0
                             Cloudnet_4_arctic_plot_sectionlines
                             end
                         end
                         
                    else 
                        Cloudnet_short(xDate).number=Cloudnet(1).number;
                        Cloudnet_short(xDate).N=NaN;
                        Cloudnet_short(xDate).date=NaN;
                        Cloudnet_short(xDate).height=NaN;
                        Cloudnet_short(xDate).Z=NaN;
                        Cloudnet_short(xDate).Zsens=NaN;
                        %Cloudnet_short(xDate).beta=NaN;
                        %Cloudnet_short(xDate).gasatten=NaN;
                        Cloudnet_short(xDate).v=NaN;
                        Cloudnet_short(xDate).width=NaN;
                    end
                     
                
             end   
    end
     %%
     %Save
       save(strxcat('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/MLC_classification_',name,'.mat'), 'MLC_classification');
      
       index=1:MLC_classification(end).number_i;
       
       clear layer_anzahl 
        elseif Rasohelp.RasoNum == 0
            if i == 1
                kDate_end = 1;
                iDate = 1;
                MLC_classification(i).number_i = i;
                MLC_classification(i).day=i;
                MLC_classification(i).date=datestr(NCloudnet(i));
                MLC_classification(i).datenum=NCloudnet(i);
            else
            kDate_end(i) = kDate_end(i-1)+1;
            iDate = iDate + 1;
            MLC_classification(i).number_i = i;
            MLC_classification(i).day=i;
            MLC_classification(i).date=datestr(NCloudnet(i));
            MLC_classification(i).datenum=NCloudnet(i);
            end
        end
        
    end 
    
end
clear MLC_classification
end
