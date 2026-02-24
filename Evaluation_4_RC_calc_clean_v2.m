function E = Evaluation_4_RC_calc_clean_v2(MLC_classification, index)
% ============================================================
% Evaluation_4_RC_calc  (PATCHED MINIMAL, original logic)
% Objective:
% - IDENTICAL behavior to the original code
% - but without index shifts / silent errors
%
% PATCHES:
%   A) Remove NaNs in Seeding AND remove the corresponding indices from
%      Zbelow / Zbetween / Zabove
%   B) Recalculate lS(k) AFTER removal, reinitialize Seeddiv / ML
%   C) Use diagnostic output instead of silent try/catch blocks
%
% IMPORTANT:
% - The warm-cloud definition remains exactly as in the original code
%   (a = sum(cloud_layers) - sum(liquid_super))
% - idx_1warmcloud can therefore legitimately be 0
%   (if a == -1 never occurs)

% ============================================================
idx_1warmcloud = 0;
idx_2warmcloud = 0;
if nargin < 2 || isempty(index)
    index = 1:numel(MLC_classification);
end

lMLC = length(index);

% ----------------------------
% Init wie Original
% ----------------------------
lS = NaN(1,lMLC);

for k=1:lMLC
    lS(k)=length(MLC_classification(k).Seeding);
    MLC_classification(k).Seeddiv(1:lS(k))=NaN;
    MLC_classification(k).ML(1:lS(k))=NaN;
    MLC_classification(k).MLjn=NaN;
end

% ============================================================
% 1) Seeddiv: (NaN sync + lS update)
% ============================================================
diag_seeddiv_failed = false(lMLC,1);
diag_len_mismatch   = false(lMLC,1);

for k=1:lMLC

    % ---------- PATCH A: remove NaNs in Seeding AND sync Z* ----------
    if isfield(MLC_classification(k),'Seeding') && ~isempty(MLC_classification(k).Seeding)
        rm = isnan(MLC_classification(k).Seeding);
        if any(rm)
            oldN = numel(rm);

            MLC_classification(k).Seeding(rm) = [];

            if isfield(MLC_classification(k),'Zbelow')   && numel(MLC_classification(k).Zbelow)   == oldN
                MLC_classification(k).Zbelow(rm) = [];
            else
                diag_len_mismatch(k)=true;
            end
            if isfield(MLC_classification(k),'Zbetween') && numel(MLC_classification(k).Zbetween) == oldN
                MLC_classification(k).Zbetween(rm) = [];
            else
                diag_len_mismatch(k)=true;
            end
            if isfield(MLC_classification(k),'Zabove')   && numel(MLC_classification(k).Zabove)   == oldN
                MLC_classification(k).Zabove(rm) = [];
            else
                diag_len_mismatch(k)=true;
            end
        end
    end

    % ---------- PATCH B: recompute lS AFTER deletion ----------
    lS(k)=length(MLC_classification(k).Seeding);
    MLC_classification(k).Seeddiv(1:lS(k))=NaN;
    MLC_classification(k).ML(1:lS(k))=NaN;

    % ---------- original (try/catch replaced by safe loop) ----------
    if lS(k)==0
        continue
    end

    if ~isfield(MLC_classification(k),'Zbelow') || ~isfield(MLC_classification(k),'Zbetween') || ~isfield(MLC_classification(k),'Zabove')
        diag_seeddiv_failed(k)=true;
        continue
    end

    nZ = min([lS(k), length(MLC_classification(k).Zbelow), length(MLC_classification(k).Zbetween), length(MLC_classification(k).Zabove)]);
    if nZ < lS(k)
        diag_len_mismatch(k)=true;
    end

    for kk=1:nZ
        seed = MLC_classification(k).Seeding(kk);
        zb   = MLC_classification(k).Zbelow(kk);
        zbt  = MLC_classification(k).Zbetween(kk);
        za   = MLC_classification(k).Zabove(kk);

        % (Original if/elseif Kette)
        if seed==1 && zb==0 && zbt==0 && za==0
            MLC_classification(k).Seeddiv(kk)=11;
        elseif seed==1 && zb==1 && zbt==0 && za==1
            MLC_classification(k).Seeddiv(kk)=12;
        elseif seed==1 && zb==1 && zbt==0 && za==0
            MLC_classification(k).Seeddiv(kk)=13;
        elseif seed==1 && zb==0 && zbt==0 && za==1
            MLC_classification(k).Seeddiv(kk)=14;
        elseif seed==1 && zb==0 && zbt==1 && za==0
            MLC_classification(k).Seeddiv(kk)=15;
        elseif seed==1 && zb==1 && zbt==1 && za==0
            MLC_classification(k).Seeddiv(kk)=16;
        elseif seed==1 && zb==0 && zbt==1 && za==1
            MLC_classification(k).Seeddiv(kk)=17;
        elseif seed==1 && zb==1 && zbt==1 && za==1
            MLC_classification(k).Seeddiv(kk)=18;

        elseif seed==0 && zb==0 && zbt==0 && za==0
            MLC_classification(k).Seeddiv(kk)=21;
        elseif seed==0 && zb==1 && zbt==0 && za==1
            MLC_classification(k).Seeddiv(kk)=22;
        elseif seed==0 && zb==1 && zbt==0 && za==0
            MLC_classification(k).Seeddiv(kk)=23;
        elseif seed==0 && zb==0 && zbt==0 && za==1
            MLC_classification(k).Seeddiv(kk)=24;
        elseif seed==0 && zb==0 && zbt==1 && za==0
            MLC_classification(k).Seeddiv(kk)=25;
        elseif seed==0 && zb==1 && zbt==1 && za==0
            MLC_classification(k).Seeddiv(kk)=26;
        elseif seed==0 && zb==0 && zbt==1 && za==1
            MLC_classification(k).Seeddiv(kk)=27;
        elseif seed==0 && zb==1 && zbt==1 && za==1
            MLC_classification(k).Seeddiv(kk)=28;
        else
            % -> keep NaN
        end
    end
