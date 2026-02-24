
%In this program the evaluation of the Cloudnet data is done.

clear nocloudZ_Zeit cloudZ_Zeit cloudZmeanhalf3 

if NoRasoNum==0                                %only if Raso is available  
if NoCloudnet(1).Num==0                            %only if Cloudnet exists
if sizeZ(2)>30                                 %only if there is min one cloudless laye
if numcloud(xDate)>=2                          %only if min 1 nocloudlayer (=Auswertung(i).layers_nocloud>=1)
    if layer_anzahl(jDate) > 0    
                                                   % change Peggy 30.07.2021 to get single layer clouds as well
                    datestr(datevec(Nbefore));
                    datestr(datevec(Nafter));   
    %%
    if length(Cloudixd(jDate).index_sub_top) == 0
        Cloudixd(jDate).index_super_bottom = NaN;
        Cloudixd(jDate).index_super_top = NaN;
        Cloudixd(jDate).height_super_bottom = NaN;
        Cloudixd(jDate).height_super_top = NaN;
        Cloudixd(jDate).index_sub_bottom = NaN;
        Cloudixd(jDate).index_sub_top = NaN;
        Cloudixd(jDate).height_sub_bottom = NaN;
        Cloudixd(jDate).height_sub_top = NaN;
    end
        %%
    %For evaluation of the subsaturated layer:

    %This part is needed, since Cloudixd contains the indicies of Raso and this has to be converted to
    %cloudnet indicies:
    %find(layer_anzahl == 0);
    %layer_anzahl(ans) = [];
    for k=1:layer_anzahl(jDate)
        x = Cloudnet_short(xDate).height;
        valueToMatch = Cloudixd(jDate).height_sub_bottom(k);
        [~, indexAtBottomNoCloud(k)] = min(abs(x - valueToMatch));   %find the closest value

        x = Cloudnet_short(xDate).height;
        valueToMatch = Cloudixd(jDate).height_sub_top(k);
        [~, indexAtTopNoCloud(k)] = min(abs(x - valueToMatch));      %find the closest value

    end

    %%

    %Z either NaN or mean value:

    for k=1:layer_anzahl(jDate)                                              %go through subsaturated layers
        if indexAtBottomNoCloud(k)+5 > indexAtTopNoCloud(k)
            indexend_noCloud(k)=indexAtTopNoCloud(k);
        else
            indexend_noCloud(k)=indexAtBottomNoCloud(k)+5;
        end
        nocloud(k).ZNan(:,:)=Cloudnet_short(xDate).Z(indexAtBottomNoCloud(k):indexend_noCloud(k),indexAtStart:indexAtEnd);
        Nansum(k)=sum(sum(isnan(nocloud(k).ZNan)));
        Nansumnot(k)=sum(sum(~isnan(nocloud(k).ZNan)));
    end

    %%
    %Check if there is more NaN or non-NaN in the subsaturated layers

    for k=1:layer_anzahl(jDate)

        if Nansum(k)>Nansumnot(k)                %more Nan than NotNan
            nocloudZmeanhalf(k)=NaN;

        elseif Nansum(k)<=Nansumnot(k)           %more NotNan than Nan
            nocloud(k).ZnNhalf(:,:)=Cloudnet_short(xDate).Z(indexAtBottomNoCloud(k):indexend_noCloud(k),indexAtStart:indexAtEnd);
            nocloudZ(:)=nanmean(nocloud(k).ZnNhalf,1);
            nocloudZmeanhalf(k)=nanmean(nocloudZ); 
        end
    end

    nocloudZ_Zeit=nocloudZmeanhalf; %IMP OUTPUT
    nocloudZ_Zeit;

    for k=1:layer_anzahl(jDate)
        if isnan(nocloudZmeanhalf(k))
            nocloudZmeanhalf2(k)=0;                     %if Nan, then =0 =no cloud
        elseif ~isnan(nocloudZmeanhalf(k))
             nocloudZmeanhalf2(k)=1;                    %if not Nan, then =1 =cloud
        end
    end


        MLC_classification(xDate).Zbetween=nocloudZmeanhalf2;

    %%
    %In supersaturated layers:

    lCloud=length(Cloudixd(jDate).height_super_top);        %lCloud= Amount of supersaturated layers
    %lCloud=length(Cloudixd(jDate).height_super_top); %geaendert Peggy 21.02.2022
    %Find indicies of cloudnet (taken from Raso=Cloudixd), where there is supersaturation:

    for k=1:lCloud
        x = Cloudnet_short(xDate).height;
        valueToMatch = Cloudixd(jDate).height_super_bottom(k);
        [~, indexAtBottomCloud(k)] = min(abs(x - valueToMatch));   %find the closest value

        x = Cloudnet_short(xDate).height;
        valueToMatch = Cloudixd(jDate).height_super_top(k);
        [~, indexAtTopCloud(k)] = min(abs(x - valueToMatch));      %find the closest value

        %find index at bottom+100m
        x = Cloudnet_short(xDate).height;
        valueToMatch = Cloudixd(jDate).height_super_bottom(k)+100;
        [~, indexAtBottomCloud100(k)] = min(abs(x - valueToMatch));%find the closest value

        %if index of bottom+100 is bigger than index of top, then use the index of top. 
        if indexAtBottomCloud100(k)>indexAtTopCloud(k)
            indexAtBottomCloud100(k)=indexAtTopCloud(k);
        end

    end

    %%
    %Count NaN anod non-NaN in supersaturated layers: 

    for k=1:lCloud                                                  %in supersaturated layers   
            cloud(k).ZNan(:,:)=Cloudnet_short(xDate).Z(indexAtBottomCloud(k):indexAtBottomCloud100(k),indexAtStart:indexAtEnd);
            Nansum_cloud(k)=sum(sum(isnan(cloud(k).ZNan)));         %Amount of NaN in supersaturated layers 
            Nansumnot_cloud(k)=sum(sum(~isnan(cloud(k).ZNan)));     %Amount of non-NaN in supersaturated layers
    end 

    %Check if there is more NaN or non-NaN in supersaturated layers:
    for k=1:lCloud
        if Nansum_cloud(k)>Nansumnot_cloud(k)                   %more NaN than non-NaN
            cloudZmeanhalf(k)=NaN;
        elseif Nansum_cloud(k)<=Nansumnot_cloud(k)              %more non-NaN than Nan
            helpcloud=Cloudnet_short(xDate).Z(indexAtBottomCloud(k):indexAtBottomCloud100(k),indexAtStart:indexAtEnd);
            cloudZ(:)=nanmean(helpcloud,1);
            cloudZmeanhalf(k)=nanmean(cloudZ);
        end 
    end

    if lCloud > 0
    cloudZ_Zeit=cloudZmeanhalf; %IMP OUTPUT
    cloudZ_Zeit;

    %Convert NaN into 0=no cloud 1=cloud in supersaturated layer

    for k=1:lCloud
        if isnan(cloudZmeanhalf(k))
            cloudZmeanhalf2(k)=0;                     %if Nan, then =0 =no cloud 
        elseif ~isnan(cloudZmeanhalf(k))
             cloudZmeanhalf2(k)=1;                    %if not Nan, then =1 =cloud
        end
    end



        MLC_classification(xDate).Zabove=cloudZmeanhalf2;
    else 
        MLC_classification(xDate).Zabove = NaN;
    end
        %%
        %if numcloud(xDate)>=2 

            MLC_classification(xDate).Zbelow=MLC_classification(xDate).Zabove;
            MLC_classification(xDate).Cloud=MLC_classification(xDate).Zabove;
            MLC_classification(xDate).Zbelow(:)=3;

            for k=1:lCloud                                              %all supersaturated layers
                idxTop(k)=indexAtTopCloud(k);
                last=0;

                if indexAtTopCloud(k)==indexAtBottomCloud(k)            %case 359
                    cloud(k).ZNan2=Cloudnet_short(xDate).Z(indexAtBottomCloud(k):indexAtTopCloud(k),indexAtStart:indexAtEnd);
                    Nansum_cloud(k)=sum(sum(isnan(cloud(k).ZNan2)));    %Amount of NaN in supersaturated layers 
                    Nansumnot_cloud(k)=sum(sum(~isnan(cloud(k).ZNan2)));%Amount of non-NaN in supersaturated layers 

                    if Nansum_cloud(k)>Nansumnot_cloud(k)               %more NaN than non-NaN
                        cloudZmeanhalf3(k)=NaN;                         %write provisoric =no cloud (that can be rewriteted in the next step)                                               
                    elseif Nansum_cloud(k)<=Nansumnot_cloud(k)          %more non-NaN than NaN
                        helpcloud=Cloudnet_short(xDate).Z(indexAtBottomCloud(k):indexAtTopCloud(k),indexAtStart:indexAtEnd);
                        cloudZ(:)=nanmean(helpcloud,1);
                        cloudZmeanhalf3(k)=nanmean(cloudZ);             %if a cloud is found                                       
                    end 

                else
                while idxTop(k)>indexAtBottomCloud(k)                   %only as long as index at searchbeginning is bigger than the cloudbottom
                    idxBot(k)=idxTop(k)-5;
                    if idxBot(k)<=indexAtBottomCloud(k)                 %if lower border is reached 
                        idxBot(k)=indexAtBottomCloud(k);
                        %disp('last');
                        last=1;
                        idxTop(k);
                    end

                    cloud(k).ZNan2=Cloudnet_short(xDate).Z(idxBot(k):idxTop(k),indexAtStart:indexAtEnd);
                    Nansum_cloud(k)=sum(sum(isnan(cloud(k).ZNan2)));    %Amount of NaN in supersaturated layer 
                    Nansumnot_cloud(k)=sum(sum(~isnan(cloud(k).ZNan2)));%Amount of non-NaN in supersaturated layer 

                    if Nansum_cloud(k)>Nansumnot_cloud(k)               %more Nan than non-NaN
                        cloudZmeanhalf3(k)=NaN;                         %write provisoric no cloud. There is a possibility that this will be changed in the next step. 
                        if last==0                                      %if it is not the last round
                            idxTop(k)=idxTop(k)-1;                      %if there is no cloud, then go to next part and repeat
                        else                                            %if it is the last round
                            idxTop(k)=idxBot(k);
                        end                                             %again from idxBot

                    elseif Nansum_cloud(k)<=Nansumnot_cloud(k)          %more non-Nan than NaN
                        helpcloud=Cloudnet_short(xDate).Z(idxBot(k):idxTop(k),indexAtStart:indexAtEnd);
                        cloudZ(:)=nanmean(helpcloud,1);
                        cloudZmeanhalf3(k)=nanmean(cloudZ); %IMP OUTPUT %if a cloud is found, then end.
                        break                                           %end: go to k=k+1
                    end 

                end 
                end 
                MLC_classification(xDate).cloudbase = Cloudixd(jDate).height_super_bottom;
                MLC_classification(xDate).cloudtop = Cloudixd(jDate).height_super_top;
                MLC_classification(xDate).cloudmean = Cloudixd(jDate).height_super_middle;
                MLC_classification(xDate).abovecloud = Cloudixd(jDate).height_abovecloud;
                MLC_classification(xDate).cloudfree = Cloudixd(jDate).height_clearLayer;
                
                MLC_classification(xDate).lat = Raso(jDate).lat(1);
                MLC_classification(xDate).lon = Raso(jDate).lon(1);
                MLC_classification(xDate).CTT = Cloudixd(jDate).T_super_top-273.15;
                MLC_classification(xDate).CBT = Cloudixd(jDate).T_super_bottom-273.15;
                MLC_classification(xDate).CMT = Cloudixd(jDate).T_super_middle-273.15;
                MLC_classification(xDate).abvecloud_T = Cloudixd(jDate).T_abovecloud-273.15;
                MLC_classification(xDate).cloudfree_T = Cloudixd(jDate).T_clearLayer-273.15;
                
                MLC_classification(xDate).CTP = Cloudixd(jDate).p_super_top;
                MLC_classification(xDate).CBP = Cloudixd(jDate).p_super_bottom;
                MLC_classification(xDate).CMP = Cloudixd(jDate).p_super_middle;
                MLC_classification(xDate).abovecloud_p = Cloudixd(jDate).p_abovecloud;
                MLC_classification(xDate).cloudfree_p = Cloudixd(jDate).p_clearLayer;
                
                MLC_classification(xDate).liquid_super = Cloudixd(jDate).liquid_super;
                MLC_classification(xDate).mixed_super = Cloudixd(jDate).mixed_super;
                
                if sum(MLC_classification(xDate).mixed_super) >= 1
                    MLC_classification(xDate).mixed_layerbase = Cloudixd(jDate).mixed_height_super_bottom;
                    MLC_classification(xDate).mixed_layertop = Cloudixd(jDate).mixed_height_super_top;
                    MLC_classification(xDate).mixed_layermiddle = Cloudixd(jDate).mixed_height_super_middle;

                    MLC_classification(xDate).mixed_CTB = Cloudixd(jDate).mixed_T_super_bottom;
                    MLC_classification(xDate).mixed_CTT = Cloudixd(jDate).mixed_T_super_top;
                    MLC_classification(xDate).mixed_CTM = Cloudixd(jDate).mixed_T_super_middle;

                    MLC_classification(xDate).mixed_CBP = Cloudixd(jDate).mixed_p_super_bottom;
                    MLC_classification(xDate).mixed_CTP = Cloudixd(jDate).mixed_p_super_top;
                    MLC_classification(xDate).mixed_CMP = Cloudixd(jDate).mixed_p_super_middle;

                else
                    MLC_classification(xDate).mixed_layerbase = NaN;
                    MLC_classification(xDate).mixed_layertop = NaN;
                    MLC_classification(xDate).mixed_layermiddle = NaN;

                    MLC_classification(xDate).mixed_CTB = NaN;
                    MLC_classification(xDate).mixed_CTT = NaN;
                    MLC_classification(xDate).mixed_CTM = NaN;

                    MLC_classification(xDate).mixed_CBP = NaN;
                    MLC_classification(xDate).mixed_CTP = NaN;
                    MLC_classification(xDate).mixed_CMP = NaN;
                end
                 if sum(MLC_classification(xDate).liquid_super) >= 1
                    MLC_classification(xDate).liquid_layerbase = Cloudixd(jDate).liquid_height_super_bottom;
                    MLC_classification(xDate).liquid_layertop = Cloudixd(jDate).Liquid_height_super_top;
                    MLC_classification(xDate).liquid_layermiddle = Cloudixd(jDate).liquid_height_super_middle;

                    MLC_classification(xDate).liquid_CTB = Cloudixd(jDate).liquid_T_super_bottom;
                    MLC_classification(xDate).liquid_CTT = Cloudixd(jDate).liquid_T_super_top;
                    MLC_classification(xDate).liquid_CTM = Cloudixd(jDate).liquid_T_super_middle;

                    MLC_classification(xDate).liquid_CBP = Cloudixd(jDate).liquid_p_super_bottom;
                    MLC_classification(xDate).liquid_CTP = Cloudixd(jDate).liquid_p_super_top;
                    MLC_classification(xDate).liquid_CMP = Cloudixd(jDate).liquid_p_super_middle;

                else
                    MLC_classification(xDate).liquid_layerbase = NaN;
                    MLC_classification(xDate).liquid_layertop = NaN;
                    MLC_classification(xDate).liquid_layermiddle = NaN;

                    MLC_classification(xDate).liquid_CTB = NaN;
                    MLC_classification(xDate).liquid_CTT = NaN;
                    MLC_classification(xDate).liquid_CTM = NaN;

                    MLC_classification(xDate).liquid_CBP = NaN;
                    MLC_classification(xDate).liquid_CTP = NaN;
                    MLC_classification(xDate).liquid_CMP = NaN;
                end
            end

        %    cloudZmeanhalf3;
            if exist('cloudZmeanhalf3') == 1
                %%
                %Convert NaN into 0=no cloud, 1=cloud in lowest supersaturated layer

                for k=1:length(cloudZmeanhalf3)%lCloud
                    if isnan(cloudZmeanhalf3(k))
                        cloudZmeanhalf3(k)=0;                     %if NaN, then =0 =no cloud
                    elseif ~isnan(cloudZmeanhalf3(k))
                         cloudZmeanhalf3(k)=1;                    %if non-NaN, then =1 =cloud
                    end
                end

                MLC_classification(xDate).Zbelow=cloudZmeanhalf3;
                %MLC_classification(xDate).Zbelow=MLC_classification(xDate).Zbelow(1:end-1); %top cloud is not needed
                %MLC_classification(xDate).Zabove=MLC_classification(xDate).Zabove(2:end);   %cloud below is not needed
            else
                MLC_classification(xDate).Zbelow=NaN;
                MLC_classification(xDate).Zbelow=NaN; %top cloud is not needed
                MLC_classification(xDate).Zabove=NaN;
            end

        %end

    end
