%In this program the radiosoundings are analysed. 
%Given, that a radiosounding exists, the first step is to determine how many super/subsaturated layers exist. 
%The second step is to calculate the mean values of the subsaturated layer.
%The third step is to calculate the survival of a falling ice crystal. 
%The fourth step is to determine if it is a seeding case or not. 
%The results are written into the Auswertung-struct. 

%%

if NoRasoNum==1                                     %If there is no raso
    MLC_classification(kDate).number_i=kDate;
    MLC_classification(kDate).day=i;
    MLC_classification(kDate).date=datestr(NCloudnet(i));
    MLC_classification(kDate).datenum=NCloudnet(i);
    MLC_classification(kDate).hmax=NaN;                         %If there is no raso: Auswertung.hmax=NaN
    MLC_classification(kDate).cloud_layers=NaN;
    MLC_classification(kDate).nocloud_layers=NaN;
    MLC_classification(kDate).Seeding=NaN; 
    MLC_classification(kDate).fallbeginn=NaN;
    MLC_classification(kDate).fallend=NaN;
    MLC_classification(kDate).lat = Raso(iDate).lat(1);
    MLC_classification(kDate).lon = Raso(iDate).lon(1);
   
    
    layers=0;

elseif NoRasoNum==0                                 %If a raso exists
      
    %First step: Count how many cloud layers exist
    if iDate==1
        clear Cloudixd Raso10km
     [Raso10km, numcloud_i, Cloudixd] = func_1_layers(Raso,hmax,rhthres,minsub,minsuperl,minsuperc,iDate); %eu k=1 = _layers
     else
     [Raso10km, numcloud_i, Cloudixd] = func_1_layers_arctic(Raso,hmax,rhthres,minsub,minsuperl,minsuperc,iDate,Raso10km,Cloudixd,numcloud_i);
    end
    numcloud(kDate)=numcloud_i;                           %Amount of supersaturated layers (including ice and max 1x liquid) 

    MLC_classification(kDate).number_i=kDate;  
    MLC_classification(kDate).day=i;
    MLC_classification(kDate).date=Raso(iDate).date; 
    MLC_classification(kDate).datenum=Raso(iDate).N(1); 
    MLC_classification(kDate).hmax=hmax;
    MLC_classification(kDate).cloud_layers=numcloud_i;

    %%
    %Second step: If there are min two supersaturated layers, then there is min one subsaturated layer in between.
    %Calculation of mean RH, Temp, Press for this subsaturated layer in between     
   
     if numcloud_i>=2                                   %If there are min 2 supersaturated layers 
           
         [H_fallbeginn , H_falldown , Press_nocloud ,RHi_nocloud, TK_nocloud]= func_2_avg(Raso, Raso10km, Cloudixd,iDate);
         layers=length(H_fallbeginn);                 %Amount of subsaturated layers
        
         %%
         %Third step: Calculate the survival of the ice crystal
 
         for k=1:layers                             %all subsaturated layers
 
            %Here the mean values can be manipulated:
            RHi1=RHi_nocloud(k);
            TK1=TK_nocloud(k);
            P1=Press_nocloud(k);
            if isnan(P1) == 0
                z1(1)=H_fallbeginn(k);
                r1(1)=Rsize;

                %Calculate the sublimation:
                if isnan(RHi1) == 0
                funcname=strxcat('func_3_icesubl_',ending); %use ending for selection of type function.
                fh = str2func(funcname);
                [maxtime(k), Sublimation(k), esati, esatiM]=fh(RHi1,TK1,P1,z1,r1,Raso,iDate,Cloudixd,k);
                %[maxtime(k), Sublimation(k), esati, esatiM]=func_3_icesubl_HKrP(RHi1,TK1,P1,z1,r1);      %with use of diameter-mass relationsship of S&B.
                %[maxtime(k), Sublimation(k), esati, esatiM]=func_3_icesubl_Mitchell(RHi1,TK1,P1,z1,r1);      %with use of diameter-mass relationsship of S&B.
                    if Sublimation(k).height(end) <= H_falldown(k)  
                            Seeding(k)=1;
                        else
                            Seeding(k)=0;
                    end      
                MLC_classification(kDate).nocloud_layers=layers; 
                MLC_classification(kDate).Seeding=Seeding;                      %write seeding in MLC_classification sturcture
                MLC_classification(kDate).fallbeginn=H_fallbeginn;
                MLC_classification(kDate).fallend=H_falldown;
                end
            else
                Seeding(k) = NaN;
                MLC_classification(kDate).nocloud_layers=layers; 
                MLC_classification(kDate).Seeding=Seeding;                      %write seeding in MLC_classification sturcture
                MLC_classification(kDate).fallbeginn=H_fallbeginn;
                MLC_classification(kDate).fallend=H_falldown;
            end

         end

        elseif numcloud_i==0
        MLC_classification(kDate).nocloud_layers=0;
        MLC_classification(kDate).Seeding=NaN;                          %no seeding
        MLC_classification(kDate).fallbeginn=NaN;
        MLC_classification(kDate).fallend=NaN;
        MLC_classification(kDate).lat = Raso(iDate).lat(1);
        MLC_classification(kDate).lon = Raso(iDate).lon(1);       


        layers=0;
   
        elseif numcloud_i==1

            MLC_classification(kDate).nocloud_layers=1; 
            MLC_classification(kDate).Seeding=NaN;                      %write seeding in MLC_classification sturcture
            MLC_classification(kDate).fallbeginn=NaN;
            MLC_classification(kDate).fallend=NaN;
         
        layers=numcloud_i;
        
       elseif numcloud_i==-1                 %if there is only one or no cloud layer

        MLC_classification(kDate).nocloud_layers=0;
        MLC_classification(kDate).Seeding=NaN;                          %no seeding
        MLC_classification(kDate).fallbeginn=NaN;
        MLC_classification(kDate).fallend=NaN;
        MLC_classification(kDate).lat = Raso(iDate).lat(1);
        MLC_classification(kDate).lon = Raso(iDate).lon(1);

        layers=0;

     elseif isnan(numcloud_i) == 1
         MLC_classification(kDate).nocloud_layers=NaN;
        MLC_classification(kDate).Seeding=NaN;                          %no seeding
        MLC_classification(kDate).fallbeginn=NaN;
        MLC_classification(kDate).fallend=NaN;
        MLC_classification(kDate).lat = Raso(iDate).lat(1);
        MLC_classification(kDate).lon = Raso(iDate).lon(1);

        layers=NaN;

       
     end
     clear Seeding
    %%
end

clear funcname fh
clear hoehe minDifferenceValue2 indexAt2 minDifferenceValue1 indexAt1 valueToMatch1 x1 x2 valueToMatch2



