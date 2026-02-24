
function[H_fallbeginn_out , H_falldown_out , Pressure_mean_no_cloud_out ,RHi_mean_non_cloud_out, TempK_mean_no_cloud_out ]=func_2_avg(Raso, Raso10km, Cloudixd,iDate) 

%%
%In this function the mean of p,T, RHi in the subsaturated layer is calculated

ix_bottom=Cloudixd(iDate).index_sub_bottom;
ix_top=Cloudixd(iDate).index_sub_top;
lindex=length(ix_top);                                %Amount of subsaturated layers
%%

for k=1:lindex
    
    index_sub_bottom=ix_bottom(k);               %find index at bottom of subsaturated layer
    index_sub_top=ix_top(k);                     %find index at top of subsaturated layer
    
    Heightdiff(k)=Raso10km(iDate).alt(ix_top(k))-Raso10km(iDate).alt(ix_bottom(k));    %height of subsaturated layer
      
    %%
    %Height of subsaturated layer/fall distance of ice crystal
    H_fallbeginn=Raso10km(iDate).alt(index_sub_top);
    H_falldown=Raso10km(iDate).alt(index_sub_bottom);

    %need to find index for heights in Raso-struct:
    x = Raso(iDate).alt;
    valueToMatch = H_fallbeginn;
    [minDifferenceValue, indexAtTop] = min(abs(x - valueToMatch));    % Find the closest value
    x = Raso(iDate).alt;
    valueToMatch = H_falldown;
    [minDifferenceValue, indexAtEnd] = min(abs(x - valueToMatch));    % Find the closest value

    %Mean values of T, p, RHi in subsaturated layer (SI):
    RHmax_mean_no_cloud=mean(Raso(iDate).RHmax(indexAtEnd:indexAtTop)); 
    RHi_mean_no_cloud=mean(Raso(iDate).RHi(indexAtEnd:indexAtTop)); 
    TempK_mean_no_cloud=mean(Raso(iDate).tempK(indexAtEnd:indexAtTop));
    Pressure_mean_no_cloud=mean(Raso(iDate).press(indexAtEnd:indexAtTop));

    H_fallbeginn_out(k)=H_fallbeginn;
    H_falldown_out(k)=H_falldown;
    Pressure_mean_no_cloud_out(k)=Pressure_mean_no_cloud;
    RHi_mean_non_cloud_out(k)=  RHi_mean_no_cloud;
    TempK_mean_no_cloud_out(k)=TempK_mean_no_cloud;

end
    H_fallbeginn_out(k)=NaN;
    H_falldown_out(k)=NaN;
    Pressure_mean_no_cloud_out(k)= NaN;
    RHi_mean_non_cloud_out(k)=  NaN;
    TempK_mean_no_cloud_out(k)= NaN;
end

