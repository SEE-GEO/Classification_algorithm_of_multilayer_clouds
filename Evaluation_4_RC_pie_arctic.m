%Evaluation_4_RC_pie

%This program generates the final Pie-plot

%mkdir('Plots','11_RC_final');                   %here are the plots stored
Evaluation_4_RC_calc_clean_v2

addpath('Matlab_extra_functions');                          
addpath('Matlab_extra_functions/matlab2tikz-master/src');   
addpath('Matlab_extra_functions/floatAxisY_M');                
load cm.mat; 

%%
%Pie Plot: without missing data

XP(1)=Anz_Nan/Anz_nonNan; %lAusw;                               
XP(2)=Anz_0cloud/Anz_nonNan;                             
XP(3)=Anz_noML0/Anz_nonNan;
XP(4)=Anz_1cloud/Anz_nonNan; 
XP(5)=Anz_noML1/Anz_nonNan; 
XP(6)=Anz_onlyseed/Anz_nonNan;    
XP(7)=Anz_both/Anz_nonNan;    
XP(8)=Anz_nonseed/Anz_nonNan; 
XP(9)=Anz_1warmcloud/Anz_nonNan; 
XP(10)=Anz_2warmcloud/Anz_nonNan; 

ans1=Anz_Nan+Anz_0cloud+Anz_1cloud+Anz_onlyseed+Anz_both+Anz_nonseed+Anz_noML;
ans2=Anz_0cloud+Anz_1cloud+Anz_onlyseed+Anz_both+Anz_nonseed+Anz_noML;
ans3 = Anz_1warmcloud + Anz_2warmcloud + Anz_0cloud + Anz_1cloud + Anz_onlyseed...
    + Anz_both + Anz_nonseed + Anz_noML0 + + Anz_noML1;

txt={['No data (raso&radar)']; ...                      
    ['clear sky: ']; ...                 
    ['No cloud: MLC by radiosounding, but no cloud by radar: ']; ...
    ['Single layer clouds by radiosounding: ']; ...
    ['Single layer cloud: MLC by radiosounding, but single layer cloud by radar: ']; ...
    ['Only seeding MLCs: ']; ...                   
    ['Both seeding and non-seeding MLCs: ']; ...                   
    ['Only non-seeding MLCs: '];...
    ['Single warm layer clouds: ']; ...                   
    ['MLC cold and warm cloud: ']};    
% No cloud by radiosounding
%%
grey =[0.702 0.702 0.702];

Xcolor(1,:)=grey;
Xcolor(2,:)=cm(1,:);
Xcolor(3,:)=colordg(21);
Xcolor(4,:)=cm(5,:);
Xcolor(5,:)=colordg(8);
Xcolor(6,:)=cm(3,:);
Xcolor(7,:)=cm(2,:);
Xcolor(8,:)=cm(7,:);
Xcolor(9,:)=cm(4,:);
Xcolor(10,:)=cm(6,:);

%Find, where XP==0. Remove label and color.
idx_0=find(XP==0);                             
txt(idx_0)=[];
Xcolor(idx_0,:)=[];

%Pie Plot:
f=figure(13);
set(gcf,'units','normalized','position',[.1 .1 0.8 0.3]);
h=pie(XP);
colormap(Xcolor);

%%
%t=title(strxcat('Days between June 2016 - June 2017 detected by Radiosonde and Radar, r=',Rsize,'\mum'));
title(strxcat('Raso and Radar data, r=',Rsize,'\mum'))
hText = findobj(h,'Type','text');                               % text object handles
percentValues = get(hText,'String');                            % percent values
combinedtxt = strcat(txt,percentValues);                        % strings and percent values
%Change position and label
oldExtents_cell = get(hText,'Extent');                          % cell array
oldExtents = cell2mat(oldExtents_cell);                         % numeric array
try
hText(1).String = combinedtxt(1);
% pos= hText(1).Position;
% hText(1).Position=[pos(1)+0.8 pos(2) pos(3)];
hText(2).String = combinedtxt(2);
% pos= hText(2).Position;
% hText(2).Position=[pos(1)+1.7 pos(2) pos(3)];
hText(3).String = combinedtxt(3);
% pos= hText(3).Position;
% hText(3).Position=[pos(1)+1.15 pos(2) pos(3)];
hText(4).String = combinedtxt(4);
% pos= hText(4).Position;
% hText(4).Position=[pos(1)-4.15 pos(2) pos(3)];
hText(5).String = combinedtxt(5);
% pos= hText(5).Position;
% hText(5).Position=[pos(1)-0.65 pos(2) pos(3)];
hText(6).String = combinedtxt(6);
% pos= hText(6).Position;
% hText(6).Position=[pos(1)-1.0 pos(2) pos(3)];
hText(7).String = combinedtxt(7);
% pos= hText(7).Position;
% hText(7).Position=[pos(1)-0.7 pos(2) pos(3)];
hText(8).String = combinedtxt(8);
hText(9).String = combinedtxt(9);
hText(10).String = combinedtxt(10);
hText(11).String = combinedtxt(11);
hText(12).String = combinedtxt(12);
catch
end

