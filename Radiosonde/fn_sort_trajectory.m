function fn_sort_trajectory(out)
    ix = find(out.time == 0);
    %% sort traj to layers
    for ilay = 1 : ix(end)
        variableNames = fieldnames(out);
        if length(ix) == 3 % single layer cloud
            if ilay == 1
                layer1_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CB.(variableNames{i}) = variable(ix(1) : ix(2) -1);
                end
            end
            if ilay == 2
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CM.(variableNames{i}) = variable(ix(2) : ix(3) -1);
                end
            end
            if ilay == 3
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CT.(variableNames{i}) = variable(ix(3) : end);
                end
            end
        end
        if length(ix) == 4 % single layer cloud
            if ilay == 1
                layer1_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CB.(variableNames{i}) = variable(ix(1) : ix(2) -1);
                end
            end
            if ilay == 2
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CM.(variableNames{i}) = variable(ix(2) : ix(3) -1);
                end
            end
            if ilay == 3
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CT.(variableNames{i}) = variable(ix(3) : ix(4) -1);
                end
             end
             if ilay == 4
                layer1_above = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_above.(variableNames{i}) = variable(ix(4) : end);
                end
             end
        end
        %%
        if length(ix) == 8 % two layer cloud
            if ilay == 1
                layer1_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CB.(variableNames{i}) = variable(ix(1) : ix(2) -1);
                end
            end
            if ilay == 3
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CM.(variableNames{i}) = variable(ix(3) : ix(4) -1);
                end
            end
            if ilay == 5
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CT.(variableNames{i}) = variable(ix(5) : ix(6) -1);
                end
             end
             if ilay == 7
                layer1_above = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_above.(variableNames{i}) = variable(ix(7) : ix(8) -1);
                end
             end
             %%
             if ilay == 2
                layer2_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer2_CB.(variableNames{i}) = variable(ix(2) : ix(3) -1);
                end
            end
            if ilay == 4
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer2_CM.(variableNames{i}) = variable(ix(4) : ix(5) -1);
                end
            end
            if ilay == 6
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CT.(variableNames{i}) = variable(ix(6) : ix(7) -1);
                end
             end
             if ilay == 8
                layer1_above = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer2_above.(variableNames{i}) = variable(ix(8) : end);
                end
             end
    %          if ilay == 9
    %             layer1_above = struct();
    %             for i = 6 : numel(variableNames)
    %                 variable = out.(variableNames{i});
    %                 cloudfree_above.(variableNames{i}) = variable(ix(9) : end);
    %             end
    %          end
        end
        if length(ix) == 13 % three layer cloud
            if ilay == 1
                layer1_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CB.(variableNames{i}) = variable(ix(1) : ix(2) -1);
                end
            end
            if ilay == 4
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CM.(variableNames{i}) = variable(ix(4) : ix(5) -1);
                end
            end
            if ilay == 7
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CT.(variableNames{i}) = variable(ix(7) : ix(8) -1);
                end
             end
             if ilay == 10
                layer1_above = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_above.(variableNames{i}) = variable(ix(10) : ix(11) -1);
                end
             end
             %%
            if ilay == 2
                layer2_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer2_CB.(variableNames{i}) = variable(ix(2) : ix(3) -1);
                end
            end
            if ilay == 5
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer2_CM.(variableNames{i}) = variable(ix(5) : ix(6) -1);
                end
            end
            if ilay == 8
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CT.(variableNames{i}) = variable(ix(8) : ix(9) -1);
                end
             end
             if ilay == 11
                layer1_above = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer2_above.(variableNames{i}) = variable(ix(11) : ix(12)-1);
                end
             end
             %%
             if ilay == 3
                layer3_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer3_CB.(variableNames{i}) = variable(ix(3) : ix(4) -1);
                end
            end
            if ilay == 6
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer3_CM.(variableNames{i}) = variable(ix(6) : ix(7) -1);
                end
            end
            if ilay == 9
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer3_CT.(variableNames{i}) = variable(ix(9) : ix(10) -1);
                end
             end
             if ilay == 12
                layer1_above = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer3_above.(variableNames{i}) = variable(ix(12) : ix(13)-1);
                end
             end
             if ilay == 13
                layer1_cludfree = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    cloudfree1.(variableNames{i}) = variable(ix(13) : end);
                end
             end
        end
        if length(ix) == 14 % three layer cloud
            if ilay == 1
                layer1_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CB.(variableNames{i}) = variable(ix(1) : ix(2) -1);
                end
            end
            if ilay == 4
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CM.(variableNames{i}) = variable(ix(4) : ix(5) -1);
                end
            end
            if ilay == 7
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CT.(variableNames{i}) = variable(ix(7) : ix(8) -1);
                end
             end
             if ilay == 10
                layer1_above = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_above.(variableNames{i}) = variable(ix(10) : ix(11) -1);
                end
             end
             %%
            if ilay == 2
                layer2_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer2_CB.(variableNames{i}) = variable(ix(2) : ix(3) -1);
                end
            end
            if ilay == 5
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer2_CM.(variableNames{i}) = variable(ix(5) : ix(6) -1);
                end
            end
            if ilay == 8
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer1_CT.(variableNames{i}) = variable(ix(8) : ix(9) -1);
                end
             end
             if ilay == 11
                layer1_above = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer2_above.(variableNames{i}) = variable(ix(11) : ix(12)-1);
                end
             end
             %%
             if ilay == 3
                layer3_CB = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer3_CB.(variableNames{i}) = variable(ix(3) : ix(4) -1);
                end
            end
            if ilay == 6
                layer1_CM = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer3_CM.(variableNames{i}) = variable(ix(6) : ix(7) -1);
                end
            end
            if ilay == 9
                layer1_CT = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer3_CT.(variableNames{i}) = variable(ix(9) : ix(10) -1);
                end
             end
             if ilay == 12
                layer1_above = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    layer3_above.(variableNames{i}) = variable(ix(12) : ix(13)-1);
                end
             end
             if ilay == 13
                layer1_cludfree = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    cloudfree1.(variableNames{i}) = variable(ix(13) : end);
                end
             end
             if ilay == 14
                layer1_cludfree = struct();
                for i = 6 : numel(variableNames)
                    variable = out.(variableNames{i});
                    cloudfree2.(variableNames{i}) = variable(ix(14) : end);
                end
             end
        end
    end