end
%%
if numcloud(xDate) == 1
    if length(Cloudixd(jDate).height_super_top) >= 1
    x = Cloudnet_short(xDate).height;
    valueToMatch = Cloudixd(jDate).height_super_bottom(1);
    [~, indexAtBottomNoCloud] = min(abs(x - valueToMatch));   %find the closest value

    x = Cloudnet_short(xDate).height;
    valueToMatch = Cloudixd(jDate).height_super_top(1);
    [~, indexAtEndNoCloud] = min(abs(x - valueToMatch));      %find the closest value
       
            cloud.ZNan(:,:)=Cloudnet_short(xDate).Z(indexAtBottomNoCloud:indexAtEndNoCloud,:);
            Nansum_cloud=sum(sum(isnan(cloud.ZNan)));         %Amount of NaN in supersaturated layers 
            Nansumnot_cloud=sum(sum(~isnan(cloud.ZNan)));     %Amount of non-NaN in supersaturated layers

    if Nansum_cloud > Nansumnot_cloud
        MLC_classification(xDate).Cloud=1;
    else
        MLC_classification(xDate).Cloud=0;

    end
                MLC_classification(xDate).cloudbase = Cloudixd(jDate).height_super_bottom;
                MLC_classification(xDate).cloudtop = Cloudixd(jDate).height_super_top;
                MLC_classification(xDate).cloudmean = Cloudixd(jDate).height_super_middle;
                MLC_classification(xDate).abovecloud = Cloudixd(jDate).height_abovecloud;
                MLC_classification(xDate).cloudfree = NaN;
                
                MLC_classification(xDate).lat = Raso(jDate).lat(1);
                MLC_classification(xDate).lon = Raso(jDate).lon(1);
                MLC_classification(xDate).CTT = Cloudixd(jDate).T_super_top-273.15;
                MLC_classification(xDate).CBT = Cloudixd(jDate).T_super_bottom-273.15;
                MLC_classification(xDate).CMT = Cloudixd(jDate).T_super_middle-273.15;
                MLC_classification(xDate).abvecloud_T = Cloudixd(jDate).T_abovecloud-273.15;
                MLC_classification(xDate).cloudfree_T = NaN;
                
                MLC_classification(xDate).CTP = Cloudixd(jDate).p_super_top;
                MLC_classification(xDate).CBP = Cloudixd(jDate).p_super_bottom;
                MLC_classification(xDate).CMP = Cloudixd(jDate).p_super_middle;
                MLC_classification(xDate).abovecloud_p = Cloudixd(jDate).p_abovecloud;
                MLC_classification(xDate).cloudfree_p = NaN;
                
                MLC_classification(xDate).liquid_super = Cloudixd(jDate).liquid_super;
                MLC_classification(xDate).mixed_super = Cloudixd(jDate).mixed_super;
                
                if sum(MLC_classification(xDate).mixed_super) >= 1
                    MLC_classification(xDate).mixed_layerbase = Cloudixd(jDate).mixed_height_super_bottom;
                    MLC_classification(xDate).mixed_layertop = Cloudixd(jDate).mixed_height_super_top;
                    MLC_classification(xDate).mixed_layermiddle = Cloudixd(jDate).mixed_height_super_middle;

                    MLC_classification(xDate).mixed_CTB = Cloudixd(jDate).mixed_T_super_bottom;
                    MLC_classification(xDate).mixed_CTT = Cloudixd(jDate).mixed_T_super_top;
                    MLC_classification(xDate).mixed_CTM = Cloudixd(jDate).mixed_T_super_middle;

                    MLC_classification(xDate).mixed_CBP = Cloudixd(jDate).mixed_p_super_bottom;
                    MLC_classification(xDate).mixed_CTP = Cloudixd(jDate).mixed_p_super_top;
                    MLC_classification(xDate).mixed_CMP = Cloudixd(jDate).mixed_p_super_middle;

                else
                    MLC_classification(xDate).mixed_layerbase = NaN;
                    MLC_classification(xDate).mixed_layertop = NaN;
                    MLC_classification(xDate).mixed_layermiddle = NaN;

                    MLC_classification(xDate).mixed_CTB = NaN;
                    MLC_classification(xDate).mixed_CTT = NaN;
                    MLC_classification(xDate).mixed_CTM = NaN;

                    MLC_classification(xDate).mixed_CBP = NaN;
                    MLC_classification(xDate).mixed_CTP = NaN;
                    MLC_classification(xDate).mixed_CMP = NaN;
                end
                if sum(MLC_classification(xDate).liquid_super) >= 1
                    MLC_classification(xDate).liquid_layerbase = Cloudixd(jDate).liquid_height_super_bottom;
                    MLC_classification(xDate).liquid_layertop = Cloudixd(jDate).Liquid_height_super_top;
                    MLC_classification(xDate).liquid_layermiddle = Cloudixd(jDate).liquid_height_super_middle;

                    MLC_classification(xDate).liquid_CTB = Cloudixd(jDate).liquid_T_super_bottom;
                    MLC_classification(xDate).liquid_CTT = Cloudixd(jDate).liquid_T_super_top;
                    MLC_classification(xDate).liquid_CTM = Cloudixd(jDate).liquid_T_super_middle;

                    MLC_classification(xDate).liquid_CBP = Cloudixd(jDate).liquid_p_super_bottom;
                    MLC_classification(xDate).liquid_CTP = Cloudixd(jDate).liquid_p_super_top;
                    MLC_classification(xDate).liquid_CMP = Cloudixd(jDate).liquid_p_super_middle;

                else
                    MLC_classification(xDate).liquid_layerbase = NaN;
                    MLC_classification(xDate).liquid_layertop = NaN;
                    MLC_classification(xDate).liquid_layermiddle = NaN;

                    MLC_classification(xDate).liquid_CTB = NaN;
                    MLC_classification(xDate).liquid_CTT = NaN;
                    MLC_classification(xDate).liquid_CTM = NaN;

                    MLC_classification(xDate).liquid_CBP = NaN;
                    MLC_classification(xDate).liquid_CTP = NaN;
                    MLC_classification(xDate).liquid_CMP = NaN;
                end
    else 
        numcloud(xDate) = 0;
    end
end

%%
end
end
end
%%
clear cloud cloudZ cloudZmean40 cloudZmean402 cloudZmeanhalf cloudZmeanhalf2 h h1 height helpcloud hh hline ...
    indexAtMin minDifferenceValue minu mu Nafter_new Nansum ...
    Nansum_cloud Nansumnot Nansumnot_cloud Nbefore_new nocloud nocloudZ nocloudZmean40 nocloudZmean402 nocloudZmeanhalf ...
    nocloudZmeanhalf2 pos1 reso valueToMatch ZnN x sek mm dd yy yy1 mm1 dd1 ab ac c ...
    Nafter_vec Nbefore_vec Y22 kminus k indexAtBottomCloud100 ...
    idxTop idxBot last indexend_noCloud ans Anz_0 nocloudZ_Zeit cloudZ_Zeit cloudZmeanhalf3 

%%