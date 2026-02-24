
Myfileinfo_1 =dir('path_to_files\*_100_*20*01*.mat');
Myfileinfo_2 =dir('path_to_files\*_100_*20*02*.mat');
Myfileinfo_3 =dir('path_to_files\*_100_*20*03*.mat');
Myfileinfo_4 =dir('path_to_files\*_100_*20*04*.mat');
Myfileinfo_5 =dir('path_to_files\*_100_*20*05*.mat');
Myfileinfo_6 =dir('path_to_fileṣ\*_100_*20*06*.mat');
Myfileinfo_7 =dir('path_to_files\*_100_*20*07*.mat');
Myfileinfo_8 =dir('path_to_files\*_100_*20*08*.mat');
Myfileinfo_9 =dir('path_to_files\*_100_*20*09*.mat');
Myfileinfo_10 =dir('path_to_files\*_100_*20*10*.mat');
Myfileinfo_11 =dir('path_to_files\*_100_*20*11*.mat');
Myfileinfo_12 =dir('path_to_files\*_100_*20*12*.mat');

addpath('path_to_files'); 
load cm.mat;
Rsize=100;                  %Radius of ice crystal [mikrometer]. Std Rsize=100 
station=('UTQ'); %needs to be updated to own data
% add to one file

%%
UTQ_01 = []; % Initialize empty array for valid structures
Njan = 0;
a = [Myfileinfo_1(1:9);Myfileinfo_1(12);Myfileinfo_1(13)];
Myfileinfo_1 = a;
for i = 1 : size(Myfileinfo_1,1)
    load(Myfileinfo_1(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_01 = [UTQ_01, MLC_classification(j)];
        end

        % Update total count
        Njan = Njan + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_1(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end
clear a
%%
UTQ_02 = []; % Initialize empty array for valid structures
 Nfeb = 0;

for i = 1 : size(Myfileinfo_2,1)
    load(Myfileinfo_2(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_02 = [UTQ_02, MLC_classification(j)];
        end

        % Update total count
        Nfeb = Nfeb + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_2(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end

%%
UTQ_03 = []; % Initialize empty array for valid structures
 Nmar = 0;

for i = 1 : size(Myfileinfo_3,1)
    load(Myfileinfo_3(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_03 = [UTQ_03, MLC_classification(j)];
        end

        % Update total count
        Nmar = Nmar + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_3(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end

%%
UTQ_04 = []; % Initialize empty array for valid structures
 Napr = 0;

for i = 1 : size(Myfileinfo_4,1)
    load(Myfileinfo_4(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_04 = [UTQ_04, MLC_classification(j)];
        end

        % Update total count
        Napr = Napr + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_4(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end
%% 
UTQ_05 = []; % Initialize empty array for valid structures
 Nmay = 0;

for i = 1 : size(Myfileinfo_5,1)
    load(Myfileinfo_5(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_05 = [UTQ_05, MLC_classification(j)];
        end

        % Update total count
        Nmay = Nmay + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_5(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end

%%
%%
UTQ_06 = []; % Initialize empty array for valid structures
 Njun = 0;

for i = 1 : size(Myfileinfo_6,1)
    load(Myfileinfo_6(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_06 = [UTQ_06, MLC_classification(j)];
        end

        % Update total count
        Njun = Njun + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_6(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end
%%
UTQ_07 = []; % Initialize empty array for valid structures
Njul = 0;

for i = 1 : size(Myfileinfo_7,1)
    load(Myfileinfo_7(i).name); % Load MATLAB file

% Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        %Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        %Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_07 = [UTQ_07, MLC_classification(j)];
        end

        %Update total count
        Njul = Njul + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_7(i).name);
    end

    %Clear variables
    clear MLC_classification idxMLC j;
end

%%
UTQ_08 = []; % Initialize empty array for valid structures
Naug = 0;

for i = 1 : size(Myfileinfo_8,1)
    load(Myfileinfo_8(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_08 = [UTQ_08, MLC_classification(j)];
        end

        % Update total count
        Naug = Naug + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_8(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end

%%
UTQ_09 = []; % Initialize empty array for valid structures
Nseb = 0;

for i = 1 : size(Myfileinfo_9,1)
    load(Myfileinfo_9(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_09
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_09 = [UTQ_09, MLC_classification(j)];
        end

        % Update total count
        Nseb = Nseb + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_9(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end
 
%%
UTQ_10 = []; % Initialize empty array for valid structures
Noct = 0;
a = [Myfileinfo_10(1:9);Myfileinfo_10(19)];
Myfileinfo_10 = a;
for i = 1 : size(Myfileinfo_10,1)
    load(Myfileinfo_10(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_10 = [UTQ_10, MLC_classification(j)];
        end

        % Update total count
        Noct = Noct + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_10(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end
clear a
%%
UTQ_11 = []; % Initialize empty array for valid structures
Nnov = 0;
for i = 1 : size(Myfileinfo_11,1)
    load(Myfileinfo_11(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_11 = [UTQ_11, MLC_classification(j)];
        end

        % Update total count
        Nnov = Nnov + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_11(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end

UTQ_12 = []; % Initialize empty array for valid structures
Ndec = 0;
a = Myfileinfo_12(12:end);
Myfileinfo_12= a;
for i = 1 : size(Myfileinfo_12,1)
    load(Myfileinfo_12(i).name); % Load MATLAB file

    % Check if the structure has more than 12 fields
    if length(fieldnames(MLC_classification)) > 12
        % Remove empty entries
        idxMLC = find(cellfun(@isempty, {MLC_classification.day}));
        MLC_classification(idxMLC) = [];

        % Append valid entries to UTQ_03
        for j = 1 : MLC_classification(end).number_i - length(idxMLC)
            UTQ_12 = [UTQ_12, MLC_classification(j)];
        end

        % Update total count
        Ndec = Ndec + (MLC_classification(end).number_i - length(idxMLC));
    else
        fprintf('Skipping file %s due to insufficient fields\n', Myfileinfo_12(i).name);
    end

    % Clear variables
    clear MLC_classification idxMLC j;
end

clear a i 
%%
MLC_classification = [UTQ_01,UTQ_02,UTQ_03,UTQ_04,UTQ_05,UTQ_06,UTQ_07,...
      UTQ_08, UTQ_09, UTQ_10, UTQ_11, UTQ_12];
%MLC_classification = [UTQ_08, UTQ_09];
 fn = fieldnames(MLC_classification);

for n = 1:numel(MLC_classification)
    for i = 1:numel(fn)
        f = fn{i};

        if isempty(MLC_classification(n).(f))
            MLC_classification(n).(f) = NaN;
        end
    end
end

%% 
 b = [];
 for i = 1:length(MLC_classification)
     if MLC_classification(i).fallend(1) == 10
         b(i) = 1;
         MLC_classification(i).fallend(1) = [];
         MLC_classification(i).fallbeginn(1) = [];
         MLC_classification(i).Seeding(1) = [];
     elseif MLC_classification(i).fallend(1) > 10
         b(i) = 2;
     else 
         b(i) = 0;
     end
 end

 %%
 idxMLC = find(cellfun(@isempty,{MLC_classification.day}));
 MLC_classification(idxMLC) = [];

 %%
 clear UTQ idxMLC
 index=1:length(MLC_classification);

%%
switch true
    case (strcmpi(station,'AO2018')==1) 
    name = ('AO2018_100_season90');
    modeic = 1;
    Evaluation_2_arctic_pie
    Evaluation_2_arctic_histogram_radii
    Evaluation_3_arctic_nonSeeding                    %Cloud category of non-seeding
    Evaluation_3_arctic_Seeding                       %Cloud category of seeding
    Evaluation_4_RC_calc                        %Preparation of following plots (is included in the two following programs)
    Evaluation_4_RC_histogram_arctic  
    case (strcmpi(station,'MOSAIC')==1)
        name = ('MOSAIC_100_v2_100RH_');
        Evaluation_2_arctic_pie
        %%
        %Cloud categories:
         Evaluation_3_arctic_nonSeeding                    %Cloud category of non-seeding
         Evaluation_3_arctic_Seeding                       %Cloud category of seeding
         Evaluation_4_RC_calc                       %Preparation of following plots (is included in the two following programs)
         Evaluation_4_RC_pie_arctic
            for modeic = 1 : 3
                if modeic == 1 
                name = ('MOSAIC_seasons_100_final');
                end
                if modeic == 2
                name = ('MOSAIC_month_100_final');
                end
                if modeic == 3
                name = ('MOASIC_lat_step2_100_final');
                end
                Evaluation_2_arctic_histogram_radii
                Evaluation_4_RC_histogram_arctic   
            end
    case (strcmpi(station,'UTQ')==1)
        name = ('UTQ_4_100_final_all_sup');
        Evaluation_2_arctic_pie
        modeic = 2;
        name = ('UTQ_4_month_100_final_all_sup');
        %%
        %Cloud categories:
         Evaluation_3_arctic_nonSeeding                    %Cloud category of non-seeding
         Evaluation_3_arctic_Seeding                       %Cloud category of seeding
         Evaluation_4_RC_calc                      %Preparation of following plots (is included in the two following programs)
         Evaluation_4_RC_pie_arctic
         Evaluation_2_arctic_histogram_radii
         Evaluation_4_RC_histogram_arctic
%%
end