%This program sorts out some special cases.
%Thereafter the program defines (by using gapmin) where to avarage the Cloudnet data. 

if NoRasoNum==1                             %if there is no Raso
    MLC_classification(xDate).Zbelow=NaN; 
    MLC_classification(xDate).Zbetween=NaN;
    MLC_classification(xDate).Zabove=NaN;
end  

if NoCloudnet(1).Num==1                         %If there is no Cloudnet Data
    MLC_classification(xDate).hmax=NaN;                 %hmax and all other variables are not evaluated.
    MLC_classification(xDate).cloud_layers=NaN;
    MLC_classification(xDate).nocloud_layers=NaN;
    MLC_classification(xDate).Seeding=NaN;
    MLC_classification(xDate).fallbeginn=NaN;
    MLC_classification(xDate).fallend=NaN;
    MLC_classification(xDate).Zbelow=NaN;
    MLC_classification(xDate).Zbetween=NaN;
    MLC_classification(xDate).Zabove=NaN; 
    MLC_classification(xDate).lat = Raso(jDate).lat(1);
    MLC_classification(xDate).lon = Raso(jDate).lon(1);
end

if sizeZ(2)<=30                             %i=34,289,290,328
    MLC_classification(xDate).hmax=NaN;                 %The cloudnet data is only during a short part of the day
    MLC_classification(xDate).cloud_layers=NaN;
    MLC_classification(xDate).nocloud_layers=NaN;
    MLC_classification(xDate).Seeding=NaN;
    MLC_classification(xDate).fallbeginn=NaN;
    MLC_classification(xDate).fallend=NaN; 
    MLC_classification(xDate).Zbelow=NaN;  
    MLC_classification(xDate).Zbetween=NaN;
    MLC_classification(xDate).Zabove=NaN;
    MLC_classification(xDate).lat = Raso(jDate).lat(1);
    MLC_classification(xDate).lon = Raso(jDate).lon(1);
    disp('This day is deleted since there is not enough Cloudnet data.');
end 

% try
% if numcloud(jDate)<=1 && NoCloudnet(1).Num==0 && NoRasoNum==0 && sizeZ(2)>30          %If there is only one or no cloudlayer
%     MLC_classification(xDate).nocloud_layers=0;   
%     MLC_classification(xDate).Zbelow=NaN;
%     MLC_classification(xDate).Zbetween=NaN;
%     MLC_classification(xDate).Zabove=NaN;
%     
% end
% catch
% end

try
if numcloud(jDate)==1 && NoCloudnet(1).Num==0 && NoRasoNum==0 && sizeZ(2)>30          %If there is only one or no cloudlayer
    SLC_classification(xDate).nocloud_layers=0;   
    SLC_classification(xDate).Zbelow=NaN;
    SLC_classification(xDate).Zbetween=NaN;
    SLC_classification(xDate).Zabove=NaN;
end
catch
end
%%
%in all other cases 

if NoRasoNum==0                              %if there is Raso available  
if NoCloudnet(1).Num==0                          %if Cloudnet is available
if sizeZ(2)>30                               %if Cloudnet is available at right time
%if numcloud(jDate)>=1                        %if there are min 2 supersaturated layers % change Peggy 30.07.2021 to get single layer clouds as well
    
    %check if tadv has been calculated and exists.
    ex=isfield(Raso10km(jDate),'tadv');
       
    if ex==1
        tadv= Raso10km(jDate).tadv;
        tadv(find(tadv==Inf))=NaN;      %case i=2  idx 597 is inf.
        tadv(find(tadv < 0))=NaN;      %case i=2  idx 597 is inf.
        tadv_mean=nanmean(tadv); 
        tadv_mean=double(tadv_mean);
    elseif ex==0                            %case 24
        tadv_mean=0;
    end
  
    %%
    if timeStart==23
        
           %Finding timeperiod
           [yy, mm, dd, hh, minu, sek]=datevec(Raso10km(jDate).N(1));
           Nbefore = datenum(yy,mm,dd,hh-1,minu-gap_min,sek+tadv_mean);  %with advection
           %Nbefore = datenum(yy,mm,dd,hh,minu-gap_min,sek);           %without advection

           [yy, mm, dd, hh, minu, sek]=datevec(Raso10km(jDate).N(end)); %Rasolaunch end +30min
           Nafter = datenum(yy,mm,dd+1,hh,minu+gap_min,sek+tadv_mean);   %with advection  
           %Nafter = datenum(yy,mm,dd,hh,minu+gap_min,sek);            %without advection
           
           x = Cloudnet_short(xDate).N;
           valueToMatch = Nbefore;
          [~, indexAtStart] = min(abs(x - valueToMatch));    % Find the closest value

           x = Cloudnet_short(xDate).N;
           valueToMatch = Nafter;
          [~, indexAtEnd] = min(abs(x - valueToMatch)); 
        
    else
          %Finding timeperiod
          [yy, mm, dd, hh, minu, sek]=datevec(Raso10km(jDate).N(1));
%            sek_tadv_mean=sek+tadv_mean
%            stop
          Nbefore = datenum(yy,mm,dd,hh-1,minu-gap_min,sek+tadv_mean);  %with advection
          [yyx, mmx, ddx, hhx, minux, sekx]=datevec(Nbefore);
          %Nbefore = datenum(yy,mm,dd,hh,minu-gap_min,sek);           %without advection

          [yy, mm, dd, hh, minu, sek]=datevec(Raso10km(jDate).N(end));       %Rasolaunch end +30min
          %[yy mm dd hh minu sek]=datevec(Raso10km.N(1));          %Rasolaunch begin +30min
          Nafter = datenum(yy,mm,dd,hh,minu+gap_min,sek+tadv_mean);   %with advection  
          %Nafter = datenum(yy,mm,dd,hh,minu+gap_min,sek);            %without advection

          x = Cloudnet_short(xDate).N;
          valueToMatch = Nbefore;
         [~, indexAtStart] = min(abs(x - valueToMatch));    % Find the closest value

          x = Cloudnet_short(xDate).N;
          valueToMatch = Nafter;
         [~, indexAtEnd] = min(abs(x - valueToMatch));      % Find the closest value
    
    end

%end
end
end
end

%%

clear cloud cloudZ cloudZmean40 cloudZmean402 cloudZmeanhalf cloudZmeanhalf2 h h1 height helpcloud  hline ...
indexAtMin minDifferenceValue  mu Nafter_new Nansum ...
Nansum_cloud Nansumnot Nansumnot_cloud Nbefore_new nocloud nocloudZ nocloudZmean40 nocloudZmean402 nocloudZmeanhalf ...
nocloudZmeanhalf2 pos1 reso valueToMatch ZnN x   yy1 mm1 dd1 ab ac c ...
Nafter_vec Nbefore_vec Y22 kminus k tadv ex extadv % hh minu sek mm yy dd
