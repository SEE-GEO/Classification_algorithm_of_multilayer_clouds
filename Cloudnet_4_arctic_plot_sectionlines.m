%plot sectionlines
%This program creates the plot of both Raso and Cloudnet.
fs=8;              %fontsize. 10=std. Poster:15


if NoRasoNum==0                                %only if Raso is available  
    if NoCloudnet(1).Num==0                            %only if Cloudnet exists
        if sizeZ(2)>30                                 %only if there is min one cloudless laye
            if numcloud(xDate)>=2                          %only if min 1 nocloudlayer
                %if layer_anzahl(jDate) > 0

                numcloud(xDate);
                datestr(datevec(Nbefore));
                datestr(datevec(Nafter));
            %Black lines indicating time in plot: Find time beginn and time end
            %Nbefore and Nafter taken from Cloudnet_4_preparation_adv

            [Nbefore_vec,~] = meshgrid(Nbefore',Cloudnet_short(xDate).height'); %y22
            [Nafter_vec,~] = meshgrid(Nafter',Cloudnet_short(xDate).height');

            reso=20;                       %Plot-Color-Resolution
            %Plot Reflectivity:
            [yy1, mm1, dd1]=datevec(Cloudnet_short(xDate).N(1));
            if timeStart==23
             [yy2, mm2, dd2]=datevec(Cloudnet_short(xDate).N(1)+1);
            end

            gcf = figure; 
            set(gcf, 'Visible', 'off'); 

            %set(gcf,'units','normalized','position',[.5 .15 0.6 0.5]);
            %set(gcf,'units','normalized','position',[.5 .15 .30 .700]);
%%
            %First plot: Raso
            ax(1)=subplot(1,3,1);
            %ax1 = subplot(1,2,1);
            %t = tiledlayout(1,1);
            hAx(1) = gca;
            p1=plot(Raso(jDate).RHl,Raso(jDate).alt*1e-3,'LineWidth',1.25,'DisplayName','RH liquid','Color',cm(1,:));
            p2=line(Raso(jDate).RHi,Raso(jDate).alt*1e-3,'LineWidth',1.25,'DisplayName','RH ice','Color',cm(2,:));
            grayColor = [.7 .7 .7];
            xline(100,'--','Color', grayColor)
            %ylim([0.2228 hmax]);
            ylim([0 hmax]);
            xlim([0 150]);
            ax(2)=gca;
            ylabel('Height (km)','FontSize',fs);
            xlabel('RH (%)','FontSize',fs);
            set(gca,'FontSize',fs)
            box off
            hAx(2)=axes('Position',hAx(1).Position,'XAxisLocation','top','YAxisLocation','right','color','none');
            hold(hAx(2),'on')
            p3=line(Raso(jDate).tempK-273.15,Raso(jDate).alt*1e-3,'LineWidth',1.25,'DisplayName','T ','Color',cm(7,:));
            xlim([-80 10]);
            ylim([0 hmax]);
            xlabel('Temperature (^{\circ} C) ','FontSize',fs,'Color',cm(5,:))     
            %legend([p1; p2; p3],{'RH liquid','RH ice','T'},'NumColumns',2); %'Location','northoutside',
            %set(h,'FontSize',fs);
            set(gca,'FontSize',fs)
            set(gca,'xcolor',cm(7,:))   
            set(gca,'YTickLabel',[]);
            grid on;
           % % Create textbox
           % cl = {'b', 'r', 'g'};
           % annotation(gcf,'textbox',...
           % [0.69 0.58452380952381 0.0693125 0.102380952380953],...
           %  'String','RH  liquid','Color',cm(1,:),'Interpreter','latex','FitBoxToText','on','LineStyle','none','FontSize',10);
           % annotation(gcf,'textbox',...
           % [0.69 0.58452380952381 0.0693125 0.071380952380953],...
           %  'String','RH  ice','Color',cm(2,:),'Interpreter','latex','FitBoxToText','on','LineStyle','none','FontSize',10);           
           % annotation(gcf,'textbox',...
           % [0.69 0.58452380952381 0.0693125 0.032380952380953],...
           %  'String','T','Color',cm(7,:),'Interpreter','latex','FitBoxToText','on','LineStyle','none','FontSize',10);
           % set(gca,'FontSize',fs)
           
        %%

            % Plotting red horisontal lines 
            for k=1:layer_anzahl(jDate)                                                  
                mu=Cloudnet_short(xDate).height(indexAtTopNoCloud(k))*1e-3;
                
                hline = refline([0 mu]);
                hline.Color = 'r';clear mu

                mu=Cloudnet_short(xDate).height(indexAtBottomNoCloud(k))*1e-3;
                hline = refline([0 mu]);
                hline.Color = 'r'; clear mu

            end
