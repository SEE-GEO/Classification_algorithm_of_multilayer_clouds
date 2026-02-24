%Evaluation_4_RC_histogram_radii

%This program generates the final histogram plot

mkdir('Plots','8_Histogram');

addpath('Matlab_extra_functions');                          
addpath('Matlab_extra_functions/matlab2tikz-master/src');   
addpath('Matlab_extra_functions/floatAxisY_M');               

load cm.mat;
%%
MLC_classification400=MLC_classification;  

[XL400,listdays] = func_5_histogram_arctic(MLC_classification400, index, station, Njan, Nfeb, Nmar, Napr, Nmay, Njun, Njul, Naug, Nseb, Noct, Nnov, Ndec,  modeic);

%%
XLall(:,2,:)=[XL400];

NumStacksPerGroup = 1;                      %Radii
NumStackElements = 9;                       %Categories
NumGroupsPerAxis = 10;%5;                      %Months
switch true
    case (strcmpi(station,'AO2018')==1)
        if modeic == 1
            groupLabels = {['summer=' num2str(listdays(1))],['autumn=' num2str(listdays(2))]};
        end
        if modeic == 2
            groupLabels = {['august=' num2str(listdays(1))],['sebtember=' num2str(listdays(2))]};
        end                           
    case (strcmpi(station,'MOSAIC')==1)
        if modeic == 1 
            groupLabels = {['autumnt=' num2str(listdays(1))],['winter=' num2str(listdays(2))],...
            ['spring=' num2str(listdays(3))],['summer=' num2str(listdays(4))],['autumn=' num2str(listdays(5))]};
        elseif modeic == 2 
            groupLabels = {['Oct=' num2str(listdays(1))],['Nov=' num2str(listdays(2))],...
            ['Dec=' num2str(listdays(3))],['Jan=' num2str(listdays(4))],['Feb=' num2str(listdays(5))],...
            ['Mar=' num2str(listdays(6))],['Apr=' num2str(listdays(7))],['May=' num2str(listdays(8))],...
            ['Jun=' num2str(listdays(9))],['Jul=' num2str(listdays(10))],['Aug=' num2str(listdays(11))],...
            ['Sep=' num2str(listdays(12))]};
        else 
            groupLabels = {['above 88' char(176) 'N = ' num2str(listdays(1))],['between 86 and 88' char(176) 'N = ' num2str(listdays(2))],...
            ['between 84 and 86' char(176) 'N = ' num2str(listdays(3))],['between 82 and 84' char(176) 'N = ' num2str(listdays(4))],...
            ['between 80 and 82' char(176) 'N = ' num2str(listdays(5))],['below 80' char(176) 'N = ' num2str(listdays(6))]};
        end
     case (strcmpi(station,'NYA')==1)
        if modeic == 2
           groupLabels = {['Jan=' num2str(listdays(1))],['Feb=' num2str(listdays(2))],...
            ['Mar=' num2str(listdays(3))],['Apr=' num2str(listdays(4))],['May=' num2str(listdays(5))],...
            ['Jun=' num2str(listdays(6))],['Jul=' num2str(listdays(7))],['Aug=' num2str(listdays(8))],...
            ['Sep=' num2str(listdays(9))],['Oct=' num2str(listdays(10))],['Nov=' num2str(listdays(11))],...
            ['Dec=' num2str(listdays(12))]}; 
        end
     case (strcmpi(station,'Utq')==1)
        if modeic == 2
           groupLabels = {['Jan=' num2str(listdays(1))],['Feb=' num2str(listdays(2))],...
            ['Mar=' num2str(listdays(3))],['Apr=' num2str(listdays(4))],['May=' num2str(listdays(5))],...
            ['Jun=' num2str(listdays(6))],['Jul=' num2str(listdays(7))],['Aug=' num2str(listdays(8))],...
            ['Sep=' num2str(listdays(9))],['Oct=' num2str(listdays(10))],['Nov=' num2str(listdays(11))],...
            ['Dec=' num2str(listdays(12))]}; 
        end
    case (strcmpi(station,'ACSE')==1)
        if modeic == 2
           groupLabels = {['Jul=' num2str(listdays(1))],['Aug=' num2str(listdays(2))],...
            ['Sep=' num2str(listdays(3))]}; 
        else modeic == 1
            groupLabels = {['summer=' num2str(listdays(1))],['autumn=' num2str(listdays(2))]};
        end 
end

