analysisSetup;

dataPath = './Data/M2 antagonisation lower dosage';
figPath = './Figures/M2 LowDose Results';
[~,~,~] = mkdir(figPath);

channelKeys = 'RH';

extractTimeWindow = 0.6;
yLims = [-350 350];
stimXs = 150 * [0 1 2 3];

vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.stimDefs = stimDefs;

files = dir(dataPath + "/*.plx");
for iF = 1:length(files)
    vdo.addDataFromPlxFile(files(iF).name,dataPath);
end

animalIDs = {'AnimalA' 'AnimalB' 'AnimalC' 'AnimalD' 'AnimalE'};

%%

vdo.deleteAllGroups;

expGrps = cell(1,3);
expTrGrps = cell(1,3);
days = 1:3;
for iD = 1:length(days)
    day = days(iD);
    grpKey = sprintf('Exp Day %i',day);
    expGrps{iD} = vdo.createNewGroup(grpKey,'VEPMagGroupClass');
    expTrGrps{iD} = vdo.createNewGroup(grpKey+"trace",'VEPTraceGroupClass');
    sessionID = sprintf('day%i',day);
    vdo.addMultipleKeysToGroup(grpKey,animalIDs,...
        sessionID,abcdKeys,channelKeys);
    vdo.addMultipleKeysToGroup(grpKey+"trace",animalIDs,...
        sessionID,'Abcd',channelKeys);
end


ctrlGrps = cell(1,3);
ctrlTrGrps = cell(1,3);
days = 3:5;
for iD = 1:length(days)
    day = days(iD);
    grpKey = sprintf('Ctrl Day %i',iD);
    ctrlGrps{iD} = vdo.createNewGroup(grpKey,'VEPMagGroupClass');
    ctrlTrGrps{iD} = vdo.createNewGroup(grpKey+"trace",'VEPTraceGroupClass');
    sessionID = sprintf('day%i',day);
    vdo.addMultipleKeysToGroup(grpKey,animalIDs,...
        sessionID,abcdKeys,channelKeys);
    vdo.addMultipleKeysToGroup(grpKey+"trace",animalIDs,...
        sessionID,'Abcd',channelKeys);
end

%%
normalizeByGroupMean(vdo,'Exp Day 1','Exp Day 1');
normalizeByGroupMean(vdo,'Exp Day 2','Exp Day 1');
normalizeByGroupMean(vdo,'Exp Day 3','Exp Day 1');

normalizeByGroupMean(vdo,'Ctrl Day 1','Ctrl Day 1');
normalizeByGroupMean(vdo,'Ctrl Day 2','Ctrl Day 1');
normalizeByGroupMean(vdo,'Ctrl Day 3','Ctrl Day 1');


%% Launch a group data plot viewer and populate

fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  {'Day1' 'Day2' 'Day3'});
GroupDataBarPlotter('newRow',fh1,...
  {'Exp' 'Ctrl'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')

%%
fh = figure;
violinPlotGroupData(expGrps{1},expGrps{2},expGrps{3},...
    ctrlGrps{1},ctrlGrps{2},ctrlGrps{3},'ClipRange',false,'Bandwidth',30);
ylim([0 600]);
savePlotToFile(fh,fullfile(figPath,'M2_ExpVsCtrl_Violin'),'-depsc');

%%

fh = figure;
hold on
days = 1:3;
legStrs = {}; phs = [];
for iD = 1:length(days)
    [vep,tTr] = expTrGrps{days(iD)}.getMeanTrace;
    legStrs{iD} = erase(expTrGrps{days(iD)}.ID,"trace"); %#ok<SAGROW>
    phs(iD) = plot(1e3*tTr,vep,'linewidth',2); %#ok<SAGROW>
end
ylim(yLims);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend(phs,legStrs);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M2_ExpDays1to3'),'-depsc');


%% 

fh = figure;
hold on
days = 1:3;
legStrs = {}; phs = [];
for iD = 1:length(days)
    [vep,tTr] = ctrlTrGrps{days(iD)}.getMeanTrace;
    legStrs{iD} = erase(ctrlTrGrps{days(iD)}.ID,"trace");  %#ok<SAGROW>
    phs(iD) = plot(1e3*tTr,vep,'linewidth',2);  %#ok<SAGROW>
end
ylim(yLims);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend(phs,legStrs);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M2_CtrlDays1to3'),'-depsc');