%%

            % for grey transparent boxes:
            greyt =[0.702 0.702 0.702 0.3];                          %transparent grey color
            for k=1:layer_anzahl(jDate)

                mu=Cloudnet_short(xDate).height(indexAtTopNoCloud(k))*1e-3;
                muk(k)=mu; clear mu

                mu=Cloudnet_short(xDate).height(indexAtBottomNoCloud(k))*1e-3;
                muk2(k)=mu; clear mu

                t = (muk(k)+muk2(k))/2;

                txt = {(layer_anzahl(jDate)+1-k)};
                text(5,t,txt,'FontSize',fs)

            end
%%
            % für subsaturated layers = grey
            if exist('muk2') == 1
            for j=1:length(muk2)
                rectangle('Position',[-80 muk2(j) 150 muk(j)-muk2(j)],'EdgeColor','none','Facecolor', greyt)
            end
            end
%%
            % Make label a) in plot
            str = 'a)';
            dim = [.140 .10 .09 .07];
            annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor','none','LineStyle','none','FontSize',fs);


%%
%Name the subsaturated layers by numbers
            %disp('careful, please check numbers');

            % Second plot part: reflectivity
            ax(3)=subplot(1,3,2);
                                     
              if (timeStart==23) 

            %       indexAtStart23=indexAtStart
            %       indexAtEnd23=indexAtEnd1-10
                x = Raso(jDate).N;
                valueToMatch = datenum(yy1,mm1,dd1,timeStart,00,00);
                % Find the closest value.
                [~, indexAtStart23rs] = min(abs(x - valueToMatch)); 
                clear valueToMatch

                %for limiting height where we look for multi-layer clouds:
                x = Raso(jDate).N;
                valueToMatch = datenum(yy1,mm1,dd1,23,59,59);
                % Find the closest value.
                [~, indexAtEnd23rs] = min(abs(x - valueToMatch));
                clear valueToMatch
                
                    if indexAtStart23rs == indexAtEnd23rs   %% Peggy 30.07.2021
                        valueToMatch = datenum(yy1,mm1,dd1+1,01,30,00);
                        % Find the closest value.
                        [~, indexAtEnd23rs] = min(abs(x - valueToMatch));
                        clear valueToMatch
                    end
                
                
                     contourf(Cloudnet_short(xDate).N(indexAtStart:indexAtEnd),Cloudnet_short(xDate).height(1:size(Cloudnet_short(xDate).Z,1),1)*1e-3,Cloudnet_short(xDate).Z(:,indexAtStart:indexAtEnd),reso,'LineColor','none');
                     %contourf(Cloudnet_short(xDate).N,Cloudnet_short(xDate).height*1e-3,Cloudnet_short(xDate).Z,reso,'LineColor','none');
                     h(1)=line(Nbefore_vec,Cloudnet_short(xDate).height*1e-3,'Color','k','LineWidth',1.0);
                     hold on;
                     h(2)=line(Raso(jDate).N(indexAtStart23rs:indexAtEnd23rs),Raso(jDate).alt(indexAtStart23rs:indexAtEnd23rs)*1e-3,'Color',cm(2,:),'DisplayName',strxcat('Raso'),'LineWidth',1.0);
                     hold on;
                     h(3)=line(Nafter_vec,Cloudnet_short(xDate).height*1e-3,'Color','k','LineWidth',1.0);
                     hold on;
                     ylabel('Height in km','FontSize',fs);
                     hold on;
                     xlabel('Time in UTC','FontSize',fs);
                     ylim([0 hmax]);
                     xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy2,mm2,dd2,timeEnd,15,0)]);
                     datetick('x',15,'keeplimits');
                     set(gca,'FontSize',fs)

                     %Raso verlauf nach Mitternacht
                         x = Raso(jDate).N;
                         [yyx, mmx, ddx, HHx, MMx, SSx]=datevec(x(1));
                         if ddx < dd1
                         valueToMatch = datenum(yy1,mm1,dd1,1,15,0);
                         % Find the closest value.
                         [~, indexAtEnd24] = min(abs(x - valueToMatch));
                         clear valueToMatch
                         
                         indexAtStart24=indexAtEnd23rs-1; % Peggy 21.7.2021 change indexAtEnd23 + 1 to indeAtEnd23 - 1
                    %      t=([datenum(yy2,mm2,dd2,0,0,1) datenum(yy2,mm2,dd2,1,0,0)])
                    %      datevec(t)
                         
                         else
                         valueToMatch = datenum(yy1,mm1,dd1,1,15,0);
                         % Find the closest value.
                         [~, indexAtEnd24] = min(abs(x - valueToMatch));
                         clear valueToMatch
                         indexAtStart24 = 1;
                         end 
                         
                          if indexAtEnd24 == indexAtStart23rs   %% Peggy 30.07.2021
                             valueToMatch = datenum(yy1,mm1,dd1+1,01,30,00);
                             % Find the closest value.
                             [~, indexAtEnd24] = min(abs(x - valueToMatch));
                             clear valueToMatch
                          end
                         
                     [yy3, mm3, dd3, HH3, MM3, SS3]=datevec(Raso(jDate).N(indexAtStart24:indexAtEnd24));
                      dd4=dd3+1;
                      t=datenum([yy3 mm3 dd4 HH3 MM3 SS3]);

                      h(4)=line(t,Raso(jDate).alt(indexAtStart24:indexAtEnd24)*1e-3,'Color',cm(2,:),'DisplayName',strxcat('Raso'),'LineWidth',1.0);

                elseif (timeStart<23) 

                     contourf(Cloudnet_short(xDate).N(indexAtStart:indexAtEnd),Cloudnet_short(xDate).height(1:size(Cloudnet_short(xDate).Z,1),1)*1e-3,Cloudnet_short(xDate).Z(:,indexAtStart:indexAtEnd),reso,'LineColor','none');
                     %contourf(Cloudnet_short(xDate).N,Cloudnet_short(xDate).height*1e-3,Cloudnet_short(xDate).Z,reso,'LineColor','none');
                     h(1)=line(Nbefore_vec,Cloudnet_short(xDate).height*1e-3,'Color','k','LineWidth',1.0);
                     hold on;
                     h(2)=line(Raso(jDate).N,Raso(jDate).alt*1e-3,'Color',cm(2,:),'DisplayName',strxcat('Raso'),'LineWidth',1.0);
                     hold on;
                     h(3)=line(Nafter_vec,Cloudnet_short(xDate).height*1e-3,'Color','k','LineWidth',1.0);
                     hold on;
                     ylabel('Height (km)','FontSize',fs);
                     hold on;
                     xlabel('Time (UTC)','FontSize',fs);
                     ylim([0 hmax]);
                     xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1,timeEnd,15,0)]);
                     datetick('x',15,'keeplimits');
                     set(gca,'FontSize',fs)
               end


            %Plot red lines in reflectivity:
                    for k=1:layer_anzahl(jDate)

                        mu=Cloudnet_short(xDate).height(indexAtTopNoCloud(k))*1e-3;
                        hline = refline([0 mu]);
                        hline.Color = 'r'; clear mu

                        mu=Cloudnet_short(xDate).height(indexAtBottomNoCloud(k))*1e-3;
                        hline = refline([0 mu]);
                        hline.Color = 'r'; clear mu                  

                        t = (muk(k)+muk2(k))/2;
                        txt = {(layer_anzahl(jDate)+1-k)};
                        text([datenum(yy1,mm1,dd1,(timeStart-1),45,0)],t,txt,'FontSize',fs)

                    end
                        mu=MLC_classification(xDate).cloudtop(end)*1e-3;
                        hline = refline([0 mu]);
                        hline.Color = 'b'; clear mu  
                        
                    %grey subsaturated layers:
                    if exist('muk2') == 1
                        for j=1:length(muk2)
                            if timeStart==23
                                rectangle('Position',[datenum(yy1,mm1,dd1,(timeStart-1),29,0) muk2(j) datenum(yy2,mm2,dd2,timeEnd,30,0) muk(j)-muk2(j)],'EdgeColor','none','Facecolor', greyt)
                            else
                                rectangle('Position',[datenum(yy1,mm1,dd1,(timeStart-1),29,0) muk2(j) datenum(yy1,mm1,dd1,timeEnd,30,0) muk(j)-muk2(j)],'EdgeColor','none','Facecolor', greyt) %oben
                            end
                        end
                    end

            %Label b) in plot:
            dim = [.420 .10 .09 .07]; %dim = [.245 .10 .09 .07];
            str = 'b)';
            annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor','none','LineStyle','none','FontSize',fs);


            %h2=legend([h(2)],'Radiosounding','Location','northoutside');
            %set(h2,'FontSize',7);
            %set(gca,'FontSize',7);
            grid on;
            
            %Settings for both plots:
