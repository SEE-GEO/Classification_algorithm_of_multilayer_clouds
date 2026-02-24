function [timestruct,dd1,Monthfile,yyyy,Dayfile] = Cloudnet_1_calcN(NCloudnet,ii)
%This program converts the time into variables/structs needed later.

[yyyy, mm, dd ]=datevec(NCloudnet(ii));
dd1=dd(1);
%to make 05 instead for 5 for correct filename:
Monthfile={};
for j=1:length(mm)
    MM=mm(j);
    MMs=num2str(MM,'%02d');
    Monthfile{end+1} = MMs;
end

Dayfile={};
for j=1:length(dd)
    DD=dd(j);
    DDs=num2str(DD,'%02d');
    Dayfile{end+1} = DDs;
end

clear DD DDs MM MMs 

Monthfile=char(Monthfile);
Dayfile=char(Dayfile);

timestruct.i=ii;
timestruct.time=datestr(NCloudnet);
end