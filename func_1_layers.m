
function[Raso10km, numcloud_i, Cloudixd]=func_1_layers(Raso, hmax,rhthres,minsub, minsuperl, minsuperc,iDate)

%this program searches for layers that are supersaturated (numcloud_i)
    Cloudixd(iDate).index_super_bottom = [];
    Cloudixd(iDate).index_super_top = [];
    Cloudixd(iDate).height_super_bottom = [];
    Cloudixd(iDate).height_super_top = [];
    Cloudixd(iDate).index_sub_bottom = [];
    Cloudixd(iDate).index_sub_top = [];
    Cloudixd(iDate).height_sub_bottom = [];
    Cloudixd(iDate).height_sub_top = [];
    numcloud_1 = NaN;
%for limiting height where we look for multi-layer clouds:
%this program searches for layers that are supersaturated (numcloud_i)
%%
%for limiting height where we look for multi-layer clouds:

x = Raso(iDate).alt;
valueToMatch = hmax*1e3;
% Find the closest value.
[~, indexAtMin] = min(abs(x - valueToMatch));

%Change Raso into Raso10km
RHl10km=Raso(iDate).RHl(1:indexAtMin);
RHi10km=Raso(iDate).RHi(1:indexAtMin);
Alt10km=Raso(iDate).alt(1:indexAtMin);

%idxalt = find(Alt10km < 60);  % to test how the statistics change
%depending on the first radar height
%RHi10km(idxalt) = NaN;
%RHl10km(idxalt) = NaN;

RHm10km=max(RHl10km,RHi10km);
lRHm10km=length(RHm10km);
index=(1:1:lRHm10km);

plot(RHi10km,Alt10km)

 Raso10km(iDate).number=Raso(iDate).number;
 Raso10km(iDate).date=Raso(iDate).date;
 Raso10km(iDate).N=Raso(iDate).N(1:indexAtMin);
 
Raso10km(iDate).index=index';
Raso10km(iDate).alt=Raso(iDate).alt(1:indexAtMin);
Raso10km(iDate).tempK=Raso(iDate).tempK(1:indexAtMin);
Raso10km(iDate).press=Raso(iDate).press(1:indexAtMin);
Raso10km(iDate).RHl10km=RHl10km;
Raso10km(iDate).RHi10km=RHi10km;
Raso10km(iDate).RHm10km=RHm10km;
%%
if nansum(Raso10km(iDate).RHl10km) > 50
%%
%Creating a variable RHmclass:
%RHm < 100%: RHmclass=1 (subsaturated)
%RHm > 100%: RHmclass=2 (supersaturated)
%RHm = Nan:  RHmclass=Nan

RHmclass(1:lRHm10km)=0;

for ii=1:lRHm10km
    mtot=RHm10km(ii);
    if mtot>=rhthres
        RHmclass(ii)=2;          
    elseif mtot<rhthres
        RHmclass(ii)=1;
    elseif isnan(mtot) 
        RHmclass(ii)=nan;  
    end
end
%%
%cleaning RHmclass: deleting single cloudvalues at top and bottom

A = RHmclass;   
for jj=1:lRHm10km
    if jj==1 && A(jj)==2 && A(jj+1)==1              %if there is a single cloud value at the lowest level
        A(jj)=1;
    elseif jj==length(A) && A(jj)==2 && A(jj-1)==1  %if there is a single cloud value at the uppermost level
        A(jj)=1;  
    end
end
RHmclass_cleaned=A;                                 %cleaned RHmclass
uebergang(1)=0;
uebergang(2:lRHm10km)=diff(RHmclass_cleaned);

%%
%Finding ALL subsaturated layers

index_bottom=find(uebergang ==-1);                        %Index at begin of subsaturated layer
index_top=(find(uebergang ==1))-1;                         %Index at begin of supersaturated layer

    if length(index_top) <= length(index_bottom)
        b = find(index_top == index_bottom(1:length(index_top)));
            index_bottom(b) = [];
            index_top(b) = [];
        else
        b = find(index_bottom == index_top(1:length(index_bottom)));
            index_bottom(b) = [];
            index_top(b) = [];
    end

