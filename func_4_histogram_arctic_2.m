
function[XL,list_nonNan]=func_4_histogram_arctic_2(MLC_classification, index, name, station, Njan,...
    Nfeb, Nmar, Napr, Nmay, Njun, Njul, Naug, Nseb, Noct, Nnov, Ndec, ic, idx_1warmcloud, idx_2warmcloud)

Evaluation_1_arctic_calc

for i = 1 : length(index)
    if length(MLC_classification(i).lat) ==0
        MLC_classification(i).lat = NaN;
    end
lat(i) = MLC_classification(i).lat;
end
% lat1_ind = find(lat >= 85);
% lat2_ind = find(lat < 85);
% lat3_ind = find(lat(lat2_ind) > 80);
% lat2_ind = lat2_ind(lat3_ind); clear lat3_ind
% lat3_ind = find(lat <= 80);
% lat4_ind = find(isnan(lat) ==1);
lat1_ind = find(lat >= 88);
lat2_ind = find(lat < 88);
lat3_ind = find(lat(lat2_ind) >= 86);
lat2_ind = lat2_ind(lat3_ind); clear lat3_ind

lat3_ind = find(lat < 86);
lat4_ind = find(lat(lat3_ind) > 84);
lat3_ind = lat3_ind(lat4_ind); clear lat4_ind

lat4_ind = find(lat < 84);
lat5_ind = find(lat(lat4_ind) > 82);
lat4_ind = lat4_ind(lat5_ind); clear lat5_ind

lat5_ind = find(lat < 82);
lat6_ind = find(lat(lat5_ind) > 80);
lat5_ind = lat5_ind(lat6_ind); clear lat6_ind

lat6_ind = find(lat <= 80);
lat7_ind = find(isnan(lat) ==1);
%find day
%%
switch true
    case (strcmpi(station,'AO2018')==1)
    for k=1:lMLC
        [yy(k) month(k) dd(k)]=datevec(MLC_classification(k).date);

%         if k<77
%             periode(k)=1;
%         %          if k<21
%             periode(k)=1;
%         elseif k>=21 && k<60
%             periode(k)=2;
%         elseif k>=60 && k<89
%             periode(k)=3;
%         elseif k>=89 && k<104
%             periode(k)=4;
%         elseif k>=104 && k<125
%             periode(k)=5;
%         elseif k>=125 && k<132
%             periode(k)=6;
%          end
        if ic == 0
            if k<76
                periode(k)=1;
            elseif k>=77
                periode(k)=2;
            end
        elseif ic ==1
             if k<41
                periode(k)=1;
            elseif k>=41
                periode(k)=2;
            end
        end
    end
    case (strcmpi(station,'MOSAIC')==1)
    for k=1:lMLC
        [yy(k) month(k) dd(k)]=datevec(MLC_classification(k).date);
%April 137, August 121, Dec 117, Feb 113,
%Jan 111, Jul 123, Jun 91, March
% 109, May 121, Nov 119, Oct 84, Sep 162,
    if ic == 2
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
    elseif ic == 1
            close all
             if k<=219 %autumn, 
                 periode(k)=1;
             elseif k>=219 && k<788 %winter , 25.11
                 periode(k)=2;
             elseif k>=788 && k<947 %spring, 20.4
                 periode(k)=3;
             elseif k>=947 && k<1327 %summer, 28.5
                 periode(k)=4;
             elseif k>=1327
                 periode(k)=5; %autumn, 5.9
             end
    else
         for i = 1 : length(lat1_ind)
             if k==lat1_ind(i)
                periode(k)=1;
             end
         end
          for i = 1 : length(lat2_ind)
             if k==lat2_ind(i) 
                periode(k)=2;
             end
          end
          for i = 1 : length(lat3_ind)
             if k==lat3_ind(i)
              periode(k)=3;
             end
          end
          for i = 1 : length(lat4_ind)
             if k==lat4_ind(i)
              periode(k)=4;
             end 
          end
          for i = 1 : length(lat5_ind)
             if k==lat5_ind(i)
              periode(k)=5;
             end 
          end
          for i = 1 : length(lat6_ind)
             if k==lat6_ind(i)
              periode(k)=6;
             end 
          end
          for i = 1 : length(lat7_ind)
             if k==lat7_ind(i)
              periode(k)=7;
              end 
           end
        end
    end
    case (strcmpi(station,'NYA')==1)
    for k=1:lMLC
        [yy(k) month(k) dd(k)]=datevec(MLC_classification(k).date);
        if ic == 2
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
        if ic == 2
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
    if ic == 2
        if k < Njul
            periode(k)=1;
        elseif k>=Njul && k<Njul + Naug
            periode(k)=2;
        elseif k>=Njul + Naug && k<=Njul + Naug + Nseb
            periode(k)=3;
        end
    end
    end
