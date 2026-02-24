%%
%pie plot

%In this program the plot of only using Raso is generated.
mkdir('Plots','8_Pie_Plots'); 
close(gcf)

%addpath('Matlab_extra_functions');                          %Path added for Matlab extra Programs (colors,etc.)
%addpath('Matlab_extra_functions/matlab2tikz-master/src');   %Path added for converting Pie Plot into .tex file. 
%addpath('Matlab_extra_functions/floatAxisY_M'); 
%load cm.mat;

Evaluation_1_arctic_calc                        %This is needed

%%
%Pie Plot in percentages

%XP(1)=Anz_Nan/Anz_nonNan;                               
XP(2)=Anz_0cloud/Anz_nonNan;                             
XP(3)=Anz_1cloud/Anz_nonNan;                             
XP(4)=Anz_onlyseed/Anz_nonNan;    
XP(5)=Anz_both/Anz_nonNan;    
XP(6)=Anz_nonseed/Anz_nonNan;    

Anz_0cloud+Anz_1cloud+Anz_onlyseed+Anz_both+Anz_nonseed;

%%
figure(1)
grey =[0.702 0.702 0.702];

Xcolor(1,:)=grey;
Xcolor(2,:)=cm(1,:);
Xcolor(3,:)=cm(5,:);
Xcolor(4,:)=cm(3,:);
Xcolor(5,:)=cm(2,:);
Xcolor(6,:)=cm(7,:);

txt={['no data: ']; ...                      
    ['No supersaturated layer: ']; ...                 
    ['Only one single supersaturated layer: ']; ...                         
    ['Only seeding subsaturated layers: ']; ...                   
    ['Both seeding and non-seeding subsaturated layers: ']; ...                   
    ['Only non-seeding subsaturated layers: ']}; 

%Find, where XP==0. Remove label and color
idx_0=find(XP==0);                           %index of Position                         
txt(idx_0)=[];
Xcolor(idx_0,:)=[];

%Pie Plot:
f1=figure(1);
set(gcf,'units','normalized','position',[.1 .1 0.65 0.3]);
h=pie(XP);
%colormap(Xcolor);
colormap summer

%%
title(strxcat('only Raso data, r=',Rsize,'\mum'))
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
 hText(10).String = combinedtxt(10);
 hText(11).String = combinedtxt(11);
 hText(12).String = combinedtxt(12);
 catch
 end
T = table(hText.String,combinedtxt(1));

%move plot inside figure (if label is cutted off)
pos = get(gca, 'Position');
xoffset = -0.1;
pos(1) = pos(1) + xoffset;
set(gca, 'Position', pos)

saveas(gcf,strxcat('Plots/8_Pie_Plots/Pie_Raso_only_',name,'.png'));
writetable(T,strxcat('Plots/8_Pie_Plots/Pie_Raso_only_',name,'.txt'),'Delimiter',' ');
%matlab2tikz(strxcat('Plots/8_Pie_Plots/Pie_Raso_only',name,'.tex'));
clear XP h text combinedtxt T
%% Pie Plot in percentages
%XP(1)=Anz_Nan/Anz_nonNan;                               
XP(2)=Anz_0cloud/Anz_nonNan;                             
XP(3)=Anz_1cloud/Anz_nonNan;                             
XP(4)=Anz_22cloud/Anz_nonNan;    
XP(5)=Anz_3cloud/Anz_nonNan;    
XP(6)=Anz_4cloud/Anz_nonNan;    
XP(7)=Anz_5cloud/Anz_nonNan;                             
XP(8)=Anz_6cloud/Anz_nonNan;                             
XP(9)=Anz_7cloud/Anz_nonNan;    
XP(10)=Anz_8cloud/Anz_nonNan;     

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

txt={['no data: ']; ...                      
    ['No cloud: ']; ...                 
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

%Pie Plot:
f2=figure(2);
set(gcf,'units','normalized','position',[.1 .1 0.65 0.3]);
h=pie(XP);
%colormap(Xcolor);
colormap summer

%%
title(strxcat('only Raso data, r=',Rsize,'\mum'))
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
 hText(10).String = combinedtxt(10);
 hText(11).String = combinedtxt(11);
 hText(12).String = combinedtxt(12);
 catch
 end

%move plot inside figure (if label is cutted off)
pos = get(gca, 'Position');
xoffset = -0.1;
pos(1) = pos(1) + xoffset;
set(gca, 'Position', pos)
T = table(hText.String,combinedtxt(1));
writetable(T,strxcat('Plots/8_Pie_Plots/Pie_Raso_only_',name,'.txt'),'Delimiter',' ');
saveas(gcf,strxcat('Plots/8_Pie_Plots/Pie_Raso_only_',name,'.png'));
%matlab2tikz(strxcat('Plots/8_Raso/Pie_',name,'.tex'));
clear T
%%
clear Anz_2cloud Anz_nonseeding Anz_nonseeding_help Anz_seeding Anz_seeding_help Anz_trenn ...
    MLC_loudlayers Ausw_hmax combinedtxt grey hText idx_2cloud idx_nonseeding idx_seeding k ...
    newExtents newExtents_cell offset oldExtents oldExtents_cell percentValues pos signValues ...
    textPositions textPositions_cell txt width_change xoffset Xcolor XP f4 h 