T = table(hText.String,combinedtxt(1));
writetable(T,strxcat('Plots/8_Pie_Plots/Pie_Raso_and_Radar_',name,'.txt'),'Delimiter',' ');
saveas(gcf,strxcat('Plots/8_Pie_Plots/Pie_Raso_and_Radar_',name,'.png'));
print(gcf,'-dpdf', '-fillpage', '-r300', '-painters', strxcat('Plots/8_Pie_Plots/Pie_Raso_and_Radar_',name,'.pdf')); 
%matlab2tikz(strxcat('Plots/11_RC_final/RC_Pie_',name,'.tex'));
clear T
%% Number of cloud layers
clear h htext XP combinedtxt
XP(1)=CL_Anz_0cloud/CL_Anz_nonNan;                             
XP(2)=CL_Anz_1cloud/CL_Anz_nonNan;
XP(3)=CL_Anz_2cloud/CL_Anz_nonNan; 
XP(4)=CL_Anz_3cloud/CL_Anz_nonNan; 
XP(5)=CL_Anz_4cloud/CL_Anz_nonNan;    
XP(6)=CL_Anz_5cloud/CL_Anz_nonNan; 
XP(7)=CL_Anz_6cloud/CL_Anz_nonNan;
XP(8)=CL_Anz_7cloud/CL_Anz_nonNan; 
XP(9)=CL_Anz_8cloud/CL_Anz_nonNan;      

%%
grey =[0.702 0.702 0.702];

Xcolor(1,:)=grey;
Xcolor(2,:)=cm(1,:);
Xcolor(3,:)=cm(2,:);
Xcolor(4,:)=cm(3,:);
Xcolor(5,:)=cm(4,:);
Xcolor(6,:)=cm(5,:);
Xcolor(7,:)=cm(6,:);
Xcolor(8,:)=cm(7,:);
Xcolor(9,:)=cm(8,:);

txt={['No cloud: ']; ...                 
    ['1 cloud layer: ']; ...                         
    ['2 cloud layers: ']; ...                   
    ['3 cloud layers: ']; ...    
    ['4 cloud layers: ']; ...                   
    ['5 cloud layers: ']; ... 
    ['6 cloud layers: ']; ...                   
    ['7 cloud layers: ']; ...
    ['>=8 cloud layers: ']}; 

 %Find, where XP==0. Remove label and color
 idx_0=find(XP==0);                           %index of Position                         
 txt(idx_0)=[];
 Xcolor(idx_0,:)=[];
 XP(idx_0) = [];

%Pie Plot:
f2=figure(18);
set(gcf,'units','normalized','position',[.1 .1 0.65 0.3]);
h=pie(XP);
%colormap(Xcolor);
colormap summer

%%
title(strxcat('only Cloudnet data, r=',Rsize,'\mum'))
%title(strxcat('Multilayer RH_i>100% days between June 2016 - June 2017, r=',Rsize,'\mum'))
hText = findobj(h,'Type','text');                           % text object handles
percentValues = get(hText,'String');                        % percent values
combinedtxt = strcat(txt,percentValues);                    % strings and percent values
oldExtents_cell = get(hText,'Extent');                      % cell array
oldExtents = cell2mat(oldExtents_cell);                     % numeric array
 try
 hText(1).String = combinedtxt(1);
% pos= hText(1).Position;                                     % change position of labels
% hText(1).Position=[pos(1)+0.8 pos(2) pos(3)];
 hText(2).String = combinedtxt(2);
% pos= hText(2).Position;                                     % change position of labels
% hText(2).Position=[pos(1)+1.1 pos(2) pos(3)];
 hText(3).String = combinedtxt(3);
% pos= hText(3).Position;                                     % change position of labels
% hText(3).Position=[pos(1)+0.8 pos(2) pos(3)];
 hText(4).String = combinedtxt(4);
% pos= hText(4).Position;                                     % change position of labels
% hText(4).Position=[pos(1)-1.3 pos(2) pos(3)];
 hText(5).String = combinedtxt(5);
% pos= hText(5).Position;                                     % change position of labels
% hText(5).Position=[pos(1)-0.9 pos(2) pos(3)];
 hText(6).String = combinedtxt(6);
 hText(7).String = combinedtxt(7);
 hText(8).String = combinedtxt(8);
 hText(9).String = combinedtxt(9);
  catch
 end

%move plot inside figure (if label is cutted off)
pos = get(gca, 'Position');
xoffset = -0.1;
pos(1) = pos(1) + xoffset;
set(gca, 'Position', pos)
T = table(hText.String,combinedtxt(1));
writetable(T,strxcat('Plots/8_Pie_Plots/Pie_Cloudnet_only_',name,'.txt'),'Delimiter',' ');
saveas(gcf,strxcat('Plots/8_Pie_Plots/Pie_Cloudnet_only_',name,'.png'));
print(gcf,'-dpdf', '-fillpage', '-r300', '-painters', strxcat('Plots/8_Pie_Plots/Pie_Cloudnet_only_',name,'.pdf')); 
clear T            
%matlab2tikz(strxcat('Plots/8_Raso/Pie_',name,'.tex'));

%%

clear ans1 ans2 Anz_2cloud Anz_nonseeding Anz_nonseeding_help Anz_seeding Anz_seeding_help Anz_trenn MLC_cloudlayers MLC_hmax combinedtxt ...
    grey hText idx_2cloud idx_nonseeding idx_seeding k newExtents newExtents_cell offset oldExtents oldExtents_cell ...
    percentValues pos signValues textPositions textPositions_cell txt width_change xoffset XP Xcolor f h idx_0 t

%%