txt3={['Only non-seeding MLCs ']; ...
    ['Both seeding and non-seeding MLCs ']; ...                   
    ['Only seeding MLCs ']; ...                   
    ['MLC by radiosounding, but single-layer cloud by radar']; ...
    ['Single-layer clouds by radiosounding ']; ...
    ['MLC by radiosounding, but not even single-layer cloud by radar ']; ...
    ['clear sky ']; ...
    ['Single-layer warm cloud']; ...
    ['MLC with warm cloud']}; 
%No cloud by radiosounding
%%
%Plot histogram
fs=8;                                       %common font size

figure(16)

set(gcf,'units','normalized','position',[.5 .15 0.7 0.5]);

b2=plotBarStackGroupsM(XLall*1e2, groupLabels);
switch true
    case (strcmpi(station,'AO2018')==1)
    axis([0.5 2.5 0 100]);                              
    case (strcmpi(station,'MOSAIC')==1)
        if modeic == 1 
        axis([0.5 5.5 0 100]);
        end
        if modeic == 2
        axis([0.5 12.5 0 100]);  
        end
        if modeic == 3
        axis([0.5 6.5 0 100]); 
        end
    case (strcmpi(station,'NYA')==1)
        if modeic == 2
            axis([0.5 12.5 0 100]); 
        end
    case (strcmpi(station,'Utq')==1)
        if modeic == 2
            axis([0.5 12.5 0 100]); 
        end
    case (strcmpi(station,'ACSE')==1)
        if modeic == 2
            axis([0.5 3.5 0 100]);  
        else
            axis([0.5 2.5 0 100]);
        end      
end
xtickangle(45)

for ij=1:2
    b2(ij,1).FaceColor = [cm(7,:)];
    b2(ij,2).FaceColor = [cm(2,:)];
    b2(ij,3).FaceColor = [cm(3,:)];
    b2(ij,4).FaceColor = [colordg(8)];
    b2(ij,5).FaceColor = [cm(5,:)];
    b2(ij,6).FaceColor = [colordg(21)];
    b2(ij,7).FaceColor = [cm(1,:)];
    b2(ij,8).FaceColor = [cm(4,:)];
    b2(ij,9).FaceColor = [colordg(5)];
end
xlabel('Period and number of Raso profiles in r');
ylabel('Relative occurrence in %');
legend(txt3,'Location','eastoutside','FontSize',fs);
set(gca,'FontSize',fs);
legend boxoff
title(strxcat('Raso and Radar data, r=',Rsize,'\mum'))

fig = gcf;
fig.PaperPositionMode = 'auto';

fig.PaperSize =  [34 16];

saveas(gcf,strxcat('Plots/8_Histogram/Hist_Raso_and_Radar_',name,'.png'));
print(gcf,'-dpdf', '-fillpage', '-r300', '-vector', strxcat('Plots/8_Histogram/Hist_Raso_and_Radar_',name,'.pdf')); 

%%

clear a_0cloud a_1cloud a_all a_both a_cloudcover a_Nan a_noML0 a_noML1 a_nonNan a_nonseed a_onlyseed ...
    ans Anz_0cloud Anz_1cloud Anz_2cloud Anz_34 Anz_both Anz_cloudcover Anz_Nan Anz_noML Anz_noML0 ...
    Anz_noML1 Anz_nonNan Anz_nonseed Anz_nonseeding Anz_nonseeding_help Anz_onlyseed Anz_seeding ...
    Anz_seeding_help Anz_trenn MLC_cloudlayers MLC_hmax b2 b_0cloud b_1cloud b_all b_both ...
    b_cloudcover b_Nan b_noML0 b_noML1 b_nonNan b_nonseed b_onlyseed both_nonNan cloud0_nonNan ...
    cloud1_nonNan fig fs grey idx_0cloud idx_1cloud idx_2cloud idx_both idx_cloudcover idx_Nan ...
    idx_noML idx_noML0 idx_noML1 idx_nonNan idx_nonseed idx_nonseeding idx_onlyseed idx_seeding ...
    kk k list_0cloud list_1cloud list_all list_both list_cloudcover list_Nan list_noML0 list_noML1 ...
    list_nonNan list_nonseed list_onlyseed lS mon_0cloud mon_1cloud mon_both mon_Nan mon_noML0 ...
    mon_noML1 mon_nonseed mon_onlyseed month_all month_cloudcover month_nonNan noML0_nonNan ...
    noML1_nonNan onlyseed_nonNan SeedingS sum_34 txt txt3 XL yy Zcloudabove Zcloudbelow ...
    nonseed_nonNan ans groupLabels ij MLC_classification100 MLC_classification150 MLC_classification50 ...
    NumGroupsPerAxis NumStackElements NumStacksPerGroup XL50 XL100 XL150 XLall listdays

%%