end
    switch true
        case (strcmpi(station,'AO2018')==1)
            if ic == 0
                maxlist = 2;
            elseif ic == 1
                maxlist = 2;
            end
        case (strcmpi(station,'MOSAIC')==1)
            if ic == 1
                maxlist = 5;
            elseif ic == 2
                maxlist = 12;
            else 
            maxlist = 7; %5;%12;%7;
            end
        case (strcmpi(station,'NYA')==1)
            if ic == 2
            maxlist = 12;
            end
        case (strcmpi(station,'Utq')==1)
            if ic == 2
            maxlist = 12;
            end
        case (strcmpi(station,'ACSE')==1)
            if ic == 2
            maxlist = 3;
            end    
    end
   %list_Nan = zeros(1:maxlist);

%%    
%0cloud:
mon_0cloud=periode(idx_0cloud);                   %List of month of occurrence
[a_0cloud,b_0cloud]=hist(mon_0cloud,unique(mon_0cloud));
if(max(b_0cloud) > maxlist)
    b_0cloud = 1:maxlist;
end
list_0cloud(1:maxlist)=0;
%clear list_0cloud
for k=1:length(b_0cloud)
    list_0cloud(b_0cloud(k))=a_0cloud(k);       %List of amount per month
end
a = find(isnan(list_0cloud) ==1);
list_0cloud(a) = 0;
%%
%1cloud:
mon_1cloud=periode(idx_1cloud);                   %List of month of occurrence
[a_1cloud,b_1cloud]=hist(mon_1cloud,unique(mon_1cloud));
list_1cloud(1:maxlist)=0;
for k=1:length(b_1cloud)
    list_1cloud(b_1cloud(k))=a_1cloud(k);       %List of amount per month
end
list_1cloud(isnan(list_1cloud))=0;
%%
%both:
mon_both=periode(idx_both);                       %List of month of occurrence
mon_both(mon_both == 0) = [];
[a_both,b_both]=hist(mon_both,unique(mon_both));
list_both(1:maxlist)=0;
for k=1:length(b_both)
    list_both(b_both(k))=a_both(k);             %List of amount per month
end
%%
%nonseed:
mon_nonseed=periode(idx_nonseed);                 %List of month of occurrence
mon_nonseed(mon_nonseed == 0) = [];
[a_nonseed,b_nonseed]=hist(mon_nonseed,unique(mon_nonseed));
list_nonseed(1:maxlist)=0;
for k=1:length(b_nonseed)
    list_nonseed(b_nonseed(k))=a_nonseed(k);    %List of amount per month
end
list_nonseed(isnan(list_nonseed))=0;
%%
%only seeding:
mon_onlyseed=periode(idx_onlyseed);               %List of month of occurrence
mon_onlyseed(mon_onlyseed ==0) = [];
[a_onlyseed,b_onlyseed]=hist(mon_onlyseed,unique(mon_onlyseed));
tf = isempty(b_onlyseed);
if tf == 0
    if b_onlyseed(1) ~= 1
    b_onlyseed = b_nonseed;
    end  
end
list_onlyseed(1:maxlist)=0;
for k=1:length(a_onlyseed)
    list_onlyseed(b_onlyseed(k))=a_onlyseed(k); %List of amount per month
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
%%
%Amount of all:
periode_all=periode(index);                         %List of month of occurrence
periode_all(periode_all ==0) = [];
[a_all,b_all]=hist(periode_all,unique(periode_all));
list_all(1:maxlist)=0;
for k=1:length(b_all)
    list_all(b_all(k))=a_all(k);
end
%%
%Cloudcover:
periode_cloudcover=periode(idx_cloudcover);           %List of month of occurrence
periode_cloudcover(periode_cloudcover==0) = [];
[a_cloudcover,b_cloudcover]=hist(periode_cloudcover,unique(periode_cloudcover));
list_cloudcover(1:maxlist)=0;
for k=1:length(b_cloudcover)
    list_cloudcover(b_cloudcover(k))=a_cloudcover(k);
end
%%
%measurement days:
periode_nonNan=periode(idx_nonNan);                    %List of month of occurrence
periode_nonNan(periode_nonNan ==0) = [];
[a_nonNan,b_nonNan]=hist(periode_nonNan,unique(periode_nonNan));
list_nonNan(1:maxlist)=0;
for k=1:length(b_nonNan)
    list_nonNan(b_nonNan(k))=a_nonNan(k);
end

%%
%For histogram:
a = list_onlyseed + list_nonseed + list_both + list_1cloud + list_0cloud +list_1warm+list_2warm;
onlyseed_nonNan=list_onlyseed./a; %list_nonNan;
nonseed_nonNan=list_nonseed./a; %list_nonNan;
both_nonNan=list_both./a; %list_nonNan; 
cloud1_nonNan=list_1cloud./a; %list_nonNan; 
cloud0_nonNan=list_0cloud./a; %list_nonNan; 
warm1_nonNan=list_1warm./a; %list_nonNan; 
warm2_nonNan=list_2warm./a; %list_nonNan; 

XL(:,1)=nonseed_nonNan;
XL(:,2)=both_nonNan;
XL(:,3)=onlyseed_nonNan;
XL(:,4)=cloud1_nonNan;
XL(:,5)=cloud0_nonNan;
XL(:,6)=warm1_nonNan;
XL(:,7)=warm2_nonNan;
end