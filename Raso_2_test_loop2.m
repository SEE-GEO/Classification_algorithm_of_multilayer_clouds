function [Raso,NoRasoNum] = Raso_2_test_loop2(Raso,Rasohelp,idx_dayl,day,month,year,hour,minute,sek,altitude,temp,press,RHl,lat,lon,NoRasoNum,idx_dayk, iDate,lDate)
   
disp(strxcat('Raso Date: ',Rasohelp.date(iDate,:)))
disp(iDate)
%%  
%stepRaso=2;
%iDate=1
   stepRaso = iDate;
   disp(strxcat('More than one Raso at this day. ',num2str(iDate),' is used.'));
%%         
%Write in raso-struct:
     Raso(iDate).number = iDate;
     Raso(iDate).nDate = iDate;
     Raso(iDate).date=datestr(Rasohelp.date(stepRaso,:)); %Time of raso launch
%%   
        
%Find indicies from raso launch:
     idx_begin=idx_dayl(stepRaso);
     stepEnd = length(idx_dayl);
     
      if iDate==lDate                              %if there is only one raso
          idx_last=idx_dayk(end);
      else                                    %last raso at this day
          idx_last=idx_dayl(iDate+1)-1;        
      end
 %% 
%Write time into raso-struct:
     Raso(iDate).N=datenum(year(idx_begin:idx_last),month(idx_begin:idx_last),day(idx_begin:idx_last),hour(idx_begin:idx_last),minute(idx_begin:idx_last),sek(idx_begin:idx_last));   
     Raso(iDate).time=datenum(hour(idx_begin:idx_last),minute(idx_begin:idx_last),sek(idx_begin:idx_last));

%write variables into raso-struct und convert in SI:   
     Raso(iDate).alt=altitude(idx_begin:idx_last);  
     Raso(iDate).tempK=temp(idx_begin:idx_last)+273.15;
     Raso(iDate).press=press(idx_begin:idx_last)*1e2;
     Raso(iDate).RHl=RHl(idx_begin:idx_last);
     if idx_last <= length(lat)
        Raso(iDate).lat=lat(idx_begin:idx_last);
        Raso(iDate).lon=lon(idx_begin:idx_last); 
     else
        a=nan((idx_last-idx_begin)+1,1);
        lat1 = lat(idx_begin : idx_last -(idx_last - length(lat)));
        b=nan((idx_last-idx_begin)+1,1); 
        lon1 = lon(idx_begin : idx_last -(idx_last - length(lon)));
        n=max(numel(lat1),numel(a));
        a(end+1:n)=nan;
        lat1(end+1:n)=nan;
        n=max(numel(lon1),numel(b));
        b(end+1:n)=nan;
        lon1(end+1:n)=nan;
        Raso(iDate).lat=lat1;
        Raso(iDate).lon=lon1; 
        clear a b n lat1 lon1
     end
    
 %datestr(Raso(iDate).N(1))   
 
 

    
      
 


%%

%include measurement uncertainty   --- Raso uncertainty for humidity
%try
%    Raso.RHl=Raso.RHl+uncert;
%catch 
%end

%%
%Calculate missing variables:

%calculate Raso.RHi
 try
     
    TC=Raso(iDate).tempK-273.15;                           %TC in deg C, TK in K:
    esatwM=6.112e2.*exp((17.62.*TC)./(243.12+TC));   %Saturation equvilibrium pressure regarding water
    esatiM=6.112e2*exp((22.46*TC)./(272.62+TC));     %Saturation equilibrium pressure regarding ice
    
    logew =  1./Raso(iDate).tempK*(- 0.58002206e4) ...        %Hyland and Wexler, 1983.
             + 0.13914993e1 ...
             - 0.48640239e-1*(Raso(iDate).tempK) ...
             + 0.41764768e-4*(Raso(iDate).tempK).^2 ...
             - 0.14452093e-7*(Raso(iDate).tempK).^3 ...
             + 0.65459673e1*log(Raso(iDate).tempK);
    esatw=exp(logew);
      
    logei =  1./Raso(iDate).tempK*(- 0.56745359e4) ...          %Hyland and Wexler, 1983.                                                                
             + 0.63925247e1 ...
             - 0.96778430e-2*Raso(iDate).tempK ...
             + 0.62215701e-6*(Raso(iDate).tempK).^2 ...
             + 0.20747825e-8*(Raso(iDate).tempK).^3 ...
             - 0.94840240e-12*(Raso(iDate).tempK).^4 ...
             + 0.41635019e1*log(Raso(iDate).tempK); 
    esati=exp(logei);

    Raso(iDate).RHi=Raso(iDate).RHl.*esatw./esati;                %Calculation of RHi
    clear TC esatw esati esatwM esatiM

 catch 
 end
 
%calculate Raso.RHmax: Max of RHl and RHi
 try
     
    Raso(iDate).RHmax=max(Raso(iDate).RHl,Raso(iDate).RHi);
   
 catch 
 end
 

end 
%%