end

% ============================================================
% 2) ML assignment (original)
% ============================================================
for k=1:lMLC
    for kk=1:lS(k)
        sd = MLC_classification(k).Seeddiv(kk);

        if sd==12 || sd==18
            MLC_classification(k).ML(kk)=10;
        elseif sd==11 || sd==13 || sd==14 || sd==15 || sd==16 || sd==17
            MLC_classification(k).ML(kk)=19;
        elseif (sd==22) || (sd==28)          % <-- PATCH: 28 is non-seeding ML
            MLC_classification(k).ML(kk)=20;
        elseif sd==21 || sd==23 || sd==24 || sd==25 || sd==26 || sd==27
            MLC_classification(k).ML(kk)=29;
        end
    end
end

% ============================================================
% 3) Ausw_* arrays + Warmcloud indices (original)
% ============================================================
Ausw_hmax        = NaN(lMLC,1);
Ausw_cloudlayers = NaN(lMLC,1);

for k=1:lMLC
    Ausw_hmax(k)        = MLC_classification(k).hmax;
    Ausw_cloudlayers(k) = MLC_classification(k).cloud_layers;
end

% --- Warmcloud original definition ---
Anz_warmcloud = NaN(1,lMLC);
aWarm = NaN(1,lMLC);

for k=1:lMLC
    Anz_warmcloud(k) = sum(MLC_classification(k).liquid_super);
    aWarm(k) = sum(MLC_classification(k).cloud_layers) - Anz_warmcloud(k);
    if Anz_warmcloud(k) == 0
        aWarm(k) = NaN;
    end
end

idx_1warmcloud = find(aWarm == -1);
idx_2warmcloud = find(isnan(aWarm)==0 & aWarm ~= -1);

% ============================================================
% 4) Radar / nonNan indices (original)
% ============================================================
idx_Nan        = find(isnan(Ausw_hmax));
idx_nonNan     = find(~isnan(Ausw_hmax));

idx_0cloud     = find(Ausw_cloudlayers==0);
idx_1cloud     = find(Ausw_cloudlayers==1);
idx_2cloud     = find(Ausw_cloudlayers>=2);
idx_cloudcover = find(Ausw_cloudlayers>=1);

% ============================================================
% 5) counts only for idx_2cloud (original)
% ============================================================
Anz_seeding(index)=NaN;
Anz_nonseeding(index)=NaN;

for ii=1:length(idx_2cloud)
    k = idx_2cloud(ii);

    MLC_ML_all = MLC_classification(k).ML;
    Anz_seeding(k)    = length(find(MLC_ML_all==10));
    Anz_nonseeding(k) = length(find(MLC_ML_all==20));
