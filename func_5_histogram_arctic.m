function[XL,list_nonNan]=func_5_histogram_arctic(MLC_classification, index, station, Njan, Nfeb, Nmar, Napr, Nmay, Njun, Njul, Naug, Nseb, Noct, Nnov, Ndec, modeic)

E = Evaluation_4_RC_calc_clean_v2(MLC_classification,index) 
lMLC = numel(MLC_classification);

idx_0cloud     = E.idx_0cloud;
idx_1cloud     = E.idx_1cloud;
idx_2cloud     = E.idx_2cloud;
idx_nonNan     = E.idx_nonNan;
idx_Nan        = E.idx_Nan;
idx_cloudcover = E.idx_cloudcover;
idx_onlyseed   = E.idx_onlyseed;
idx_nonseed    = E.idx_nonseed;
idx_both       = E.idx_both;
idx_noML       = E.idx_noML;

idx_noML0      = E.idx_noML0;
idx_noML1      = E.idx_noML1;

idx_1warmcloud =E.idx_1warmcloud;
idx_2warmcloud = E.idx_2warmcloud;

for i = 1 : length(index)
    if length(MLC_classification(i).lat) ==0
        MLC_classification(i).lat = NaN;
    end
lat(i) = MLC_classification(i).lat;
end

lat1_ind = find(lat >= 88);
lat2_ind = find(lat < 88);
lat3_ind = find(lat(lat2_ind) >= 86);
lat2_ind = lat2_ind(lat3_ind); clear lat3_ind

lat3_ind = find(lat < 86);
lat4_ind = find(lat(lat3_ind) >= 84);
lat3_ind = lat3_ind(lat4_ind); clear lat4_ind

lat4_ind = find(lat < 84);
lat5_ind = find(lat(lat4_ind) >= 82);
lat4_ind = lat4_ind(lat5_ind); clear lat5_ind

lat5_ind = find(lat <= 82);
lat6_ind = find(lat(lat5_ind) >= 80);
lat5_ind = lat5_ind(lat6_ind); clear lat6_ind