lindex=length(index_top);                                 %Amount of subsaturated layers including bottom layer which is not needed

%%
%Finding ONLY subsaturated layers in between supersaturated layers
if lindex == 1
    ix_sub_bottom=index_bottom;
    ix_sub_top= index_top;
    liquid_sub=0;
    if ix_sub_bottom >= 1
            if Raso10km(iDate).RHi10km(ix_sub_bottom) < rhthres      %check if the index below the sub_bottom is ice-supersaturated
                idx_liquid=ix_sub_bottom;                     %if not, then it has to be liquid-supersaturated
                liquid_sub=1;
                %lindex = lindex - liquid_sub;
    end
    end
end
%%

if lindex>=2                                    %i=5: only if min 1 subsaturated layer 
    
    if index_bottom(1) > index_top(1)
        index_bottom = [1,index_bottom];
    end
   
    ix_sub = 1 : length(index_top(1:end)); %2:end before, find(Heightdiff | Heightdiff==0);      %finding amount of subsaturated layers (für 322 need |==0)
    if length(index_bottom)>length(index_top)
        ix_sub_bottom=index_bottom;   %index_bottom(ix_sub)   %index at bottom of subsaturated layer
        index_top = [index_top,length(Raso10km(iDate).alt)];
        ix_sub_top= index_top;             %index at top of subsaturated layer (does not contain the lowest top which is not needed) 
        else 
        ix_sub_bottom=index_bottom(ix_sub);   %index_bottom(ix_sub)   %index at bottom of subsaturated layer
        ix_sub_top=index_top(ix_sub); % +1 before
    end

    %If the subsaturated layers are due to liquid and not ice: liquid_case=1
    
    liquid_sub=0;
    if ix_sub_bottom(1) > 1
        for k=1:length(ix_sub)
            if Raso10km(iDate).RHi10km(ix_sub_bottom(k)-1) < rhthres      %check if the index below the sub_bottom is ice-supersaturated
                idx_liquid(k)=ix_sub_bottom(k);                     %if not, then it has to be liquid-supersaturated
                liquid_sub=1;
            end
        end
    end


    if liquid_sub==1                                           %if there are liquid cases
          lliquid=length(idx_liquid);                             %count how many liquid cases
          ix_sub_bottom(1:lliquid-1)=NaN;                         %delete that layer
          ix_sub_bottom(isnan(ix_sub_bottom)) = [];
          ix_sub_top(1:lliquid-1)=NaN;
          ix_sub_top(isnan(ix_sub_top)) = [];
    
         lix_sub=lindex-lliquid;                                 %amount ice-subsaturated layers 

    elseif liquid_sub==0                                        %if there is no liquid-supersaturation layer
        lix_sub=length(ix_sub);
    end

  
    Cloudixd(iDate).index_sub_top=ix_sub_top;
    Cloudixd(iDate).height_sub_top=Raso10km(iDate).alt(ix_sub_top);
     
    Cloudixd(iDate).index_sub_bottom=ix_sub_bottom;
    Cloudixd(iDate).height_sub_bottom=Raso10km(iDate).alt(ix_sub_bottom);

elseif lindex==1                                                %if there is only 1 subsaturated layer
    index_super_bottom = index_top +1;
    index_super_top = index_bottom -1;
end

%%
%finding supersaturated layers
if lindex > 1
    index_super_bottom=index_top(1:end-1)+1;%find(uebergang ==1);                      %Index at begin of supersaturated layer
    index_super_top=index_bottom(2:end) -1; %find(uebergang ==-1)-1;                      %Index at top of supersaturated layer
