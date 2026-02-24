
lMLC=length(index);
idx_1warmcloud = 0;
idx_2warmcloud = 0;
%%
%find amount, where Raso=NaN or Cloudnet=NaN. This is done by using hmax.

for k=1:lMLC
    MLC_hmax(k)=MLC_classification(k).hmax;
    MLC_cloudlayers(k)=MLC_classification(k).cloud_layers;
end

%%
%if Hmax=NaN, then Rasofile or Cloudnet at Rasotime is missing:
idx_Nan=find(isnan(MLC_hmax));                 %index of Position  
if length(idx_Nan) == 0
    idx_Nan = NaN;
end
Anz_Nan=length(idx_Nan);                        %length of Index List                     

idx_0cloud=find(MLC_cloudlayers==0);           %index of Position                         
Anz_0cloud=length(idx_0cloud);                  %length of Index List                    

idx_1cloud=find(MLC_cloudlayers==1);           %index of Position                         
Anz_1cloud=length(idx_1cloud);                  %length of Index List  

idx_2cloud=find(MLC_cloudlayers>=2);           %index of Position                         
Anz_2cloud=length(idx_2cloud);                  %length of Index List  

idx_22cloud=find(MLC_cloudlayers==2);           %index of Position                         
Anz_22cloud=length(idx_22cloud);                  %length of Index List 

idx_3cloud=find(MLC_cloudlayers==3);           %index of Position                         
Anz_3cloud=length(idx_0cloud);                  %length of Index List                    

idx_4cloud=find(MLC_cloudlayers==4);           %index of Position                         
Anz_4cloud=length(idx_1cloud);                  %length of Index List  

idx_5cloud=find(MLC_cloudlayers==5);           %index of Position                         
Anz_5cloud=length(idx_2cloud);                  %length of Index List 

idx_6cloud=find(MLC_cloudlayers==6);           %index of Position                         
Anz_6cloud=length(idx_0cloud);                  %length of Index List                    

idx_7cloud=find(MLC_cloudlayers==7);           %index of Position                         
Anz_7cloud=length(idx_1cloud);                  %length of Index List  

idx_8cloud=find(MLC_cloudlayers==8);           %index of Position                         
Anz_8cloud=length(idx_2cloud);                  %length of Index List 

idx_cloudcover=find(MLC_cloudlayers>=1);       %index of Position                         
Anz_cloudcover=length(idx_cloudcover);          %length of Index List  

idx_nonNan=find(~isnan(MLC_hmax));             %index of Position                         
Anz_nonNan=length(idx_nonNan);                  %length of Index List 

%% look at CTT for 1 cloudlayer:

SLC_CTT_layer1(index)=NaN;
SLC_CBT_layer1(index)=NaN;
SLC_Cbase_layer1(index)=NaN;
SLC_Ctop_layer1(index)=NaN;
SLC_lat_layer1(index)=NaN;
SLC_lon_layer1(index)=NaN;

for k=1:Anz_1cloud
    if isempty(MLC_classification(idx_1cloud(k)).CTT) == 1
       MLC_classification(idx_1cloud(k)).CTT = NaN;
       MLC_classification(idx_1cloud(k)).CBT = NaN;
       MLC_classification(idx_1cloud(k)).cloudbase = NaN;
       MLC_classification(idx_1cloud(k)).cloudtop = NaN;
       MLC_classification(idx_1cloud(k)).lat = NaN;
       MLC_classification(idx_1cloud(k)).lon = NaN;
    end
    SLC_CTT_layer1(k)=MLC_classification(idx_1cloud(k)).CTT(1);
    SLC_CBT_layer1(k)=MLC_classification(idx_1cloud(k)).CBT(1);
    SLC_Cbase_layer1(k)=MLC_classification(idx_1cloud(k)).cloudbase(1);
    SLC_Ctop_layer1(k)=MLC_classification(idx_1cloud(k)).cloudtop(1);
    SLC_lat_layer1(k)=MLC_classification(idx_1cloud(k)).lat(1);
    SLC_lon_layer1(k)=MLC_classification(idx_1cloud(k)).lon(1);
        
end
%% look at CTT for 2 cloudlayer:

MLC_CTT_layer1(index)=NaN;
MLC_CBT_layer1(index)=NaN;
MLC_Cbase_layer1(index)=NaN;
MLC_Ctop_layer1(index)=NaN;
MLC_lat_layer1(index)=NaN;
MLC_lon_layer1(index)=NaN;

