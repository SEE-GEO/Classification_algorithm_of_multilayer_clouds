% clear all
% Myfileinfo =dir('C:\Users\pt19teje\Documents\Data\Mamip\Programme\Classification_MLC\MLC_classification_*_MOSAIC*.mat');
% % add to one file
% %%
% load(Myfileinfo(11).name)
% for i = 1 : MLC_classification(end).number_i
%     mosaic(i) = MLC_classification(i);
% end
% clear MLC_classification i
% load(Myfileinfo(10).name);
% for i = 1 : MLC_classification(end).number_i
%     mosaic = [mosaic,MLC_classification(i)];
% end
% clear MLC_classification i
% load(Myfileinfo(3).name);
% for i = 1 : MLC_classification(end).number_i
%     mosaic = [mosaic,MLC_classification(i)];
% end
%  clear MLC_classification i
%  load(Myfileinfo(5).name);
%  for i = 1 : MLC_classification(end).number_i
%      mosaic = [mosaic,MLC_classification(i)];
%  end
%   clear MLC_classification i
%  load(Myfileinfo(4).name);
%  for i = 1 : MLC_classification(end).number_i
%      mosaic = [mosaic,MLC_classification(i)];
%  end
%  clear MLC_classification i
%  load(Myfileinfo(8).name);
%  for i = 1 : MLC_classification(end).number_i
%      mosaic = [mosaic,MLC_classification(i)];
%  end
%  clear MLC_classification i
%  load(Myfileinfo(1).name);
%  for i = 1 : MLC_classification(end).number_i
%      mosaic = [mosaic,MLC_classification(i)];
%  end
%  clear MLC_classification i
%  load(Myfileinfo(9).name);
%  for i = 1 : MLC_classification(end).number_i
%      mosaic = [mosaic,MLC_classification(i)];
%  end
%  clear MLC_classification i
%  load(Myfileinfo(7).name);
%  for i = 1 : MLC_classification(end).number_i
%      mosaic = [mosaic,MLC_classification(i)];
%  end
%  clear MLC_classification i
%  load(Myfileinfo(6).name);
%  for i = 1 : MLC_classification(end).number_i
%      mosaic = [mosaic,MLC_classification(i)];
%  end
%  clear MLC_classification i
%  load(Myfileinfo(2).name);
%  for i = 1 : MLC_classification(end).number_i
%      mosaic = [mosaic,MLC_classification(i)];
%  end
%  clear MLC_classification i
%  load(Myfileinfo(13).name);
%  for i = 1 : MLC_classification(end).number_i
%      mosaic = [mosaic,MLC_classification(i)];
%  end
%  %%
%  clear MLC_classification i
%  MLC_classification = mosaic;
 %%
 %MLC_classification.number_i = {1:1410};
 load('MLC_classification_400_msub100_RH100.mat')
 %clear mosaic
 %index=1:1410;
 index = 1:131;
%%
% April 137, August 121, Dec 117, Feb 113, Jan 111, Jul 123, Jun 91, March
% 109, May 121, Nov 119, Oct 84, Sep 162, 
load cm.mat;
Rsize=400;                  %Radius of ice crystal [mikrometer]. Std Rsize=100 
%name = ('Mosaic_season');
name = ('AO2018 month')
station = ('AO2018')

%%
%Only Raso(=Radiosonde):
Evaluation_2_arctic_pie                   %läuft auch einzeln                   %Raso-Pie plot                            
Evaluation_2_arctic_histogram_radii       %Histogram with all 3 radius in one.
%Evaluation_2_arctic_visual                %Reads and evaluates the manual visual detection
%Deleting variables that are not needed any more:
clear Anz_0cloud Anz_1cloud Anz_both Anz_cloudcover Anz_Nan Anz_nonNan Anz_nonseed Anz_onlyseed idx_0cloud ...
    idx_1cloud idx_both idx_cloudcover idx_Nan idx_nonNan idx_nonseed idx_onlyseed Anz_noML Anz_noML0 Anz_noML1 ...
    idx_noML idx_noML0 idx_noML1

% %%
% %Cloud categories:
 Evaluation_3_arctic_nonSeeding                    %Cloud category of non-seeding
 Evaluation_3_arctic_Seeding                       %Cloud category of seeding
% 
% %%
% %Raso and Radar (RC) combined:             
 Evaluation_4_RC_calc_arctic                        %Preparation of following plots (is included in the two following programs)
 Evaluation_4_RC_pie_arctic                         %Pie-plot        
 Evaluation_4_RC_histogram_arctic            %Histogram with all 3 radius in one