end
%%
if lindex > 0
    %if cloud reaches higher than hmax:
    if length(index_super_top)< length(index_super_bottom)
    
        disp('cloud exceeds hmax');
        x = Raso10km(iDate).alt;
        valueToMatch = hmax*1e3;
        [~, index_super_top(end+1)] = min(abs(x - valueToMatch));    %find the closest value
    
    end
    lindex_super=length(index_super_top);                        %Amount of supersaturation tops

    %If supersaturated layer is defined by RHl and not RHi.
    liquid_super=0;
    Cloudixd(iDate).liquid_super = 0;
    for k=1:lindex_super                                        %go through all supersaturation layers
        if Raso10km(iDate).RHi10km(index_super_top(k)) < rhthres      %check if supersaturation is due to liquid
            idx_liquid_super(k)=index_super_top(k);
            liquid_super=1;
            if liquid_super==1                           %remove layers
                lliqsuper=idx_liquid_super(k);
    
                Cloudixd(iDate).liquid_index_super_top(k)=lliqsuper;
                Cloudixd(iDate).Liquid_height_super_top(k)=Raso10km(iDate).alt(lliqsuper);
                Cloudixd(iDate).liquid_T_super_top(k)=Raso10km(iDate).tempK(lliqsuper);
                Cloudixd(iDate).liquid_p_super_top(k)=Raso10km(iDate).press(lliqsuper)/100;
                if k <= numel(index_super_bottom) && ~isempty(index_super_bottom(k))
                    % Hier hast Du einen gültigen Index
                    Cloudixd(iDate).liquid_index_super_bottom(k) = index_super_bottom(k);
                    Cloudixd(iDate).liquid_height_super_bottom(k) = Raso10km(iDate).alt(index_super_bottom(k));
                    Cloudixd(iDate).liquid_T_super_bottom(k) = Raso10km(iDate).tempK(index_super_bottom(k));
                    Cloudixd(iDate).liquid_p_super_bottom(k) = Raso10km(iDate).press(index_super_bottom(k))/100;
                else
                    % Fallback, falls index_super_bottom(k) nicht existiert
                    Cloudixd(iDate).liquid_index_super_bottom(k) = 1;
                    Cloudixd(iDate).liquid_height_super_bottom(k) = Raso10km(iDate).alt(1);
                    Cloudixd(iDate).liquid_T_super_bottom(k) = Raso10km(iDate).tempK(1);
                    Cloudixd(iDate).liquid_p_super_bottom(k) = Raso10km(iDate).press(1)/100;
                end
                                
                Cloudixd(iDate).liquid_index_super_middle(k)=round(Cloudixd(iDate).liquid_index_super_top(k)...
                -(Cloudixd(iDate).liquid_index_super_top(k) - Cloudixd(iDate).liquid_index_super_bottom(k))/2);
    
                Cloudixd(iDate).liquid_height_super_middle(k)=Raso10km(iDate).alt(Cloudixd(iDate).liquid_index_super_middle(k));
                Cloudixd(iDate).liquid_T_super_middle(k)=Raso10km(iDate).tempK(Cloudixd(iDate).liquid_index_super_middle(k));
                Cloudixd(iDate).liquid_p_super_middle(k)=Raso10km(iDate).press(Cloudixd(iDate).liquid_index_super_middle(k))/100;
                Cloudixd(iDate).liquid_super(k) = 1;
                
            end
        else
            idx_liquid_super(k) = 0;
        end
    end

    if liquid_super==1                           %remove layers
        ai = find(idx_liquid_super > 1);
        lliqsuper=length(idx_liquid_super);
        
        index_super_top(ai)=NaN;
        index_super_top(isnan(index_super_top)) = [];
        index_super_bottom(ai)=NaN;
        index_super_bottom(isnan(index_super_bottom)) = [];
        numcloud_i=lindex_super-lliqsuper+1; 
        
    elseif liquid_super==0                                      %if there are no liquid cases
        numcloud_i=lindex_super;
    end
    %If supersaturated layer is defined by RHl and not RHi.
    mixed_super=0;
    Cloudixd(iDate).mixed_super = mixed_super;
    if isempty(index_super_bottom) == 1
        if isempty(index_super_top) == 0
            index_super_bottom = 2;
        end
    end
    if isempty(index_super_bottom) == 0
        if isempty(index_super_top) == 0
            if index_super_bottom < index_super_top
                for k=1:length(index_super_bottom)                                        %go through all supersaturation layers
                    Cloudixd(iDate).mixed_super(k) = 0;
                    thickness = Raso10km(iDate).RHl10km(index_super_bottom(k):index_super_top(k));
                    thicknessAlt = Raso10km(iDate).alt(index_super_bottom(k):index_super_top(k));
                    thicknessCTT = Raso10km(iDate).tempK(index_super_bottom(k):index_super_top(k));
                    thicknessCP = Raso10km(iDate).press(index_super_bottom(k):index_super_top(k));
                    
                    idx_mixed_super = find(thickness >= rhthres);      %check if supersaturation is due to liquid
                        if length(idx_mixed_super)>=1
                        disp('mixed supersaturation case')
                        Cloudixd(iDate).mixed_height_super_top(k)=thicknessAlt(idx_mixed_super(end));
                        Cloudixd(iDate).mixed_height_super_bottom(k)=thicknessAlt(idx_mixed_super(1));
                        Cloudixd(iDate).mixed_height_super_middle(k)=thicknessAlt(round(mean(idx_mixed_super)));
                        
                        Cloudixd(iDate).mixed_T_super_top(k)=thicknessCTT(idx_mixed_super(end));
                        Cloudixd(iDate).mixed_T_super_bottom(k)=thicknessCTT(idx_mixed_super(1));
                        Cloudixd(iDate).mixed_T_super_middle(k)=thicknessCTT(round(mean(idx_mixed_super)));
                        
                        Cloudixd(iDate).mixed_p_super_top(k)=thicknessCP(idx_mixed_super(end))/100;
                        Cloudixd(iDate).mixed_p_super_bottom(k)=thicknessCP(idx_mixed_super(1))/100;
                        Cloudixd(iDate).mixed_p_super_middle(k)=thicknessCP(round(mean(idx_mixed_super)))/100;
                        end                              
                end
            end
            
        end
    end
    
    if isempty(index_super_bottom) == 0
     if index_super_bottom(1) > index_super_top(1)
        index_super_top = index_super_top(2:end);
     end
    end
        
    %
    Cloudixd(iDate).index_super_top=index_super_top;
    Cloudixd(iDate).height_super_top=Raso10km(iDate).alt(index_super_top);
    Cloudixd(iDate).index_super_bottom=index_super_bottom;
    Cloudixd(iDate).height_super_bottom=Raso10km(iDate).alt(index_super_bottom);
    
    %Check if supersaturation layer is too thin (case 16.7.):
    thin=0;
    
    try
    for k=1:length(index_super_bottom)                     %k=1: does not work  %if cloudlayer is too thin
        layer_dist(k) = Raso10km(iDate).alt(index_super_top(k))-Raso10km(iDate).alt(index_super_bottom(k));
    end
    a = find(layer_dist <= 20);
    Cloudixd(iDate).index_super_top(a) = [];
    Cloudixd(iDate).index_super_bottom(a) = [];
    Cloudixd(iDate).height_super_top(a) = [];
    Cloudixd(iDate).height_super_bottom(a) = [];
    Cloudixd(iDate).index_sub_top(a) = [];
    Cloudixd(iDate).index_sub_bottom(a+1) = [];
    Cloudixd(iDate).height_sub_top(a) = [];
    Cloudixd(iDate).height_sub_bottom(a+1) = [];
    
  
        
    for k=1:length(Cloudixd(iDate).index_super_bottom)    
        cloud_dist(k)=Raso10km(iDate).alt(Cloudixd(iDate).index_super_top(k))-Raso10km(iDate).alt(Cloudixd(iDate).index_super_bottom(k));
        minsuper = minsuperl;
        if Raso10km(iDate).alt(index_super_bottom(k)) > 5000
            minsuper = minsuperc;             %Minimum thickness of supersaturated layer [m]. Std:100;
        else 
            minsuper = minsuperl;
        end
        if cloud_dist(k)<minsuper
           Cloudixd(iDate).index_super_bottom(k)=NaN;
           Cloudixd(iDate).index_super_top(k)=NaN;
           Cloudixd(iDate).height_super_bottom(k)=NaN;
           Cloudixd(iDate).height_super_top(k)=NaN;
           Cloudixd(iDate).index_sub_bottom(k+1)=NaN;
           Cloudixd(iDate).height_sub_bottom(k+1)=NaN;
           Cloudixd(iDate).index_sub_top(k)=NaN;       
           Cloudixd(iDate).height_sub_top(k)=NaN;
           numcloud_i=numcloud_i-1;
           thin=1;
        end 
    end
    %
           if thin==1
            Cloudixd(iDate).index_super_bottom(isnan(Cloudixd(iDate).index_super_bottom)) = [];
            Cloudixd(iDate).index_super_top(isnan(Cloudixd(iDate).index_super_top)) = [];
            Cloudixd(iDate).height_super_bottom(isnan(Cloudixd(iDate).height_super_bottom)) = [];
            Cloudixd(iDate).height_super_top(isnan(Cloudixd(iDate).height_super_top)) = [];
            Cloudixd(iDate).index_sub_bottom(isnan(Cloudixd(iDate).index_sub_bottom)) = [];
            Cloudixd(iDate).height_sub_bottom(isnan(Cloudixd(iDate).height_sub_bottom)) = [];
            Cloudixd(iDate).index_sub_top(isnan(Cloudixd(iDate).index_sub_top)) = [];
            Cloudixd(iDate).height_sub_top(isnan(Cloudixd(iDate).height_sub_top)) = [];
           end
    catch
    end
    %
    try 
    if length(Cloudixd(iDate).index_sub_top) >length(Cloudixd(iDate).index_sub_bottom)    %i=2
        Cloudixd(iDate).index_sub_top(1)=[];
        Cloudixd(iDate).height_sub_top(1)=[];
    end
    catch
    end
    %
    if length(Cloudixd(iDate).index_super_bottom) > length(Cloudixd(iDate).index_super_top)
        Cloudixd(iDate).index_super_top = [Cloudixd(iDate).index_super_top, length(Alt10km)];
        Cloudixd(iDate).height_super_top = [Cloudixd(iDate).height_super_top; 10000];
    end
    % find layers between clouds smaller than 100 m
    if length(Cloudixd(iDate).index_super_bottom) >=2
        clear cloud_dist
        cloud_dist = NaN;
        for k=1:length(Cloudixd(iDate).index_super_bottom) - 1                     
            cloud_dist(k)=Cloudixd(iDate).height_super_bottom(k+1) - Cloudixd(iDate).height_super_top(k);    
        end
        smallCloud = NaN;
        smallCloud = find(cloud_dist < 50);%100minsub);
        if isempty(Cloudixd(iDate).index_super_bottom) == 0
            if length(Cloudixd(iDate).index_super_bottom) == length(Cloudixd(iDate).index_super_top)
                Cloudixd(iDate).index_super_top(smallCloud) = []; %Cloudixd(iDate).index_super_top(smallCloud+1) = [];
                Cloudixd(iDate).height_super_top(smallCloud) = [];
                Cloudixd(iDate).index_sub_top(smallCloud+1) = []; %Cloudixd(iDate).index_super_top(smallCloud+1) = [];
                Cloudixd(iDate).height_sub_top(smallCloud+1) = [];
            end
        end
        %
        Cloudixd(iDate).index_super_bottom(smallCloud+1) = [];
        Cloudixd(iDate).height_super_bottom(smallCloud+1) = [];
        Cloudixd(iDate).index_sub_bottom(smallCloud+1) = [];
        Cloudixd(iDate).height_sub_bottom(smallCloud+1) = [];
    end
    %
    if length(Cloudixd(iDate).index_sub_bottom) >= 1
        Cloudixd(iDate).index_sub_bottom(isnan(Cloudixd(iDate).index_super_bottom) == 1) = [];
        Cloudixd(iDate).height_sub_bottom(isnan(Cloudixd(iDate).height_super_bottom) == 1) = [];
        Cloudixd(iDate).index_sub_top(isnan(Cloudixd(iDate).height_super_top) == 1) = [];
        Cloudixd(iDate).height_sub_top(isnan(Cloudixd(iDate).height_super_top) == 1) = [];
        
    end
    Cloudixd(iDate).index_super_bottom(isnan(Cloudixd(iDate).index_super_bottom) == 1) = [];
    Cloudixd(iDate).index_super_top(isnan(Cloudixd(iDate).index_super_top) == 1) = [];
    Cloudixd(iDate).height_super_bottom(isnan(Cloudixd(iDate).height_super_bottom) == 1) = [];
    Cloudixd(iDate).height_super_top(isnan(Cloudixd(iDate).height_super_top) == 1) = [];
    
    if isempty(Cloudixd(iDate).index_sub_bottom)==0
        Cloudixd(iDate).index_sub_bottom(isnan(Cloudixd(iDate).index_sub_bottom) == 1) = [];
        Cloudixd(iDate).height_sub_bottom(isnan(Cloudixd(iDate).height_sub_bottom) == 1) = [];
        Cloudixd(iDate).index_sub_top(isnan(Cloudixd(iDate).height_sub_top) == 1) = [];
        Cloudixd(iDate).height_sub_top(isnan(Cloudixd(iDate).height_sub_top) == 1) = [];
    end
    %
    Cloudixd(iDate).T_super_top=Raso10km(iDate).tempK(Cloudixd(iDate).index_super_top);
    Cloudixd(iDate).p_super_top=Raso10km(iDate).press(Cloudixd(iDate).index_super_top)/100;
    
    Cloudixd(iDate).T_super_bottom=Raso10km(iDate).tempK(Cloudixd(iDate).index_super_bottom);
    Cloudixd(iDate).p_super_bottom=Raso10km(iDate).press(Cloudixd(iDate).index_super_bottom)/100;
    
    Cloudixd(iDate).index_super_middle=round(Cloudixd(iDate).index_super_top...
        -(Cloudixd(iDate).index_super_top - Cloudixd(iDate).index_super_bottom)/2);
    Cloudixd(iDate).height_super_middle=Raso10km(iDate).alt(Cloudixd(iDate).index_super_middle);
    Cloudixd(iDate).T_super_middle=Raso10km(iDate).tempK(Cloudixd(iDate).index_super_middle);
    Cloudixd(iDate).p_super_middle=Raso10km(iDate).press(Cloudixd(iDate).index_super_middle)/100;
    Cloudixd(iDate).height_abovecloud = Cloudixd(iDate).height_super_top + 100;
    
    for i = 1: length(Cloudixd(iDate).height_abovecloud)
        [c index] = min(abs(Raso10km(iDate).alt-Cloudixd(iDate).height_abovecloud(i)));
        Cloudixd(iDate).p_abovecloud(i) = Raso10km(iDate).press(index)/100;
        Cloudixd(iDate).T_abovecloud(i) = Raso10km(iDate).tempK(index);
    end
    clear i
    if length(Cloudixd(iDate).height_super_top) >=2
        for  i = 1: length(Cloudixd(iDate).height_super_top)-1
        Cloudixd(iDate).index_clearLayer(i) = round(Cloudixd(iDate).index_super_bottom(i+1) -...
            (Cloudixd(iDate).index_super_bottom(i+1) - Cloudixd(iDate).index_super_top(i))/2);
        end
        Cloudixd(iDate).height_clearLayer=Raso10km(iDate).alt(Cloudixd(iDate).index_clearLayer);
        Cloudixd(iDate).T_clearLayer=Raso10km(iDate).tempK(Cloudixd(iDate).index_clearLayer);
        Cloudixd(iDate).p_clearLayer=Raso10km(iDate).press(Cloudixd(iDate).index_clearLayer)/100;
    end
    %    
    Raso10km(iDate).index=index';
    Raso10km(iDate).RHmclass_cleaned=RHmclass_cleaned';
    Raso10km(iDate).uebergang=uebergang';
     numcloud_i = length(Cloudixd(iDate).index_super_bottom); %Peggy, 22.02.2022
end
end
%%         
 if length(Cloudixd(iDate).index_sub_top) == 0
       numcloud_i = 0;
 end