lat6_ind = find(lat <= 80);
lat7_ind = find(isnan(lat) ==1);
%%
%find month
switch true
    case (strcmpi(station,'AO2018')==1)
    for k=1:lMLC
        [yy(k) month(k) dd(k)]=datevec(MLC_classification(k).date);

       if modeic == 2
            if k<88
                periode(k)=1;
            elseif k>=88
                periode(k)=2;
            end
        elseif modeic ==1
             if k<53
                periode(k)=1;
            elseif k>=53
                periode(k)=2;
            end
        end
    end
    case (strcmpi(station,'MOSAIC')==1)
    for k=1:lMLC
             [yy(k) month(k) dd(k)]=datevec(MLC_classification(k).date);
        if modeic == 1
               if k<=219 %autumn, 
                    periode(k)=1;
                  elseif k>=219 && k<793 %winter , 25.11
                      periode(k)=2;
                  elseif k>=793 && k<938 %spring, 20.4
                      periode(k)=3;
                  elseif k>=938 && k<1305 %summer, 28.5
                      periode(k)=4;
                  elseif k>=1305
                      periode(k)=5; %autumn, 5.9
               end
        elseif modeic == 2
                if k < Noct
                        periode(k)=1;
                    elseif k>=Noct && k<Noct + Nnov
                        periode(k)=2;
                    elseif k>=Noct + Nnov && k<Noct + Nnov + Ndec
                        periode(k)=3;
                    elseif k>=Noct + Nnov + Ndec && k<Noct + Nnov + Ndec + Njan
                        periode(k)=4;
                    elseif k>=Noct + Nnov + Ndec + Njan && k<Noct + Nnov + Ndec + Njan + Nfeb
                        periode(k)=5;
                    elseif k>=Noct + Nnov + Ndec + Njan + Nfeb && k<Noct + Nnov + Ndec + Njan + Nfeb + Nmar
                        periode(k)=6;
                    elseif k>=Noct + Nnov + Ndec + Njan + Nfeb + Nmar && k<Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr
                        periode(k)=7;
                    elseif k>=Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr && k<Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr + Nmay
                        periode(k)=8;
                    elseif k>=Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr+ Nmay && k<Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr + Nmay + Njun
                        periode(k)=9;
                    elseif k>=Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr+ Nmay + Njun && k<Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul
                        periode(k)=10;  
                    elseif k>=Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr+ Nmay + Njun + Njul && k<Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug
                        periode(k)=11;            
                    elseif k>=Noct + Nnov + Ndec + Njan + Nfeb + Nmar + Napr+ Nmay + Njun + Njul + Naug
                        periode(k)=12;
                end
        else      
             for i = 1 : length(lat1_ind)
                 if k==lat1_ind(i);
                    periode(k)=1;
                 end
             end
             clear i
              for i = 1 : length(lat2_ind)
                 if k==lat2_ind(i) 
                    periode(k)=2;
                 end
              end
              clear i
              for i = 1 : length(lat3_ind)
                 if k==lat3_ind(i)
                  periode(k)=3;
                 end
              end
              clear i
              for i = 1 : length(lat4_ind)
                 if k==lat4_ind(i)
                  periode(k)=4;
                 end
              end
              clear i
              for i = 1 : length(lat5_ind)
                 if k==lat5_ind(i)
                  periode(k)=5;
                 end
              end
              clear i
              for i = 1 : length(lat6_ind)
                 if k==lat6_ind(i)
                  periode(k)=6;
                 end 
              end
              clear i
              for i = 1 : length(lat7_ind)
                 if k==lat7_ind(i)
                  periode(k)=7;
                 end 
              end    
              clear i
        end
    end
    case (strcmpi(station,'NYA')==1)
        for k=1:lMLC
                 [yy(k) month(k) dd(k)]=datevec(MLC_classification(k).date);
            if modeic == 2
                if k <= Njan
                        periode(k)=1;
                    elseif k>Njan && k<=Njan + Nfeb
                        periode(k)=2;
                    elseif k>Njan + Nfeb && k<=Njan + Nfeb + Nmar
                        periode(k)=3;
                    elseif k>Njan + Nfeb + Nmar && k<=Njan + Nfeb + Nmar + Napr
                        periode(k)=4;
                    elseif k>Njan + Nfeb + Nmar + Napr && k<=Njan + Nfeb + Nmar + Napr + Nmay
                        periode(k)=5;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun
                        periode(k)=6;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul
                        periode(k)=7;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug
                        periode(k)=8;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb
                        periode(k)=9;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb + Noct
                        periode(k)=10;  
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb + Noct && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb + Noct + Nnov
                        periode(k)=11;            
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb + Noct + Nnov
                        periode(k)=12;
                end
            end
        end
    case (strcmpi(station,'Utq')==1)
        for k=1:lMLC
                 [yy(k) month(k) dd(k)]=datevec(MLC_classification(k).date);
            if modeic == 2
                if k <= Njan
                        periode(k)=1;
                    elseif k>Njan && k<=Njan + Nfeb
                        periode(k)=2;
                    elseif k>Njan + Nfeb && k<=Njan + Nfeb + Nmar
                        periode(k)=3;
                    elseif k>Njan + Nfeb + Nmar && k<=Njan + Nfeb + Nmar + Napr
                        periode(k)=4;
                    elseif k>Njan + Nfeb + Nmar + Napr && k<=Njan + Nfeb + Nmar + Napr + Nmay
                        periode(k)=5;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun
                        periode(k)=6;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul
                        periode(k)=7;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug
                        periode(k)=8;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb
                        periode(k)=9;
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb + Noct
                        periode(k)=10;  
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb + Noct && k<=Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb + Noct + Nnov
                        periode(k)=11;            
                    elseif k>Njan + Nfeb + Nmar + Napr + Nmay + Njun + Njul + Naug + Nseb + Noct + Nnov
                        periode(k)=12;
                end
            end
        end
        case (strcmpi(station,'ACSE')==1)
        for k=1:lMLC
        [yy(k) month(k) dd(k)]=datevec(MLC_classification(k).date);
            if modeic == 2
                if k < Njul
                    periode(k)=1;
                elseif k>=Njul && k<Njul + Naug
                    periode(k)=2;
                elseif k>=Njul + Naug && k<=Njul + Naug + Nseb
                    periode(k)=3;
                end
            else modeic == 1;
                if k < 189
                    periode(k)=1;
                elseif k>= 189
                    periode(k)=2;
            end
        end
        end
