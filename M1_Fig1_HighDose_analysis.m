analysisSetup;
figPath = './Figures/M1 2mk_kg Figs';
dataPath = './Data/M1 antagonisation higher dosage/';
[~,~,~] = mkdir(figPath);

extractTimeWindow = 0.6;

vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.stimDefs = stimDefs;

channelKeys = {'LH','RH'};

ctrlAnimals = ["A1" "A2" "A5" "AD" "AE"];
expAnimals = ["A3" "A4" "AA" "AB" "AC"];

days = [1 2 3 4 5];
dayStrs = "day" + days;
rhAnimals = ["A1" "A3" "AA" "AB" "AD" "AE"];
lhAnimals = ["A2" "A4" "A5" "AC"];

yLims = [-350 350];
stimXs = 0.150 * [0 1 2 3];

%%

for day = days
    dayStr = dayStrs(day);
    for animal = [expAnimals ctrlAnimals]
        fileName = char(animal + "_" + dayStr + ".plx");
        vdo.addDataFromPlxFile(fileName,dataPath,char(animal),char(dayStr));
    end
end


%%
expGrps = cell(1,5);
expTrGrps = cell(1,5);
ctrlGrps = cell(1,5);
ctrlTrGrps = cell(1,5);

grpStrs = ["Exp" "Ctrl"];

vdo.deleteAllGroups;

for day = days
    dayStr = dayStrs(day);
    grpStr = "Exp";
    grpKey = sprintf('Exp Day%i',day);
    eval(sprintf('%sGrps{%i} = vdo.createNewGroup(grpKey,''VEPMagGroupClass'');',lower(grpStr),day));
    eval(sprintf('%sTrGrps{%i} = vdo.createNewGroup(grpKey+"trace",''VEPTraceGroupClass'');',lower(grpStr),day));
    for animal = expAnimals
        animalID = animal;
        sessionID = dayStr;
        vdo.addMultipleKeysToGroup(grpKey,animalID,...
            sessionID,abcdKeys,{'LH' 'RH'});
        vdo.addMultipleKeysToGroup(grpKey+"trace",animalID,...
            sessionID,'Abcd',{'LH' 'RH'});
    end

    grpStr = "Ctrl";
    grpKey = sprintf('Ctrl Day%i',day);
    eval(sprintf('%sGrps{%i} = vdo.createNewGroup(grpKey,''VEPMagGroupClass'');',lower(grpStr),day));
    eval(sprintf('%sTrGrps{%i} = vdo.createNewGroup(grpKey+"trace",''VEPTraceGroupClass'');',lower(grpStr),day));
    for animal = ctrlAnimals
        animalID = animal;
        sessionID = dayStr;
        vdo.addMultipleKeysToGroup(grpKey,animalID,...
            sessionID,abcdKeys,{'LH' 'RH'});
        vdo.addMultipleKeysToGroup(grpKey+"trace",animalID,...
            sessionID,'Abcd',{'LH' 'RH'});
    end
end

vdo.removeSpecifiersFromAllGroups(cellstr(rhAnimals),[],[],'LH');
vdo.removeSpecifiersFromAllGroups(cellstr(lhAnimals),[],[],'RH');

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
dayStrs = [1 5];
legStrs = {}; phs = [];
for iD = 1:length(dayStrs)
    [vep,tTr] = expTrGrps{dayStrs(iD)}.getMeanTrace;
    legStrs{iD} = erase(expTrGrps{dayStrs(iD)}.ID,"trace"); %#ok<SAGROW>
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
dayStrs = [1 5];
legStrs = {}; phs = [];
for iD = 1:length(dayStrs)
    [vep,tTr] = ctrlTrGrps{dayStrs(iD)}.getMeanTrace;
    legStrs{iD} = erase(ctrlTrGrps{dayStrs(iD)}.ID,"trace");  %#ok<SAGROW>
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
dayStrs = 1:5;
legStrs = {}; phs = [];
for iD = 1:length(dayStrs)
    [vep,tTr] = expTrGrps{dayStrs(iD)}.getMeanTrace;
    legStrs{iD} = erase(expTrGrps{dayStrs(iD)}.ID,"trace"); %#ok<SAGROW>
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
dayStrs = 1:5;
legStrs = {}; phs = [];
for iD = 1:length(dayStrs)
    [vep,tTr] = ctrlTrGrps{dayStrs(iD)}.getMeanTrace;
    legStrs{iD} = erase(ctrlTrGrps{dayStrs(iD)}.ID,"trace");  %#ok<SAGROW>
    phs(iD) = plot(1e3*tTr,vep,'linewidth',2);  %#ok<SAGROW>
end
ylim(yLims);
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend(phs,legStrs);
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_CtrlDays1to5'),'-depsc');