
  if xDate == yDate        %erster Aufstieg am Tag
      firstRaso = datevec(Raso(1).N(1));
      firstRasohour = firstRaso(4);
    clear timeStart timeEnd
    timeStart=firstRasohour; timeEnd=firstRasohour+2;
    [yy, mm, dd]=datevec(Cloudnet(1).N(1));
   
    %for limiting height where we look for multi-layer clouds:
    x = Cloudnet(1).N;
    valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
    % Find the closest value.
    [~, indexAtStart] = min(abs(x - valueToMatch));

    %for limiting height where we look for multi-layer clouds:
    x = Cloudnet(1).N;
    valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
    % Find the closest value.
    [~, indexAtEnd] = min(abs(x - valueToMatch));
%    clear timeStart timeEnd
     clear minDifferenceValue x
    
    Cloudnet_short(xDate).number=Cloudnet(1).number;
    Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
    Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
    Cloudnet_short(xDate).height=Cloudnet(1).height(:);
    Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
    Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
    %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
    %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
    Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
    Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);
    
    %Cloudnet_short = Cloudnet_short(~cellfun(@isempty,{Cloudnet_short.number}));
    
    elseif xDate == yDate+1    
        secondRaso = datevec(Raso(2).N(1));
        secondRasohour = secondRaso(4);
        clear timeStart timeEnd
        timeStart=secondRasohour; timeEnd=secondRasohour+2;
        [yy, mm, dd]=datevec(Cloudnet(1).N(1));

        %for limiting height where we look for multi-layer clouds:
        x = Cloudnet(1).N;
        valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
        % Find the closest value.
        [~, indexAtStart] = min(abs(x - valueToMatch));

        %for limiting height where we look for multi-layer clouds:
        x = Cloudnet(1).N;
        valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
        % Find the closest value.
        [~, indexAtEnd] = min(abs(x - valueToMatch));
    %     clear timeStart timeEnd 
        clear minDifferenceValue x

        Cloudnet_short(xDate).number=Cloudnet(1).number;
        Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
        Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
        Cloudnet_short(xDate).height=Cloudnet(1).height(:);
        Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
        Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
        %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
        %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
        Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
        Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);
    
    elseif xDate == yDate+2
        thirdRaso = datevec(Raso(3).N(1));
        thirdRasohour = thirdRaso(4);
        clear timeStart timeEnd
        timeStart=thirdRasohour; timeEnd=thirdRasohour +2;
        [yy, mm, dd]=datevec(Cloudnet(1).N(1));

        %for limiting height where we look for multi-layer clouds:
        x = Cloudnet(1).N;
        valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
        % Find the closest value.
        [~, indexAtStart] = min(abs(x - valueToMatch));

        %for limiting height where we look for multi-layer clouds:
        x = Cloudnet(1).N;
        valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
        % Find the closest value.
        [~, indexAtEnd] = min(abs(x - valueToMatch));

        Cloudnet_short(xDate).number=Cloudnet(1).number;
        Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
        Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
        Cloudnet_short(xDate).height=Cloudnet(1).height(:);
        Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
        Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
        %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
        %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
        Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
        Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);

  elseif xDate == yDate+3
    fourRaso = datevec(Raso(4).N(1));
    fourRasohour = fourRaso(4);
         if fourRasohour == 23
            clear timeStart timeEnd
            timeStart=23; timeEnd=23;

            [yy, mm, dd]=datevec(Cloudnet(1).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
            % Find the closest value.
            [~, indexAtStart1] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,59,59);
            % Find the closest value.
            [~, indexAtEnd1] = min(abs(x - valueToMatch));

            clear timeStart timeEnd 
            clear minDifferenceValue x valueToMatch

            timeStart=0; timeEnd=1;
            [yy, mm, dd]=datevec(Cloudnet(2).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
            % Find the closest value.
            [~, indexAtStart2] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
            % Find the closest value.
            [~, indexAtEnd2] = min(abs(x - valueToMatch));

            clear timeStart timeEnd minDifferenceValue x

            try

            Cloudnet_short(xDate).number=Cloudnet(1).number;
            Cloudnet_short(xDate).N=[Cloudnet(1).N(indexAtStart1:indexAtEnd1);Cloudnet(2).N(indexAtStart2:indexAtEnd2)]; 
            Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart1));
            Cloudnet_short(xDate).height=Cloudnet(1).height(:);
            Cloudnet_short(xDate).Z=[Cloudnet(1).Z(:,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).Zsens=[Cloudnet(1).Zsens];
            %Cloudnet_short(xDate).beta=[Cloudnet(1).beta(:,indexAtStart1:indexAtEnd1),Cloudnet(2).beta(:,indexAtStart2:indexAtEnd2)];
            %Cloudnet_short(xDate).gasatten=[Cloudnet(1).gasatten(:,indexAtStart1:indexAtEnd1),Cloudnet(2).gasatten(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).v=[Cloudnet(1).v(:,indexAtStart1:indexAtEnd1),Cloudnet(2).v(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).width=[Cloudnet(1).width(:,indexAtStart1:indexAtEnd1),Cloudnet(2).width(:,indexAtStart2:indexAtEnd2)];

            catch

            x1 = Cloudnet(1).height;
            valueToMatch1 = 10000;
            [minDifferenceValue1, indexEnd1] = min(abs(x1 - valueToMatch1));
            x2 = Cloudnet(2).height;
            valueToMatch2 = 10000;
            [minDifferenceValue2, indexEnd2] = min(abs(x2 - valueToMatch2));

            if indexEnd1<indexEnd2        
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd1,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd1,indexAtStart2:indexAtEnd2)];   
            elseif indexEnd1>indexEnd2
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd2,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd2,indexAtStart2:indexAtEnd2)];
            end
            end

            timeStart=23;
            timeEnd=1;
        else
            timeStart=fourRasohour; timeEnd=fourRasohour+2;
            clear timeStart timeEnd
            timeStart=fourRasohour; timeEnd=fourRasohour +2;
            [yy, mm, dd]=datevec(Cloudnet(1).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
            % Find the closest value.
            [~, indexAtStart] = min(abs(x - valueToMatch));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
            % Find the closest value.
            [~, indexAtEnd] = min(abs(x - valueToMatch));

            Cloudnet_short(xDate).number=Cloudnet(1).number;
            Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
            Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
            Cloudnet_short(xDate).height=Cloudnet(1).height(:);
            Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
            Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
            %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
            %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
            Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
            Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);
        end
    %%
    elseif xDate == yDate+4
        fiveRaso = datevec(Raso(5).N(1));
        fiveRasohour = fiveRaso(4);
         if fiveRasohour == 23
            clear timeStart timeEnd
            timeStart=23; timeEnd=23;

            [yy, mm, dd]=datevec(Cloudnet(1).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
            % Find the closest value.
            [~, indexAtStart1] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,59,59);
            % Find the closest value.
            [~, indexAtEnd1] = min(abs(x - valueToMatch));

            clear timeStart timeEnd 
            clear minDifferenceValue x valueToMatch

            timeStart=0; timeEnd=1;
            [yy, mm, dd]=datevec(Cloudnet(2).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
            % Find the closest value.
            [~, indexAtStart2] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
            % Find the closest value.
            [~, indexAtEnd2] = min(abs(x - valueToMatch));

            clear timeStart timeEnd minDifferenceValue x

            try

            Cloudnet_short(xDate).number=Cloudnet(1).number;
            Cloudnet_short(xDate).N=[Cloudnet(1).N(indexAtStart1:indexAtEnd1);Cloudnet(2).N(indexAtStart2:indexAtEnd2)]; 
            Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart1));
            Cloudnet_short(xDate).height=Cloudnet(1).height(:);
            Cloudnet_short(xDate).Z=[Cloudnet(1).Z(:,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).Zsens=[Cloudnet(1).Zsens];
            %Cloudnet_short(xDate).beta=[Cloudnet(1).beta(:,indexAtStart1:indexAtEnd1),Cloudnet(2).beta(:,indexAtStart2:indexAtEnd2)];
            %Cloudnet_short(xDate).gasatten=[Cloudnet(1).gasatten(:,indexAtStart1:indexAtEnd1),Cloudnet(2).gasatten(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).v=[Cloudnet(1).v(:,indexAtStart1:indexAtEnd1),Cloudnet(2).v(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).width=[Cloudnet(1).width(:,indexAtStart1:indexAtEnd1),Cloudnet(2).width(:,indexAtStart2:indexAtEnd2)];

            catch

            x1 = Cloudnet(1).height;
            valueToMatch1 = 10000;
            [minDifferenceValue1, indexEnd1] = min(abs(x1 - valueToMatch1));
            x2 = Cloudnet(2).height;
            valueToMatch2 = 10000;
            [minDifferenceValue2, indexEnd2] = min(abs(x2 - valueToMatch2));

            if indexEnd1<indexEnd2        
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd1,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd1,indexAtStart2:indexAtEnd2)];   
            elseif indexEnd1>indexEnd2
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd2,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd2,indexAtStart2:indexAtEnd2)];
            end
            end

            timeStart=23;
            timeEnd=1;
                else
                timeStart=fiveRasohour; timeEnd=fiveRasohour+2;
                clear timeStart timeEnd
                timeStart=fiveRasohour; timeEnd=fiveRasohour +2;
                [yy, mm, dd]=datevec(Cloudnet(1).N(1));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
                % Find the closest value.
                [~, indexAtStart] = min(abs(x - valueToMatch));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
                % Find the closest value.
                [~, indexAtEnd] = min(abs(x - valueToMatch));

                Cloudnet_short(xDate).number=Cloudnet(1).number;
                Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
                Cloudnet_short(xDate).height=Cloudnet(1).height(:);
                Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
                Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
                %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
                %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);
         end
  %%
      elseif xDate == yDate+5
        sixRaso = datevec(Raso(6).N(1));
        sixRasohour = sixRaso(4);
         if sixRasohour == 23
            clear timeStart timeEnd
            timeStart=23; timeEnd=23;

            [yy, mm, dd]=datevec(Cloudnet(1).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
            % Find the closest value.
            [~, indexAtStart1] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,59,59);
            % Find the closest value.
            [~, indexAtEnd1] = min(abs(x - valueToMatch));

            clear timeStart timeEnd 
            clear minDifferenceValue x valueToMatch

            timeStart=0; timeEnd=1;
            [yy, mm, dd]=datevec(Cloudnet(2).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
            % Find the closest value.
            [~, indexAtStart2] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
            % Find the closest value.
            [~, indexAtEnd2] = min(abs(x - valueToMatch));

            clear timeStart timeEnd minDifferenceValue x

            try

            Cloudnet_short(xDate).number=Cloudnet(1).number;
            Cloudnet_short(xDate).N=[Cloudnet(1).N(indexAtStart1:indexAtEnd1);Cloudnet(2).N(indexAtStart2:indexAtEnd2)]; 
            Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart1));
            Cloudnet_short(xDate).height=Cloudnet(1).height(:);
            Cloudnet_short(xDate).Z=[Cloudnet(1).Z(:,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).Zsens=[Cloudnet(1).Zsens];
            %Cloudnet_short(xDate).beta=[Cloudnet(1).beta(:,indexAtStart1:indexAtEnd1),Cloudnet(2).beta(:,indexAtStart2:indexAtEnd2)];
            %Cloudnet_short(xDate).gasatten=[Cloudnet(1).gasatten(:,indexAtStart1:indexAtEnd1),Cloudnet(2).gasatten(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).v=[Cloudnet(1).v(:,indexAtStart1:indexAtEnd1),Cloudnet(2).v(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).width=[Cloudnet(1).width(:,indexAtStart1:indexAtEnd1),Cloudnet(2).width(:,indexAtStart2:indexAtEnd2)];

            catch

            x1 = Cloudnet(1).height;
            valueToMatch1 = 10000;
            [minDifferenceValue1, indexEnd1] = min(abs(x1 - valueToMatch1));
            x2 = Cloudnet(2).height;
            valueToMatch2 = 10000;
            [minDifferenceValue2, indexEnd2] = min(abs(x2 - valueToMatch2));

            if indexEnd1<indexEnd2        
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd1,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd1,indexAtStart2:indexAtEnd2)];   
            elseif indexEnd1>indexEnd2
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd2,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd2,indexAtStart2:indexAtEnd2)];
            end
            end

            timeStart=23;
            timeEnd=1;
                else
                timeStart=sixRasohour; timeEnd=sixRasohour+2;
                clear timeStart timeEnd
                timeStart=sixRasohour; timeEnd=sixRasohour +2;
                [yy, mm, dd]=datevec(Cloudnet(1).N(1));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
                % Find the closest value.
                [~, indexAtStart] = min(abs(x - valueToMatch));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
                % Find the closest value.
                [~, indexAtEnd] = min(abs(x - valueToMatch));

                Cloudnet_short(xDate).number=Cloudnet(1).number;
                Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
                Cloudnet_short(xDate).height=Cloudnet(1).height(:);
                Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
                Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
                %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
                %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);
         end
         %%
      elseif xDate == yDate+6
        sevenRaso = datevec(Raso(7).N(1));
        sevenRasohour = sevenRaso(4);
         if sevenRasohour == 23
            clear timeStart timeEnd
            timeStart=23; timeEnd=23;

            [yy, mm, dd]=datevec(Cloudnet(1).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
            % Find the closest value.
            [~, indexAtStart1] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,59,59);
            % Find the closest value.
            [~, indexAtEnd1] = min(abs(x - valueToMatch));

            clear timeStart timeEnd 
            clear minDifferenceValue x valueToMatch

            timeStart=0; timeEnd=1;
            [yy, mm, dd]=datevec(Cloudnet(2).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
            % Find the closest value.
            [~, indexAtStart2] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
            % Find the closest value.
            [~, indexAtEnd2] = min(abs(x - valueToMatch));

            clear timeStart timeEnd minDifferenceValue x

            try

            Cloudnet_short(xDate).number=Cloudnet(1).number;
            Cloudnet_short(xDate).N=[Cloudnet(1).N(indexAtStart1:indexAtEnd1);Cloudnet(2).N(indexAtStart2:indexAtEnd2)]; 
            Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart1));
            Cloudnet_short(xDate).height=Cloudnet(1).height(:);
            Cloudnet_short(xDate).Z=[Cloudnet(1).Z(:,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).Zsens=[Cloudnet(1).Zsens];
            %Cloudnet_short(xDate).beta=[Cloudnet(1).beta(:,indexAtStart1:indexAtEnd1),Cloudnet(2).beta(:,indexAtStart2:indexAtEnd2)];
            %Cloudnet_short(xDate).gasatten=[Cloudnet(1).gasatten(:,indexAtStart1:indexAtEnd1),Cloudnet(2).gasatten(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).v=[Cloudnet(1).v(:,indexAtStart1:indexAtEnd1),Cloudnet(2).v(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).width=[Cloudnet(1).width(:,indexAtStart1:indexAtEnd1),Cloudnet(2).width(:,indexAtStart2:indexAtEnd2)];

            catch

            x1 = Cloudnet(1).height;
            valueToMatch1 = 10000;
            [minDifferenceValue1, indexEnd1] = min(abs(x1 - valueToMatch1));
            x2 = Cloudnet(2).height;
            valueToMatch2 = 10000;
            [minDifferenceValue2, indexEnd2] = min(abs(x2 - valueToMatch2));

            if indexEnd1<indexEnd2        
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd1,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd1,indexAtStart2:indexAtEnd2)];   
            elseif indexEnd1>indexEnd2
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd2,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd2,indexAtStart2:indexAtEnd2)];
            end
            end

            timeStart=23;
            timeEnd=1;
                else
                timeStart=sevenRasohour; timeEnd=sevenRasohour+2;
                clear timeStart timeEnd
                timeStart=sevenRasohour; timeEnd=sevenRasohour +2;
                [yy, mm, dd]=datevec(Cloudnet(1).N(1));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
                % Find the closest value.
                [~, indexAtStart] = min(abs(x - valueToMatch));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
                % Find the closest value.
                [~, indexAtEnd] = min(abs(x - valueToMatch));

                Cloudnet_short(xDate).number=Cloudnet(1).number;
                Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
                Cloudnet_short(xDate).height=Cloudnet(1).height(:);
                Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
                Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
                %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
                %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);
         end
         elseif xDate == yDate+7
        eightRaso = datevec(Raso(8).N(1));
        eightRasohour = eightRaso(4);
         if eightRasohour == 23
            clear timeStart timeEnd
            timeStart=23; timeEnd=23;

            [yy, mm, dd]=datevec(Cloudnet(1).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
            % Find the closest value.
            [~, indexAtStart1] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,59,59);
            % Find the closest value.
            [~, indexAtEnd1] = min(abs(x - valueToMatch));

            clear timeStart timeEnd 
            clear minDifferenceValue x valueToMatch

            timeStart=0; timeEnd=1;
            [yy, mm, dd]=datevec(Cloudnet(2).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
            % Find the closest value.
            [~, indexAtStart2] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
            % Find the closest value.
            [~, indexAtEnd2] = min(abs(x - valueToMatch));

            clear timeStart timeEnd minDifferenceValue x

            try

            Cloudnet_short(xDate).number=Cloudnet(1).number;
            Cloudnet_short(xDate).N=[Cloudnet(1).N(indexAtStart1:indexAtEnd1);Cloudnet(2).N(indexAtStart2:indexAtEnd2)]; 
            Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart1));
            Cloudnet_short(xDate).height=Cloudnet(1).height(:);
            Cloudnet_short(xDate).Z=[Cloudnet(1).Z(:,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).Zsens=[Cloudnet(1).Zsens];
            %Cloudnet_short(xDate).beta=[Cloudnet(1).beta(:,indexAtStart1:indexAtEnd1),Cloudnet(2).beta(:,indexAtStart2:indexAtEnd2)];
            %Cloudnet_short(xDate).gasatten=[Cloudnet(1).gasatten(:,indexAtStart1:indexAtEnd1),Cloudnet(2).gasatten(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).v=[Cloudnet(1).v(:,indexAtStart1:indexAtEnd1),Cloudnet(2).v(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).width=[Cloudnet(1).width(:,indexAtStart1:indexAtEnd1),Cloudnet(2).width(:,indexAtStart2:indexAtEnd2)];

            catch

            x1 = Cloudnet(1).height;
            valueToMatch1 = 10000;
            [minDifferenceValue1, indexEnd1] = min(abs(x1 - valueToMatch1));
            x2 = Cloudnet(2).height;
            valueToMatch2 = 10000;
            [minDifferenceValue2, indexEnd2] = min(abs(x2 - valueToMatch2));

            if indexEnd1<indexEnd2        
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd1,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd1,indexAtStart2:indexAtEnd2)];   
            elseif indexEnd1>indexEnd2
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd2,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd2,indexAtStart2:indexAtEnd2)];
            end
            end

            timeStart=23;
            timeEnd=1;
                else
                timeStart=eightRasohour; timeEnd=eightRasohour+2;
                clear timeStart timeEnd
                timeStart=eightRasohour; timeEnd=eightRasohour +2;
                [yy, mm, dd]=datevec(Cloudnet(1).N(1));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
                % Find the closest value.
                [~, indexAtStart] = min(abs(x - valueToMatch));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
                % Find the closest value.
                [~, indexAtEnd] = min(abs(x - valueToMatch));

                Cloudnet_short(xDate).number=Cloudnet(1).number;
                Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
                Cloudnet_short(xDate).height=Cloudnet(1).height(:);
                Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
                Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
                %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
                %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);
         end
         %%
         elseif xDate == yDate+8
        nineRaso = datevec(Raso(9).N(1));
        nineRasohour = nineRaso(4);
         if eightRasohour == 23
            clear timeStart timeEnd
            timeStart=23; timeEnd=23;

            [yy, mm, dd]=datevec(Cloudnet(1).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
            % Find the closest value.
            [~, indexAtStart1] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,59,59);
            % Find the closest value.
            [~, indexAtEnd1] = min(abs(x - valueToMatch));

            clear timeStart timeEnd 
            clear minDifferenceValue x valueToMatch

            timeStart=0; timeEnd=1;
            [yy, mm, dd]=datevec(Cloudnet(2).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
            % Find the closest value.
            [~, indexAtStart2] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
            % Find the closest value.
            [~, indexAtEnd2] = min(abs(x - valueToMatch));

            clear timeStart timeEnd minDifferenceValue x

            try

            Cloudnet_short(xDate).number=Cloudnet(1).number;
            Cloudnet_short(xDate).N=[Cloudnet(1).N(indexAtStart1:indexAtEnd1);Cloudnet(2).N(indexAtStart2:indexAtEnd2)]; 
            Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart1));
            Cloudnet_short(xDate).height=Cloudnet(1).height(:);
            Cloudnet_short(xDate).Z=[Cloudnet(1).Z(:,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).Zsens=[Cloudnet(1).Zsens];
            %Cloudnet_short(xDate).beta=[Cloudnet(1).beta(:,indexAtStart1:indexAtEnd1),Cloudnet(2).beta(:,indexAtStart2:indexAtEnd2)];
            %Cloudnet_short(xDate).gasatten=[Cloudnet(1).gasatten(:,indexAtStart1:indexAtEnd1),Cloudnet(2).gasatten(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).v=[Cloudnet(1).v(:,indexAtStart1:indexAtEnd1),Cloudnet(2).v(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).width=[Cloudnet(1).width(:,indexAtStart1:indexAtEnd1),Cloudnet(2).width(:,indexAtStart2:indexAtEnd2)];

            catch

            x1 = Cloudnet(1).height;
            valueToMatch1 = 10000;
            [minDifferenceValue1, indexEnd1] = min(abs(x1 - valueToMatch1));
            x2 = Cloudnet(2).height;
            valueToMatch2 = 10000;
            [minDifferenceValue2, indexEnd2] = min(abs(x2 - valueToMatch2));

            if indexEnd1<indexEnd2        
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd1,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd1,indexAtStart2:indexAtEnd2)];   
            elseif indexEnd1>indexEnd2
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd2,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd2,indexAtStart2:indexAtEnd2)];
            end
            end

            timeStart=23;
            timeEnd=1;
                else
                timeStart=nineRasohour; timeEnd=nineRasohour+2;
                clear timeStart timeEnd
                timeStart=nineRasohour; timeEnd=nineRasohour +2;
                [yy, mm, dd]=datevec(Cloudnet(1).N(1));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
                % Find the closest value.
                [~, indexAtStart] = min(abs(x - valueToMatch));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
                % Find the closest value.
                [minDifferenceValue, indexAtEnd] = min(abs(x - valueToMatch));

                Cloudnet_short(xDate).number=Cloudnet(1).number;
                Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
                Cloudnet_short(xDate).height=Cloudnet(1).height(:);
                Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
                Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
                %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
                %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);
         end
         %%
         elseif xDate == yDate+9
        tenRaso = datevec(Raso(10).N(1));
        tenRasohour = tenRaso(4);
         if tenRasohour == 23
            clear timeStart timeEnd
            timeStart=23; timeEnd=23;

            [yy, mm, dd]=datevec(Cloudnet(1).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeStart-1,00,00);
            % Find the closest value.
            [~, indexAtStart1] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(1).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,59,59);
            % Find the closest value.
            [~, indexAtEnd1] = min(abs(x - valueToMatch));

            clear timeStart timeEnd 
            clear minDifferenceValue x valueToMatch

            timeStart=0; timeEnd=1;
            [yy, mm, dd]=datevec(Cloudnet(2).N(1));

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
            % Find the closest value.
            [~, indexAtStart2] = min(abs(x - valueToMatch)); 
            clear valueToMatch

            %for limiting height where we look for multi-layer clouds:
            x = Cloudnet(2).N;
            valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
            % Find the closest value.
            [~, indexAtEnd2] = min(abs(x - valueToMatch));

            clear timeStart timeEnd minDifferenceValue x

            try

            Cloudnet_short(xDate).number=Cloudnet(1).number;
            Cloudnet_short(xDate).N=[Cloudnet(1).N(indexAtStart1:indexAtEnd1);Cloudnet(2).N(indexAtStart2:indexAtEnd2)]; 
            Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart1));
            Cloudnet_short(xDate).height=Cloudnet(1).height(:);
            Cloudnet_short(xDate).Z=[Cloudnet(1).Z(:,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).Zsens=[Cloudnet(1).Zsens];
            %Cloudnet_short(xDate).beta=[Cloudnet(1).beta(:,indexAtStart1:indexAtEnd1),Cloudnet(2).beta(:,indexAtStart2:indexAtEnd2)];
            %Cloudnet_short(xDate).gasatten=[Cloudnet(1).gasatten(:,indexAtStart1:indexAtEnd1),Cloudnet(2).gasatten(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).v=[Cloudnet(1).v(:,indexAtStart1:indexAtEnd1),Cloudnet(2).v(:,indexAtStart2:indexAtEnd2)];
            Cloudnet_short(xDate).width=[Cloudnet(1).width(:,indexAtStart1:indexAtEnd1),Cloudnet(2).width(:,indexAtStart2:indexAtEnd2)];

            catch

            x1 = Cloudnet(1).height;
            valueToMatch1 = 10000;
            [minDifferenceValue1, indexEnd1] = min(abs(x1 - valueToMatch1));
            x2 = Cloudnet(2).height;
            valueToMatch2 = 10000;
            [minDifferenceValue2, indexEnd2] = min(abs(x2 - valueToMatch2));

            if indexEnd1<indexEnd2        
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd1,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd1,indexAtStart2:indexAtEnd2)];   
            elseif indexEnd1>indexEnd2
                Cloudnet_short(xDate).Z=[Cloudnet(1).Z(1:indexEnd2,indexAtStart1:indexAtEnd1),Cloudnet(2).Z(1:indexEnd2,indexAtStart2:indexAtEnd2)];
            end
            end

            timeStart=23;
            timeEnd=1;
                else
                timeStart=tenRasohour; timeEnd=tenRasohour+2;
                clear timeStart timeEnd
                timeStart=tenRasohour; timeEnd=tenRasohour +2;
                [yy, mm, dd]=datevec(Cloudnet(1).N(1));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeStart,00,00);
                % Find the closest value.
                [~, indexAtStart] = min(abs(x - valueToMatch));

                %for limiting height where we look for multi-layer clouds:
                x = Cloudnet(1).N;
                valueToMatch = datenum(yy,mm,dd,timeEnd,00,00);
                % Find the closest value.
                [~, indexAtEnd] = min(abs(x - valueToMatch));

                Cloudnet_short(xDate).number=Cloudnet(1).number;
                Cloudnet_short(xDate).N=Cloudnet(1).N(indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).date=datestr(Cloudnet(1).N(indexAtStart));
                Cloudnet_short(xDate).height=Cloudnet(1).height(:);
                Cloudnet_short(xDate).Z=Cloudnet(1).Z(:,indexAtStart:indexAtEnd); 
                Cloudnet_short(xDate).Zsens=Cloudnet(1).Zsens;
                %Cloudnet_short(xDate).beta=Cloudnet(1).beta(:,indexAtStart:indexAtEnd);
                %Cloudnet_short(xDate).gasatten=Cloudnet(1).gasatten(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).v=Cloudnet(1).v(:,indexAtStart:indexAtEnd);
                Cloudnet_short(xDate).width=Cloudnet(1).width(:,indexAtStart:indexAtEnd);
         end
 %%          
  end

    sizeZ=size(Cloudnet_short(xDate).Z);           %to check if cloudnet is long enough/covers time of Raso
    
%end                 

%%

%clear indexAtEnd indexAtStart 
clear minDifferenceValue valueToMatch x indexEnd1 indexEnd2 indexAtStart1 indexAtStart2
 