%%
            %ax(1)=subplot(1,2,1);
            ax(3)=subplot(1,3,2);

            %c=colorbar('EastOutside');
            % Create colorbar
            c = colorbar(ax(3),'Position',[0.65 0.101190476190476 0.0162326388888888 0.815476190476191]);
            c.Label.String = 'Z in dBZ';
            caxis([-40 +20]);
            hold on; 

%                      for ij=1:2
%                      pos=get(ax(ij), 'Position');
%                      set(ax(ij), 'Position', [-0.05+pos(1) pos(2) pos(3)*0.8 pos(4)]);
%                      end
% 
%             ij=1;
%             pos=get(ax(ij), 'Position');
%             set(ax(ij), 'Position', [pos(1)+0.08 pos(2) pos(3) pos(4)]);
% 
%                 %for time labels:
% 
%                     if timeStart==23
%                         xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1+1,timeEnd,15,1)]);
%                         datetick('x',15);
%                         xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1+1,timeEnd,15,1)]);
% 
%                     else
%                         xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1,timeEnd,15,1)]);
%                         datetick('x',15);
%                         xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1,timeEnd,15,1)]);
%                     end

            %Save Plot: 

            mkdir('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/Plots',strxcat('7_Sectionlines_',name)); 
            fig = gcf;
            fig.PaperPositionMode = 'auto';
            fig.PaperSize =  [25.0 15.5];
            saveas(gcf,strxcat('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/Plots/7_Sectionlines_',name,'/',datestr(Cloudnet_short(xDate).N(1),'yyyy-mm-dd-HH-MM-SS'),'.png')); 
            print(gcf,'-dpdf', '-fillpage', '-r300', '-vector', strxcat('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/Plots/7_Sectionlines_',name,'/',datestr(Cloudnet_short(xDate).N(1),'yyyy-mm-dd-HH-MM-SS')')); 
 %%              
            else %end
            %%
            %if numcloud(xDate)==1    %only 1 cloudlayer    
                numcloud(xDate)
                datestr(datevec(Nbefore))
                datestr(datevec(Nafter))
            %Black lines indicating time in plot: Find time beginn and time end
            %Nbefore and Nafter taken from Cloudnet_4_preparation_adv

            [Nbefore_vec,~] = meshgrid(Nbefore',Cloudnet_short(xDate).height');
            [Nafter_vec,~] = meshgrid(Nafter',Cloudnet_short(xDate).height');

            %%
            reso=20;                       %Plot-Color-Resolution
            %Plot Reflectivity:
            [yy1, mm1, dd1]=datevec(Cloudnet_short(xDate).N(1));
            if timeStart==23
             [yy2, mm2, dd2]=datevec(Cloudnet_short(xDate).N(1)+1);
            end

            %%
            gcf = figure; set(gcf, 'Visible', 'off');

            %set(gcf,'units','normalized','position',[.5 .15 .30 .700]);

            %First plot: Raso
            ax(1)=subplot(1,3,1);
            hAx(1) = gca;
            p1=plot(Raso(jDate).RHl,Raso(jDate).alt*1e-3,'LineWidth',1.25,'DisplayName','RH liquid','Color',cm(1,:));
            p2=line(Raso(jDate).RHi,Raso(jDate).alt*1e-3,'LineWidth',1.25,'DisplayName','RH ice','Color',cm(2,:));
            grayColor = [.7 .7 .7];
            xline(100,'--','Color', grayColor)
            xline(100)
            ylim([0 hmax]);
            %ylim([0 hmax]);
            xlim([0 150]);
            ax(2)=gca;
            ylabel('Height (km)','FontSize',fs);
            xlabel('RH (%)','FontSize',fs);
            set(gca,'FontSize',fs)
            box off
            hAx(2)=axes('Position',hAx(1).Position,'XAxisLocation','top','YAxisLocation','right','color','none');
            hold(hAx(2),'on')
            p3=line(Raso(jDate).tempK-273.15,Raso(jDate).alt*1e-3,'LineWidth',1.25,'DisplayName','T ','Color',cm(7,:));
            xlim([-80 10]);
            ylim([0 hmax]);
            xlabel('Temperature [^{\circ} C] ','FontSize',fs,'Color',cm(5,:))     
            %legend([p1; p2; p3],{'RH liquid','RH ice','T'},'NumColumns',2); %'Location','northoutside',
            %set(h,'FontSize',fs);
            set(gca,'xcolor',cm(7,:))   
            set(gca,'YTickLabel',[]);
            grid on;
           % Create textbox
           cl = {'b', 'r', 'g'};
           annotation(gcf,'textbox',...
           [0.69 0.58452380952381 0.0693125 0.102380952380953],...
            'String','RH  liquid','Color',cm(1,:),'Interpreter','latex','FitBoxToText','on','LineStyle','none','FontSize',10);
           annotation(gcf,'textbox',...
           [0.69 0.58452380952381 0.0693125 0.071380952380953],...
            'String','RH  ice','Color',cm(2,:),'Interpreter','latex','FitBoxToText','on','LineStyle','none','FontSize',10);           
           annotation(gcf,'textbox',...
           [0.69 0.58452380952381 0.0693125 0.032380952380953],...
            'String','T','Color',cm(7,:),'Interpreter','latex','FitBoxToText','on','LineStyle','none','FontSize',10);
           set(gca,'FontSize',fs)

%              % %Plotting red horisontal lines 
%              for k=1:layer_anzahl(jDate)                                                  
%                  mu=Cloudnet_short(xDate).height(indexAtTopNoCloud(k))*1e-3;
%                  hline = refline([0 mu]);
%                  hline.Color = 'r';
% % 
%                  mu=Cloudnet_short(xDate).height(indexAtBottomNoCloud(k))*1e-3;
%                  hline = refline([0 mu]);
%                  hline.Color = 'r';
% % 
%              end


%             %for grey transparent boxes:
%             greyt =[0.702 0.702 0.702 0.3];                          %transparent grey color
%             for k=1:layer_anzahl(jDate)
% 
%                 mu=Cloudnet_short(xDate).height(indexAtTopNoCloud(k))*1e-3;
%                 muk(k)=mu;
% 
%                 mu=Cloudnet_short(xDate).height(indexAtBottomNoCloud(k))*1e-3;
%                 muk2(k)=mu;
% 
%                 t = (muk(k)+muk2(k))/2;
% 
%                 txt = {(layer_anzahl(jDate)+1-k)};
%                 text(140,t,txt,'FontSize',fs)
% 
%             end
% 
%             %für subsaturated layers = grey
%             for j=1:length(muk2)
%                 rectangle('Position',[0 muk2(j) 150 muk(j)-muk2(j)],'EdgeColor','none','Facecolor', greyt)
%             end

            %Make label a) in plot
            str = 'a)';
            dim = [.165 .09 .03 .07];
            annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor','none','LineStyle','none','FontSize',fs);


            %%
            %Name the subsaturated layers by numbers
            %disp('careful, please check numbers');

            %% Second plot part: reflectivity
            ax(3)=subplot(1,3,2);
                                     
              if (timeStart==23) 

            %       indexAtStart23=indexAtStart
            %       indexAtEnd23=indexAtEnd1-10
                x = Raso(jDate).N;
                valueToMatch = datenum(yy1,mm1,dd1,timeStart,00,00);
                % Find the closest value.
                [~, indexAtStart23rs] = min(abs(x - valueToMatch)); 
                clear valueToMatch

                %for limiting height where we look for multi-layer clouds:
                x = Raso(jDate).N;
                valueToMatch = datenum(yy1,mm1,dd1,23,59,59);
                % Find the closest value.
                [~, indexAtEnd23rs] = min(abs(x - valueToMatch));
                clear valueToMatch
                
                    if indexAtStart23rs == indexAtEnd23rs   %% Peggy 30.07.2021
                        valueToMatch = datenum(yy1,mm1,dd1+1,01,30,00);
                        % Find the closest value.
                        [~, indexAtEnd23rs] = min(abs(x - valueToMatch));
                        clear valueToMatch
                    end
                
                
                     contourf(Cloudnet_short(xDate).N(indexAtStart:indexAtEnd),Cloudnet_short(xDate).height(1:size(Cloudnet_short(xDate).Z,1),1)*1e-3,Cloudnet_short(xDate).Z(:,indexAtStart:indexAtEnd),reso,'LineColor','none');
                     %contourf(Cloudnet_short(xDate).N,Cloudnet_short(xDate).height*1e-3,Cloudnet_short(xDate).Z,reso,'LineColor','none');
                     h(1)=line(Nbefore_vec,Cloudnet_short(xDate).height*1e-3,'Color','k','LineWidth',1.0);
                     hold on;
                     h(2)=line(Raso(jDate).N(indexAtStart23rs:indexAtEnd23rs),Raso(jDate).alt(indexAtStart23rs:indexAtEnd23rs)*1e-3,'Color',cm(2,:),'DisplayName',strxcat('Raso'),'LineWidth',1.0);
                     hold on;
                     h(3)=line(Nafter_vec,Cloudnet_short(xDate).height*1e-3,'Color','k','LineWidth',1.0);
                     hold on;
                     ylabel('Height (km)','FontSize',fs);
                     hold on;
                     xlabel('Time (UTC)','FontSize',fs);
                     ylim([0 hmax]);
                     xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy2,mm2,dd2,timeEnd,30,0)]);
                     datetick('x',15,'keeplimits');
                     set(gca,'FontSize',fs)

                      %Raso verlauf nach Mitternacht
                          x = Raso(jDate).N;
                          valueToMatch = datenum(yy1,mm1,dd1,23,59,59);
                          % Find the closest value.
                          [~, indexAtEnd24] = min(abs(x - valueToMatch));
                          clear valueToMatch