end
%%
%monthly distribution for histogram
switch true
    case (strcmpi(station,'AO2018')==1)
            if modeic == 1
                maxlist = 2;
            elseif modeic == 2
                maxlist = 2;
            end
    case (strcmpi(station,'MOSAIC')==1)
        if modeic == 1
            maxlist = 5;
        elseif modeic == 2
            maxlist = 12;
        else 
            maxlist = 7;
        end
    case (strcmpi(station,'NYA')==1)
        if modeic == 2
            maxlist = 12;
        end
    case (strcmpi(station,'Utq')==1)
        if modeic == 2
            maxlist = 12;
        end
    case (strcmpi(station,'ACSE')==1)
        if modeic == 1
                maxlist = 2;
        elseif modeic == 2
                maxlist = 3;
        end     
end

%% 0cloud:
mon_0cloud=periode(idx_0cloud);           
[a_0cloud,b_0cloud]=hist(mon_0cloud,unique(mon_0cloud));
if(max(b_0cloud) > maxlist)
    b_0cloud = 1:maxlist;
end
list_0cloud(1:maxlist)=0;
for k=1:length(b_0cloud)
    list_0cloud(b_0cloud(k))=a_0cloud(k);   
end
list_0cloud(isnan(list_0cloud))=0;

%% 1cloud:
mon_1cloud=periode(idx_1cloud);           
[a_1cloud,b_1cloud]=hist(mon_1cloud,unique(mon_1cloud));
list_1cloud(1:maxlist)=0;
for k=1:length(b_1cloud)
    list_1cloud(b_1cloud(k))=a_1cloud(k);   
end
list_1cloud(isnan(list_1cloud))=0;

%% no multilayer cloud, no single layer cloud:
mon_noML0=periode(idx_noML0);
a=periode(idx_noML0);
[a_noML0,b_noML0]=hist(mon_noML0,unique(mon_noML0));
list_noML0(1:maxlist)=0;
for k=1:length(b_noML0)
    list_noML0(b_noML0(k))=a_noML0(k);   
end
list_noML0(isnan(list_noML0))=0;

%no multilayer cloud, but single layer cloud:
mon_noML1=periode(idx_noML1);          
[a_noML1,b_noML1]=hist(mon_noML1,unique(mon_noML1));
list_noML1(1:maxlist)=0;
for k=1:length(b_noML1)
    list_noML1(b_noML1(k))=a_noML1(k); 
end
list_noML1(isnan(list_noML1))=0;

%% both:
mon_both=periode(idx_both);          
[a_both,b_both]=hist(mon_both,unique(mon_both));
list_both(1:maxlist)=0;
if b_both(1) == 0
    b_both = 1:maxlist;
end
for k=1:length(b_both)
    list_both(b_both(k))=a_both(k);   
end
list_both(isnan(list_both))=0;
% if length(list_both)>=13                %strange thing happens at 100MHP_WC
%     list_both=list_both(1:12);
% end

%% nonseed:

mon_nonseed=periode(idx_nonseed);           
[a_nonseed,b_nonseed]=hist(mon_nonseed,unique(mon_nonseed));
list_nonseed(1:maxlist)=0;

for k=1:length(b_nonseed)
    list_nonseed(b_nonseed(k))=a_nonseed(k);  
end
list_nonseed(isnan(list_nonseed))=0;