for k=1:Anz_22cloud
    if isempty(MLC_classification(idx_22cloud(k)).CTT) == 1
    MLC_CTT_layer1(k)=NaN;
    MLC_CBT_layer1(k)=NaN;
    MLC_Cbase_layer1(k)=NaN;
    MLC_Ctop_layer1(k)=NaN;
    MLC_Cdiff_layer1(k)=NaN;
    MLC_lat_layer1(k)=NaN;
    MLC_lon_layer1(k)=NaN;
    else
    MLC_CTT_layer1(k)=MLC_classification(idx_22cloud(k)).CTT(1);
    MLC_CBT_layer1(k)=MLC_classification(idx_22cloud(k)).CBT(1);
    MLC_Cbase_layer1(k)=MLC_classification(idx_22cloud(k)).cloudbase(1);
    MLC_Ctop_layer1(k)=MLC_classification(idx_22cloud(k)).cloudtop(1);
    if length(MLC_classification(idx_22cloud(k)).cloudbase) == 1
        MLC_Cdiff_layer1(k) = NaN;
    else
        MLC_Cdiff_layer1(k)=MLC_classification(idx_22cloud(k)).cloudbase(2)- MLC_classification(idx_22cloud(k)).cloudtop(1);
    end
    MLC_lat_layer1(k)=MLC_classification(idx_22cloud(k)).lat(1);
    MLC_lon_layer1(k)=MLC_classification(idx_22cloud(k)).lon(1);
    end
end
%%
%look only at cases with 2 or more clouds:

Anz_seeding(index)=NaN;
Anz_nonseeding(index)=NaN;

for k=1:Anz_2cloud

    MLC_seeding_all(:)=MLC_classification(idx_2cloud(k)).Seeding;
    
    idx_seeding=find(MLC_seeding_all==1);              %index of Position                         
    Anz_seeding_help=length(idx_seeding);               %length of Index List 
    Anz_seeding(idx_2cloud(k))=Anz_seeding_help;
    
    idx_nonseeding=find(MLC_seeding_all==0);           %index of Position 
    Anz_nonseeding_help=length(idx_nonseeding);         %length of Index List 
    Anz_nonseeding(idx_2cloud(k))=Anz_nonseeding_help;
   
    clear MLC_seeding_all;    
    
end

%%
Anz_trenn(index)=NaN;

for k=1:lMLC
    
    if Anz_seeding(k)==0 && Anz_nonseeding(k) >=1                   %if no Seeding occurrs
        Anz_trenn(k)=0;
    elseif Anz_seeding(k)>=1 && Anz_nonseeding(k) ==0               %if only Seeding occurrs
        Anz_trenn(k)=1;
    elseif Anz_seeding(k)>=1 && Anz_nonseeding(k) >=1               %if Seeding and no Seeding ocurrs
        Anz_trenn(k)=2;
    end
end

%%

idx_nonseed=find(Anz_trenn==0);                                  
Anz_nonseed=length(idx_nonseed);        %no Seeding 

idx_onlyseed=find(Anz_trenn==1);                                 
Anz_onlyseed=length(idx_onlyseed);      %only Seeding 

idx_both=find(Anz_trenn>1);                                    
Anz_both=length(idx_both);              %both Seeding and no Seeding 

%%
%Include missing Data into Auswertung-struct (where Cloudnet is missing):

for k=1:lMLC
    MLC_date(k)=datenum(MLC_classification(k).date);
end

idx_DateNan=find(isnan(MLC_date));                                 
Anz_DateNan=length(idx_DateNan);                    

for k=1:Anz_DateNan
    [yy2(k-1) mm2(k-1) dd2(k-1)]= datevec(MLC_classification(idx_DateNan(k)-1).date);
    MLC_classification(idx_DateNan(k)).date=datestr(datenum(yy2(k-1), mm2(k-1), dd2(k-1)+1,0,0,0));        
end

%%

clear Anz_2cloud Anz_nonseeding Anz_nonseeding_help Anz_seeding Anz_seeding_help Anz_trenn MLC_cloudlayers MLC_hmax combinedtxt ...
    grey hText idx_2cloud idx_nonseeding idx_seeding k newExtents newExtents_cell offset oldExtents oldExtents_cell ...
    percentValues pos signValues textPositions textPositions_cell txt width_change xoffset XP Xcolor f4 h ...
    MLC_dateRaso idx_DateNan Anz_DateNan yy2 mm2 dd2 
