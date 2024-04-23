analysisSetup;
figPath = './Figures/M1 2mk_kg Supp Figs';
dataPath = './Data/M1 antagonisation higher dosage/';
[~,~,~] = mkdir(figPath);

extractTimeWindow = 0.6;

vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.stimDefs = stimDefs;

channelKeys = {'LH','RH'};

ctrlAnimals = ["A1" "A2" "A5" "AD" "AE"];
expAnimals = ["A3" "A4" "AA" "AB" "AC"];

rhAnimals = ["A1" "A3" "AA" "AB" "AD" "AE"];
lhAnimals = ["A2" "A4" "A5" "AC"];

yLims = [-350 350];
stimXs = 0.150 * [0 1 2 3];

abcdKeys = abcdKeys(2:3);
dcbaKeys = dcbaKeys(2:3);

days = [1 5];
dayStrs = "day" + days;
for iD = 1:2
    day = days(iD);
    dayStr = dayStrs(iD);
    for animal = [expAnimals ctrlAnimals]
        fileName = char(animal + "_" + dayStr + ".plx");
        vdo.addDataFromPlxFile(fileName,dataPath,char(animal),char(dayStr));
    end
end

%%

expCell = cellstr(expAnimals);
ctrlCell = cellstr(ctrlAnimals);
vdo.deleteAllGroups;

grpKey = 'Exp Baseline';
expDay1Grp = vdo.createNewGroup(grpKey,'VEPMagGroupClass');
expBaselineGrp = vdo.createNewGroup([grpKey 'trace'],'VEPTraceGroupClass');
vdo.addMultipleKeysToGroup(grpKey,expCell,...
    'day1',abcdKeys,channelKeys);
vdo.addMultipleKeysToGroup([grpKey 'trace'],expCell,...
    'day1','Abcd',channelKeys);

grpKey = 'Exp ';
expABCDGrp = vdo.createNewGroup([grpKey 'ABCD'],'VEPMagGroupClass');
expDCBAGrp = vdo.createNewGroup([grpKey 'DCBA'],'VEPMagGroupClass');
expABCDTrcGrp = vdo.createNewGroup([grpKey 'ABCDtrace'],'VEPTraceGroupClass');
expDCBATrcGrp = vdo.createNewGroup([grpKey 'DCBAtrace'],'VEPTraceGroupClass');
vdo.addMultipleKeysToGroup([grpKey 'ABCD'],expCell,...
    'day5',abcdKeys,channelKeys);
vdo.addMultipleKeysToGroup([grpKey 'DCBA'],expCell,...
    'day5',dcbaKeys,channelKeys);
vdo.addMultipleKeysToGroup([grpKey 'ABCDtrace'],expCell,...
    'day5','Abcd',channelKeys);
vdo.addMultipleKeysToGroup([grpKey 'DCBAtrace'],expCell,...
    'day5','Dcba',channelKeys);

grpKey = 'Ctrl Baseline';
ctrlDay1Grp = vdo.createNewGroup(grpKey,'VEPMagGroupClass');
ctrlBaselineGrp = vdo.createNewGroup([grpKey 'trace'],'VEPMagGroupClass');
vdo.addMultipleKeysToGroup(grpKey,ctrlCell,...
    'day1',abcdKeys,channelKeys);
vdo.addMultipleKeysToGroup([grpKey 'trace'],ctrlCell,...
    'day1','Abcd',channelKeys);

grpKey = 'Ctrl ';
ctrlABCDGrp = vdo.createNewGroup([grpKey 'ABCD'],'VEPMagGroupClass');
ctrlDCBAGrp = vdo.createNewGroup([grpKey 'DCBA'],'VEPMagGroupClass');
ctrlABCDTrcGrp = vdo.createNewGroup([grpKey 'ABCDtrace'],'VEPTraceGroupClass');
ctrlDCBATrcGrp = vdo.createNewGroup([grpKey 'DCBAtrace'],'VEPTraceGroupClass');
vdo.addMultipleKeysToGroup([grpKey 'ABCD'],ctrlCell,...
    'day5',abcdKeys,channelKeys);
vdo.addMultipleKeysToGroup([grpKey 'DCBA'],ctrlCell,...
    'day5',dcbaKeys,channelKeys);
vdo.addMultipleKeysToGroup([grpKey 'ABCDtrace'],ctrlCell,...
    'day5','Abcd',channelKeys);
vdo.addMultipleKeysToGroup([grpKey 'DCBAtrace'],ctrlCell,...
    'day5','Dcba',channelKeys);

vdo.removeSpecifiersFromAllGroups(cellstr(rhAnimals),[],[],'LH');
vdo.removeSpecifiersFromAllGroups(cellstr(lhAnimals),[],[],'RH');

normalizeByGroupMean(vdo,'Exp Baseline','Exp ABCD');
normalizeByGroupMean(vdo,'Exp ABCD','Exp ABCD');
normalizeByGroupMean(vdo,'Exp DCBA','Exp ABCD');
normalizeByGroupMean(vdo,'Ctrl Baseline','Ctrl ABCD');
normalizeByGroupMean(vdo,'Ctrl ABCD','Ctrl ABCD');
normalizeByGroupMean(vdo,'Ctrl DCBA','Ctrl ABCD');

%% Launch a group data plot viewer and populate

fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  {'ABCD' 'DCBA'});
GroupDataBarPlotter('newRow',fh1,...
  {'Exp' 'Ctrl'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')

%%
fh = figure;
vs = violinPlotGroupData(expABCDGrp,expDCBAGrp,...
    ctrlABCDGrp,ctrlDCBAGrp,'ClipRange',false,'Bandwidth',30);
ylim([0 600]);
savePlotToFile(fh,fullfile(figPath,'M1_SeqFX_Violin'),'-depsc');

%% Plot group traces
fh = figure;
[exp,~] = expABCDTrcGrp.getMeanTrace;
[ctrl,tTr] = ctrlABCDTrcGrp.getMeanTrace;
plot(1e3*tTr,exp,1e3*tTr,ctrl,'linewidth',2);
hold on
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
ylim([-350 350]);
legend('Exp ABCD','Ctrl ABCD');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_SeqFX_ExpCtrlABCD'),'-depsc');

fh = figure;
[exp,~] = expDCBATrcGrp.getMeanTrace;
[ctrl,tTr] = ctrlDCBATrcGrp.getMeanTrace;
plot(1e3*tTr,exp,1e3*tTr,ctrl,'linewidth',2);
hold on
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
ylim([-350 350]);
legend('Exp DCBA','Ctrl DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_SeqFX_ExpCtrlDCBA'),'-depsc');

%% 
fh = figure;
[abcd,~] = expABCDTrcGrp.getMeanTrace;
[dcba,tTr] = expDCBATrcGrp.getMeanTrace;
plot(1e3*tTr,abcd,1e3*tTr,dcba,'linewidth',2);
hold on
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
ylim([-350 350]);
legend('Exp ABCD','Exp DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_SeqFX_ExpABCDDCBA'),'-depsc');

fh = figure;
[abcd,~] = ctrlABCDTrcGrp.getMeanTrace;
[dcba,tTr] = ctrlDCBATrcGrp.getMeanTrace;
plot(1e3*tTr,abcd,1e3*tTr,dcba,'linewidth',2);
hold on
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
ylim([-350 350]);
legend('Ctrl ABCD','Ctrl DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_SeqFX_CtrlABCDDCBA'),'-depsc');