%only seeding:
mon_onlyseed=periode(idx_onlyseed);          
[a_onlyseed,b_onlyseed]=hist(mon_onlyseed,unique(mon_onlyseed));
list_onlyseed(1:maxlist)=0;
for k=1:length(b_onlyseed)
    list_onlyseed(b_onlyseed(k))=a_onlyseed(k);   
end
list_onlyseed(isnan(list_onlyseed))=0;

%Total amount:
periode_all=periode(index);          
[a_all,b_all]=hist(periode_all,unique(periode_all));
if b_all(1) == 0
    b_all = 1:maxlist;
end
list_all(1:maxlist)=0;
for k=1:length(b_all)
    list_all(b_all(k))=a_all(k);
end

%Cloudcover:
periode_cloudcover=periode(idx_cloudcover);          
[a_cloudcover,b_cloudcover]=hist(periode_cloudcover,unique(periode_cloudcover));
list_cloudcover(1:maxlist)=0;
if b_cloudcover(1) == 0
    b_cloudcover = 1:maxlist;
end
for k=1:length(b_cloudcover)
    list_cloudcover(b_cloudcover(k))=a_cloudcover(k);
end
%%
%warm cloud:
if length(idx_1warmcloud) >= 1
    mon_1warm=periode(idx_1warmcloud);               %List of month of occurrence
    mon_1warm(mon_1warm ==0) = [];
    [a_1warm,b_1warm]=hist(mon_1warm,unique(mon_1warm));
    tf = isempty(b_1warm);
    if tf == 0
        if b_1warm(1) ~= 1
        b_1warm = b_1warm;
        end  
    end
    list_1warm(1:maxlist)=0;
    for k=1:length(a_1warm)
        list_1warm(b_1warm(k))=a_1warm(k); %List of amount per month
    end
else
    list_1warm = 0;
end
%warm cloud, MLC:
if length(idx_2warmcloud) >=1
    mon_2warm=periode(idx_2warmcloud);               %List of month of occurrence
    mon_2warm(mon_2warm ==0) = [];
    [a_2warm,b_2warm]=hist(mon_2warm,unique(mon_2warm));
    tf = isempty(b_2warm);
    if tf == 0
        if b_2warm(1) ~= 1
        b_2warm = b_2warm;
        end  
    end
    list_2warm(1:maxlist)=0;
    for k=1:length(a_2warm)
        list_2warm(b_2warm(k))=a_2warm(k); %List of amount per month
    end
else
    list_2warm = 0;
end
%% days of measurements:
periode_nonNan=periode(idx_nonNan);           

periode_nonNan=periode(idx_nonNan);                    %List of month of occurrence
periode_nonNan(periode_nonNan ==0) = [];
[a_nonNan,b_nonNan]=hist(periode_nonNan,unique(periode_nonNan));
list_nonNan(1:maxlist)=NaN;
for k=1:length(b_nonNan)
    list_nonNan(b_nonNan(k))=a_nonNan(k);
end

%%
%Histogram
a = list_onlyseed + list_nonseed + list_both + list_1cloud+ list_0cloud+list_noML1+list_noML0+list_1warm+list_2warm;
nonseed_nonNan=list_nonseed./a; 
both_nonNan=list_both./a; 
onlyseed_nonNan=list_onlyseed./a; 
noML1_nonNan=list_noML1./a; 
cloud1_nonNan=list_1cloud./a; 
noML0_nonNan=list_noML0./a;
cloud0_nonNan=list_0cloud./a;
warm1_nonNan=list_1warm./a; 
warm2_nonNan=list_2warm./a; 

XL(:,1)=nonseed_nonNan;
XL(:,2)=both_nonNan;
XL(:,3)=onlyseed_nonNan;
XL(:,4)=noML1_nonNan;
XL(:,5)=cloud1_nonNan;
XL(:,6)=noML0_nonNan;
XL(:,7)=cloud0_nonNan;
XL(:,8)=warm1_nonNan;
XL(:,9)=warm2_nonNan;

end