%                          
                          if indexAtEnd24 == indexAtEnd23rs   %% Peggy 30.07.2021
                             valueToMatch = datenum(yy1,mm1,dd1+1,01,30,00);
                             % Find the closest value.
                             [~, AtEnd24] = min(abs(x - valueToMatch));
                             clear valueToMatch
                             indexAtEnd23rs = AtEnd24;
                          end
                          
                 %     indexAtStart24=indexAtEnd23rs+1; % Peggy 21.7.2021 change indexAtEnd23 + 1 to indeAtEnd23 - 1
                 %      t=([datenum(yy2,mm2,dd2,0,0,1) datenum(yy2,mm2,dd2,1,0,0)])
                 %      datevec(t)
                      [yy3, mm3, dd3, HH3, MM3, SS3]=datevec(Raso(jDate).N(indexAtStart23rs:indexAtEnd23rs));
                      dd4=dd3+1;
                      t=datenum([yy3 mm3 dd4 HH3 MM3 SS3]);
 
                      h(4)=line(t,Raso(jDate).alt(indexAtStart23rs:indexAtEnd23rs)*1e-3,'Color',cm(2,:),'DisplayName',strxcat('Raso'),'LineWidth',1.0);

                elseif (timeStart<23) 

                     contourf(Cloudnet_short(xDate).N(indexAtStart:indexAtEnd),Cloudnet_short(xDate).height(1:size(Cloudnet_short(xDate).Z,1),1)*1e-3,Cloudnet_short(xDate).Z(:,indexAtStart:indexAtEnd),reso,'LineColor','none');
                     %contourf(Cloudnet_short(xDate).N,Cloudnet_short(xDate).height*1e-3,Cloudnet_short(xDate).Z,reso,'LineColor','none');
                     h(1)=line(Nbefore_vec,Cloudnet_short(xDate).height*1e-3,'Color','k','LineWidth',1.0);
                     hold on;
                     h(2)=line(Raso(jDate).N,Raso(jDate).alt*1e-3,'Color',cm(2,:),'DisplayName',strxcat('Raso'),'LineWidth',1.0);
                     hold on;
                     h(3)=line(Nafter_vec,Cloudnet_short(xDate).height*1e-3,'Color','k','LineWidth',1.0);
                     hold on;
                     ylabel('Height in km','FontSize',fs);
                     hold on;
                     xlabel('Time in UTC','FontSize',fs);
                     ylim([0 hmax]);
                     xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1,timeEnd,30,0)]);
                     datetick('x',15,'keeplimits');
                     set(gca,'FontSize',fs)
              end
              
              if numcloud(xDate) == 1
                        mu=MLC_classification(xDate).cloudtop(end)*1e-3;
                        hline = refline([0 mu]);
                        hline.Color = 'b'; clear mu 
              end

