%Histogram - using only Raso

mkdir('Plots','8_Histogram');
%Some extra Matlab programs are needed:
addpath('Matlab_extra_functions');                          %Path added for Matlab extra Programs (colors,etc.)
addpath('Matlab_extra_functions/matlab2tikz-master/src');   %Path added for converting Pie Plot into .tex file. 
addpath('Matlab_extra_functions/floatAxisY_M');                % changed original addpath('Matlab_extra_functions/floatAxis')
addpath('Matlab_extra_functions/export_fig-master');       %Paths do not work, why

%%
%MLC_classification400=MLC_classification;         
[XL400, listdays] = func_4_histogram_arctic(MLC_classification, index,name, station, Njan,...
    Nfeb, Nmar, Napr, Nmay, Njun, Njul, Naug, Nseb, Noct, Nnov, Ndec, modeic, idx_1warmcloud, idx_2warmcloud);

XLall(:,2,:)=[XL400];

NumStacksPerGroup = 1;                      %Radii
NumStackElements = 7;                       %Categories
NumGroupsPerAxis = 10%5;                      %Months
switch true
    case (strcmpi(station,'AO2018')==1)
        if modeic == 1
            groupLabels = {['summer=' num2str(listdays(1))],['autumn=' num2str(listdays(2))]};
        end
        if modeic == 0
            groupLabels = {['august=' num2str(listdays(1))],['sebtember=' num2str(listdays(2))]};
        end
    case (strcmpi(station,'MOSAIC')==1)
        if modeic == 2
           groupLabels = {['Oct=' num2str(listdays(1))],['Nov=' num2str(listdays(2))],...
            ['Dec=' num2str(listdays(3))],['Jan=' num2str(listdays(4))],['Feb=' num2str(listdays(5))],...
            ['Mar=' num2str(listdays(6))],['Apr=' num2str(listdays(7))],['May=' num2str(listdays(8))],...
            ['Jun=' num2str(listdays(9))],['Jul=' num2str(listdays(10))],['Aug=' num2str(listdays(11))],...
            ['Sep=' num2str(listdays(12))]}; 
        elseif modeic ==1
           groupLabels = {['autumnt=' num2str(listdays(1))],['winter=' num2str(listdays(2))],...
            ['spring=' num2str(listdays(3))],['summer=' num2str(listdays(4))],['autumn=' num2str(listdays(5))]}; 
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
        end   
end

%%
%Plot
fs=8;                              %common fontsize
figure(8)
 set(gcf,'units','normalized','position',[.5 .15 0.7 0.5]);

 b2=plotBarStackGroupsM(XLall*1e2, groupLabels);
 switch true
    case (strcmpi(station,'AO2018')==1)
        if modeic == 0
            axis([0.5 2.5 0 100]);  
        end
    case (strcmpi(station,'MOSAIC')==1)
        if modeic == 2
            axis([0.5 12.5 0 100]);  
        elseif modeic == 1
            axis([0.5 5.5 0 100]);  
        else
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
        end   
 end
 xtickangle(45)
for ij=1:2
    b2(ij,1).FaceColor = [cm(7,:)];
    b2(ij,2).FaceColor = [cm(2,:)];
    b2(ij,3).FaceColor = [cm(3,:)];
    b2(ij,4).FaceColor = [cm(5,:)];
    b2(ij,5).FaceColor = [cm(1,:)];
    b2(ij,6).FaceColor = [cm(4,:)];
    b2(ij,7).FaceColor = [cm(6,:)];
end
xlabel('Period and number of Raso profiles in r')
ylabel('Relative occurrence in %')
h1=legend(  'Only non-seeding subsaturated layer', ...
            'Both seeding and non-seeding subsaturated layer', ...
            'Only seeding subsaturated layers', ...
            'Only one single supersaturated layer',...
            'No supersaturated layer',...
            'Warm cloud single',...
            'Warm cloud MLC',...
            'Location','eastoutside');
set(gca,'FontSize',fs);
set(h1,'FontSize',fs);
legend boxoff
title(strxcat('only Raso data, r=',Rsize,'\mum'))

fig = gcf;
fig.PaperPositionMode = 'auto';
fig.PaperSize =  [33.5 16];

saveas(gcf,strxcat('Plots/8_Histogram/Histogram_Raso_only_',name,'.png'));
print(gcf,'-dpdf', '-fillpage', '-r300', '-vector', strxcat('Plots/8_Histogram/Histogram_Raso_only_',name,'.pdf')); 
            
%%

clear a_0cloud a_1cloud a_all a_both a_cloudcover a_Nan a_nonNan a_nonseed a_onlyseed Anz_DateNan ...
    MLC_dateRaso ax1 b1 b2 b_0cloud b_1cloud b_all b_both b_cloudcover b_Nan b_nonNan b_nonseed ...
    b_onlyseed both both_cover cloud0 cloud1 cloud1_cover cloud1_nonNan grey h list_0cloud list_1cloud ...
    list_all list_both list_cloudcover list_Nan list_nonNan list_nonseed list_onlyseed mon_0cloud ...
    mon_1cloud mon_both mon_Nan mon_nonseed mon_onlyseed month_all month_cloudcover month_nonNan ...
    multilayer_nonNan Nanval nonseed nonseed_cover onlyseed onlyseed_cover XH XHc XL x yy month dd ...
    Anz_0cloud Anz_1cloud Anz_both Anz_cloudcover Anz_Nan Anz_nonNan Anz_nonseed Anz_onlyseed both_nonNan ...
    cloud0_nonNan idx_0cloud idx_1cloud idx_both idx_cloudcover idx_Nan idx_nonNan idx_nonseed idx_onlyseed ...
    k nonseed_nonNan onlyseed_nonNan XLc fs ans fig h1 idx_0 groupLabels ij MLC_classification100 ...
    MLC_classification50 MLC_classification150  NumGroupsPerAxis NumStackElements NumStacksPerGroup XL400 ...
    XL100 XL200 XLall listdays

%%
