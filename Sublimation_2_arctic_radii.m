%layer 1

%In this program the two plots of the Paper are generated: 1. fallspeed and mass 2. fall distance
% try
%mkdir('Plots','4_Sublimation');                 %create folder for plots 
mkdir('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/Plots',strxcat('4_Sublimation_',name)); 

close all
set(0, 'DefaultFigureRenderer', 'OpenGL');      %to remove the distance between 100 and mu in label.

Rsize_orig=Rsize;     %Rsize=400

%Define the size of the axis:
for il = 1:size(Sublimation,2) %layer_anzahl
    %layer_anzahl
    layer=il; %1;%2;            %Which layer? layer nr starts counting from top. 
    dt=20;%dt=40;              %Time axis
    fls=0.6;%fls=0.6;            %Fall speed axis
    dm=2.0e-8;%dm=2.1e-8;          %Mass axis

    fs=8;%10;              %define common fontSize Schriftgröße


    %%
        %maxtime400=maxtime;                        
        %Sublimation400=Sublimation;                
        %name=strxcat(Rsize);                               
        %save(strxcat('Sublimation_',name,'_',kDate,'.mat'), strxcat('maxtime',Rsize),strxcat('Sublimation',Rsize)); 
        %save(strxcat('/projekt6/aerocloud/data/Mamip/Mosaic/Output/Sublimation_',name,'_',kDate,'.mat'), strxcat('maxtime'),strxcat('Sublimation')); 
        %save(strxcat('Sublimation_',name,'_',i,'.mat'), strxcat('maxtime',Rsize),strxcat('Sublimation',Rsize));
    %%
    %Specify which layer should be used: 
    %In the paper the layer 1 is the upper most. This equals kchose=4 in the program.

    kvec=[1:k];
    layervec=fliplr(kvec);
    %kchose=layervec(layer);
    kchose=il;

    %%
    %Plot1: Fallspeed and mass

    gcf = figure; set(gcf, 'Visible', 'off');                                              
    set(gcf,'units','normalized','position',[.5 .5 0.5 0.4]);

    hl1=plot(Sublimation(kchose).time_min,Sublimation(kchose).mass,'Color',cm(2,:),'DisplayName',strxcat('r=',Rsize,'\mum'),'LineWidth',1.5);
    hold on;
    xlim([0 dt]);
    %ylim([0; Sublimation400(kchose).mass(1)]);  %for seeding
    ylim([0 dm]);
    ylabel('Mass of particle in kg');
    xlabel('Time in min');
    grid on;
    set(gca,'FontSize',fs);

    %[hl6,ax6,ax7] = floatAxisY_M(Sublimation400(kchose).time_min(2:end),Sublimation400(kchose).speed(2:end),'--',strxcat('Fall speed in m s^{-1}'),[0 dt 0 Sublimation400(kchose).speed(1)],1.5,cm(2,:),8);
    [hl6,~,ax7] = floatAxisY_M(Sublimation(kchose).time_min(2:end),Sublimation(kchose).speed(2:end),'--',strxcat('Fall speed in m s^{-1}'),[0 dt 0 fls],1.5,cm(2,:),8);
    set(ax7,'FontSize',fs)

    h1=legend([hl1 hl6],strxcat('Mass of initial r=',Rsize,' \mum'),strxcat('Fall speed of initial r=',Rsize',' \mum'),'Location','best');

    set(h1,'FontSize',fs);
    set(h1,'units','normalized');
    % set(h1,'Location','northeast') %non-seeding
    set(h1,'Location','best')  %for seeding

    %insert a) in plot 
    str = 'a)';
    dim = [.1 .1 .03 .07];
    annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor','none','LineStyle','none','FontSize',fs); %'Location','northeast'

    tightfig(gcf);   %makes plot nicer

    fig = gcf;
    fig.PaperPositionMode = 'auto';
    fig.PaperSize =  [25.5 13];
    set(fig, 'DefaultFigureRenderer', 'openGL');      %to remove the distance between 100 and mu in label.
    saveas(gcf,strxcat('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/Plots/4_Sublimation_',name,'/',datestr(Raso(iDate).N(1),'yyyy-mm-dd'),'_',kDate,'_Sublimation_layer',layer,'_mass_speed',ending,'.png'));
    print('-depsc2', '-tiff', '-r300', '-vector', strxcat('/projekt6/aerocloud/Peggy/Mamip/Mosaic/Output/Plots/4_Sublimation_',name,'/',datestr(Raso(iDate).N(1),'yyyy-mm-dd'),'_',kDate,'_Sublimation_layer',layer,'_mass_speed',ending,'.eps'))
    
    %%
    %Plot 2: fall distance

    gcf = figure; set(gcf, 'Visible', 'off');                 
    set(gcf,'units','normalized','position',[.5 .5 0.3 0.4]);

    plot(Sublimation(kchose).time_min,Sublimation(kchose).height*1e-3,'Color',cm(2,:),'DisplayName',strxcat('Fall distance of initial r = ',Rsize',' \mum'),'LineWidth',1.5)
    hold on;

    xlim([0 dt]);
    ylim([Cloudixd(iDate).height_sub_bottom(kchose)*1e-3; Sublimation(kchose).initial_cond(4)*1e-3]);
    xlabel('Time in min');

    hoehe=(Sublimation(kchose).initial_cond(4)*1e-3)-(Cloudixd(iDate).height_sub_bottom(kchose)*1e-3);
    yticks([Cloudixd(iDate).height_sub_bottom(kchose)*1e-3:(0.2*hoehe):Sublimation(kchose).initial_cond(4)*1e-3]);
    yticklabels({'0','0.2','0.4','0.6','0.8','1'})


    % ylabel(strxcat('Thickness of layer ',layer,' = ',hoehe,' km'));
    ylabel(strxcat('Normalised Thickness of layer ',layer))

    dim = [.39 .23 .5 .6];
    str = {'Absolute thickness of layer = '};
    annotation('textbox',dim,'EdgeColor','none','String',str,'FitBoxToText','on','FontSize',fs);

    dim = [.73 .23 .5 .6];
    str = {hoehe};
    annotation('textbox',dim,'EdgeColor','none','String',str,'FitBoxToText','on','FontSize',fs);

    dim = [.81 .23 .5 .6];
    str = {'km'};
    annotation('textbox',dim,'EdgeColor','none','String',str,'FitBoxToText','on','FontSize',fs);

    %creat box around legend and textbox
    dim = [.38 .762 .5 .13];
    annotation('rectangle',dim,'Color','black')

    h2=legend('show','Location','northeast');
    legend('boxoff')
    grid on;
    set(h2,'FontSize',fs);
    set(gca,'FontSize',fs);
    set(h2,'units','normalized');

    %insert b) in plot
    str = 'b)';
    dim = [.005 .1 .03 .07];
    annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor','none','LineStyle','none','FontSize',fs);

    set(0, 'DefaultFigureRenderer', 'OpenGL');      %to remove the distance between 100 and mu in label.

    fig = gcf;
    fig.PaperPositionMode = 'auto';
    fig.PaperSize =  [15 12.6];
    saveas(gcf,strxcat('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/Plots/4_Sublimation_',name,'/',datestr(Raso(iDate).N(1),'yyyy-mm-dd'),'_',kDate,'_Sublimation_layer',layer,'_dist',ending,'.png'));
    print('-depsc2', '-tiff', '-r300', '-vector', strxcat('/projekt6/aerocloud/Peggy/Mamip/Mosaic/Output/Plots/4_Sublimation_',name,'/',datestr(Raso(iDate).N(1),'yyyy-mm-dd'),'_',kDate,'_Sublimation_layer',layer,'_dist',ending,'.eps'))
     %catch
    close all
end

%%

%%
clear kmax ax1 ax2 ax3 ax4 ax5 ax6 ax7 hl1 hl2 hl3 hl4 hl5 hl6 dim f2 fig fs h1 h2 str ans Rsize_orig
clear maxtime maxtime50 maxtime100 maxtime150 Sublimation Sublimation50 Sublimation100 Sublimation150 
clear kchose kvec layervec