%             %Plot red lines in reflectivity:
%                     for k=1:layer_anzahl(jDate)
% 
%                         mu=Cloudnet_short(xDate).height(indexAtTopNoCloud(k))*1e-3;
%                         hline = refline([0 mu]);
%                         hline.Color = 'r';
% 
%                         mu=Cloudnet_short(xDate).height(indexAtBottomNoCloud(k))*1e-3;
%                         hline = refline([0 mu]);
%                         hline.Color = 'r';
% 
%                         t = (muk(k)+muk2(k))/2;
%                         txt = {(layer_anzahl(jDate)+1-k)};
%                         text([datenum(yy1,mm1,dd1,(timeStart-1),45,0)],t,txt,'FontSize',fs)
% 
%                     end
% 
%                     %grey subsaturated layers:
%                     for j=1:length(muk2)
%                         if timeStart==23
%                             rectangle('Position',[datenum(yy1,mm1,dd1,(timeStart-1),29,0) muk2(j) datenum(yy2,mm2,dd2,timeEnd,30,0) muk(j)-muk2(j)],'EdgeColor','none','Facecolor', greyt)
%                         else
%                             rectangle('Position',[datenum(yy1,mm1,dd1,(timeStart-1),29,0) muk2(j) datenum(yy1,mm1,dd1,timeEnd,30,0) muk(j)-muk2(j)],'EdgeColor','none','Facecolor', greyt) %oben
%                         end
%                     end

            %Label b) in plot:
            dim = [.525 .09 .03 .07];
            str = 'b)';
            annotation('textbox',dim,'String',str,'FitBoxToText','on','BackgroundColor','none','LineStyle','none','FontSize',fs);


            %h2=legend([h(2)],'Radiosounding','Location','northoutside');
            %set(h2,'FontSize',7);
            %set(gca,'FontSize',7);
            grid on;
            %%
            %Settings for both plots:

            %ax(1)=subplot(1,3,1);
            %ax(3)=subplot(1,3,2);

            c = colorbar(ax(3),'Position',[0.65 0.101190476190476 0.0162326388888888 0.815476190476191]);
            c.Label.String = 'Z in dBZ';
            clim([-40 +20]);
            hold on; 