end

% ============================================================
% 6) Anz_trenn (original)
% ============================================================
Anz_trenn(index)=NaN;

for k=1:lMLC
    if Anz_seeding(k)>=1 && Anz_nonseeding(k)==0
        Anz_trenn(k)=31;
    elseif Anz_seeding(k)==0 && Anz_nonseeding(k)>=1
        Anz_trenn(k)=32;
    elseif Anz_seeding(k)>=1 && Anz_nonseeding(k)>=1
        Anz_trenn(k)=33;
    elseif Anz_seeding(k)==0 && Anz_nonseeding(k)==0
        Anz_trenn(k)=34;
    end
end

for k=1:lMLC
    MLC_classification(k).MLjn=Anz_trenn(k);
end

idx_onlyseed = find(Anz_trenn==31);
idx_nonseed  = find(Anz_trenn==32);
idx_both     = find(Anz_trenn==33);
idx_noML     = find(Anz_trenn==34);

% ============================================================
% 7) noML0/noML1 (original!)
% ============================================================
Anz_34 = zeros(1,lMLC);
Anz_34(idx_noML)=NaN;
Anz_34(isnan(Anz_34))=1;
Anz_34(Anz_34==0)=NaN;

for k=1:lMLC
    MLC_classification(k).noML=NaN;
    for kk=1:lS(k)
        sd = MLC_classification(k).Seeddiv(kk);

        if sd==11 || sd==21
            MLC_classification(k).noML(kk)=0;
        else
            MLC_classification(k).noML(kk)=1;
        end
    end
end

sum_34 = NaN(1,lMLC);
for k=1:lMLC
    sum_34(k)=sum(MLC_classification(k).noML);
end

idx_noML0=find(sum_34==0);
idx_noML1=find(sum_34==1);

idx_add  = setdiff(idx_noML(:), union(idx_noML0(:), idx_noML1(:)));
idx_noML0 = sort([idx_noML0(:); idx_add(:)]);

% ============================================================
% Check: RadarML partition + Seeddiv NaNs
% ============================================================
unclassifiedRadarML = setdiff(idx_2cloud(:), [idx_onlyseed(:); idx_nonseed(:); idx_both(:); idx_noML(:)]);

fprintf('hmax: NaN=%d nonNaN=%d\n', numel(idx_Nan), numel(idx_nonNan));
fprintf('RadarML=%d  only=%d non=%d both=%d noML=%d  check=%d\n', ...
    numel(idx_2cloud), numel(idx_onlyseed), numel(idx_nonseed), numel(idx_both), numel(idx_noML), ...
    numel(idx_onlyseed)+numel(idx_nonseed)+numel(idx_both)+numel(idx_noML));
fprintf('noML0=%d  noML1=%d  (idx_add=%d)\n', numel(idx_noML0), numel(idx_noML1), numel(idx_add));
fprintf('warmcloud idx: 1warm=%d  2warm=%d\n', numel(idx_1warmcloud), numel(idx_2warmcloud));

if ~isempty(unclassifiedRadarML)
    fprintf('UNCLASSIFIED RadarML days: %d\n', numel(unclassifiedRadarML));
    disp(unclassifiedRadarML(1:min(20,end)));
end

% ============================================================
% Output struct
% ============================================================
E = struct();
E.MLC_classification = MLC_classification;

E.idx_Nan        = idx_Nan(:);
E.idx_nonNan     = idx_nonNan(:);

E.idx_0cloud     = idx_0cloud(:);
E.idx_1cloud     = idx_1cloud(:);
E.idx_2cloud     = idx_2cloud(:);
E.idx_cloudcover = idx_cloudcover(:);

E.idx_1warmcloud = idx_1warmcloud(:);
E.idx_2warmcloud = idx_2warmcloud(:);

E.idx_onlyseed = idx_onlyseed(:);
E.idx_nonseed  = idx_nonseed(:);
E.idx_both     = idx_both(:);
E.idx_noML     = idx_noML(:);

E.idx_noML0 = idx_noML0(:);
E.idx_noML1 = idx_noML1(:);

E.unclassifiedRadarML = unclassifiedRadarML(:);
E.sum_34 = sum_34(:);

E.diag_seeddiv_failed = find(diag_seeddiv_failed);
E.diag_len_mismatch   = find(diag_len_mismatch);

end
