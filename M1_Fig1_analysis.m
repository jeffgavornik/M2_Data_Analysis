analysisSetup;
M1_data_selection;
figPath = './Figures/M1 Fig1 Results';
[~,~,~] = mkdir(figPath);

vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.stimDefs = stimDefs;

channelKeys = {'LH','RH'};

%%
expGrps = cell(1,5);
expTrGrps = cell(1,5);
ctrlGrps = cell(1,5);
ctrlTrGrps = cell(1,5);

days = 1:5;

grpStrs = ["Exp" "Ctrl"];

for day = days
    for grpStr = grpStrs
        fileStrct = eval(sprintf('%sFiles{%i}',lower(grpStr),day));
        grpKey = sprintf('%s Day%i',grpStr,day);
        eval(sprintf('%sGrps{%i} = vdo.createNewGroup(grpKey,''VEPMagGroupClass'');',lower(grpStr),day));
        eval(sprintf('%sTrGrps{%i} = vdo.createNewGroup(grpKey+"trace",''VEPTraceGroupClass'');',lower(grpStr),day));
        for iF = 1:length(fileStrct)
            theFile = fileStrct(iF);
            parts = split(theFile.name,'_');
            animalID = parts{1};
            sessionID = parts{2}(1:end-4);
            vdo.addDataFromPlxFile(theFile.name,dataPath,animalID,sessionID);
            vdo.addMultipleKeysToGroup(grpKey,animalID,...
                sessionID,abcdKeys,channelKeys(theFile.channelNumber));
            vdo.addMultipleKeysToGroup(grpKey+"trace",animalID,...
                sessionID,'Abcd',channelKeys(theFile.channelNumber));
        end
    end
end


%%
normalizeByGroupMean(vdo,'Exp Day1','Exp Day1');
normalizeByGroupMean(vdo,'Exp Day2','Exp Day1');
normalizeByGroupMean(vdo,'Exp Day3','Exp Day1');
normalizeByGroupMean(vdo,'Exp Day4','Exp Day1');
normalizeByGroupMean(vdo,'Exp Day5','Exp Day1');

normalizeByGroupMean(vdo,'Ctrl Day1','Ctrl Day1');
normalizeByGroupMean(vdo,'Ctrl Day2','Ctrl Day1');
normalizeByGroupMean(vdo,'Ctrl Day3','Ctrl Day1');
normalizeByGroupMean(vdo,'Ctrl Day4','Ctrl Day1');
normalizeByGroupMean(vdo,'Ctrl Day5','Ctrl Day1');

%% Launch a group data plot viewer and populate

fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  {'Day1' 'Day2' 'Day3' 'Day4' 'Day5'});
GroupDataBarPlotter('newRow',fh1,...
  {'Exp' 'Ctrl'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')

%%
fh = figure;
violinPlotGroupData(ctrlGrps{1},expGrps{1},ctrlGrps{5},expGrps{5},'ClipRange',false,'Bandwidth',30);
ylim([-200 800]);
savePlotToFile(fh,fullfile(figPath,'M1_ExpVsCtrl_Days1and5_Violin'),'-depsc');

%%
fh = figure;
violinPlotGroupData(expGrps{1},expGrps{2},expGrps{3},expGrps{4},expGrps{5},...
    ctrlGrps{1},ctrlGrps{2},ctrlGrps{3},ctrlGrps{4},ctrlGrps{5},'ClipRange',false,'Bandwidth',30);
savePlotToFile(fh,fullfile(figPath,'M1_ExpVsCtrl_Days1to5_Violin'),'-depsc');

%%

fh = figure;
hold on
days = [1 5];
legStrs = {}; phs = [];
for iD = 1:length(days)
    [vep,tTr] = expTrGrps{days(iD)}.getMeanTrace;
    legStrs{iD} = erase(expTrGrps{days(iD)}.ID,"trace"); %#ok<SAGROW>
    phs(iD) = plot(1e3*tTr,vep,'linewidth',2); %#ok<SAGROW>
end
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend(phs,legStrs);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_ExpDays1and5'),'-depsc');

%% 

fh = figure;
hold on
days = [1 5];
legStrs = {}; phs = [];
for iD = 1:length(days)
    [vep,tTr] = ctrlTrGrps{days(iD)}.getMeanTrace;
    legStrs{iD} = erase(ctrlTrGrps{days(iD)}.ID,"trace");  %#ok<SAGROW>
    phs(iD) = plot(1e3*tTr,vep,'linewidth',2);  %#ok<SAGROW>
end
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend(phs,legStrs);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_CtrlDays1and5'),'-depsc');


%%

fh = figure;
hold on
days = 1:5;
legStrs = {}; phs = [];
for iD = 1:length(days)
    [vep,tTr] = expTrGrps{days(iD)}.getMeanTrace;
    legStrs{iD} = erase(expTrGrps{days(iD)}.ID,"trace"); %#ok<SAGROW>
    phs(iD) = plot(1e3*tTr,vep,'linewidth',2); %#ok<SAGROW>
end
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend(phs,legStrs);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_ExpDays1to5'),'-depsc');

%% 

fh = figure;
hold on
days = 1:5;
legStrs = {}; phs = [];
for iD = 1:length(days)
    [vep,tTr] = ctrlTrGrps{days(iD)}.getMeanTrace;
    legStrs{iD} = erase(ctrlTrGrps{days(iD)}.ID,"trace");  %#ok<SAGROW>
    phs(iD) = plot(1e3*tTr,vep,'linewidth',2);  %#ok<SAGROW>
end
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend(phs,legStrs);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_CtrlDays1to5'),'-depsc');