%                     for ij=1:2
%                     pos=get(ax(ij), 'Position');
%                     set(ax(ij), 'Position', [-0.05+pos(1) pos(2) pos(3)*0.8 pos(4)]);
%                     end
% 
%             ij=1;
%             pos=get(ax(ij), 'Position');
%             set(ax(ij), 'Position', [pos(1)+0.08 pos(2) pos(3) pos(4)]);
% 
%                 %for time labels:
% 
%                     if timeStart==23
%                         xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1+1,timeEnd,30,1)]);
%                         datetick('x',15);
%                         xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1+1,timeEnd,30,1)]);
% 
%                     else
%                         xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1,timeEnd,30,1)]);
%                         datetick('x',15);
%                         xlim([datenum(yy1,mm1,dd1,(timeStart-1),29,0) datenum(yy1,mm1,dd1,timeEnd,30,1)]);
%                     end



            %%
            %Save Plot: 

            mkdir('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/Plots',strxcat('7_Sectionlines_',name)); 
            fig = gcf;
            fig.PaperPositionMode = 'auto';
            fig.PaperSize =  [25.0 15.5];
            saveas(gcf,strxcat('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/Plots/7_Sectionlines_',name,'/',datestr(Cloudnet_short(xDate).N(1),'yyyy-mm-dd-HH-MM-SS'),'.png')); 
            print(gcf,'-dpdf', '-fillpage', '-r300', '-vector', strxcat('/projekt6/aerocloud/Mamip_projekt/Mosaic/Output/Plots/7_Sectionlines_',name,'/',datestr(Cloudnet_short(xDate).N(1),'yyyy-mm-dd-HH-MM-SS'),'.pdf')); 
            
%end
            end
        end
    end
end

%%

  clear h ax ax1 ax2 ax3 cloud cloudZ cloudZmean40 cloudZmean402 cloudZmeanhalf cloudZmeanhalf2 h h1 ...
      height helpcloud hh hline indexAtMin minDifferenceValue minu mu Nafter_new Nansum ...
      pos h2 Nansum_cloud Nansumnot Nansumnot_cloud Nbefore_new nocloud nocloudZ nocloudZmean40 ...
      nocloudZmean402 nocloudZmeanhalf nocloudZmeanhalf2 pos1 reso valueToMatch ZnN x sek mm dd yy yy1 ...
      mm1 dd1 ab ac c Nafter Nafter_vec Nbefore Nbefore_vec Y22 kminus layers1 kminus1 ...
      indexAtBottomNoCloud1 indexAtTopNoCloud1 filename mu muk muk2 j ij indexAt1234 dim greyt ...
      Nafter_more Nbefore_more str str_layer xt yt indexAtEnd_more indexAtStart_more fs fig...
      indexAtTopNoCloud indexAtBottomNoCloud p1 p2 p3 gcf greyt P1
% %     
    