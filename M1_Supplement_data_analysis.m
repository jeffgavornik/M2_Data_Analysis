analysisSetup;
M1_data_selection;
figPath = './Figures/M1 Supplemental Results';
[~,~,~] = mkdir(figPath);

vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.stimDefs = stimDefs;

abcdKeys = abcdKeys(2:3);
dcbaKeys = dcbaKeys(2:3);

channelKeys = {'LH','RH'};

%%
grpKey = 'Exp Baseline';
expDay1Grp = vdo.createNewGroup(grpKey,'VEPMagGroupClass');
expBaselineGrp = vdo.createNewGroup([grpKey 'trace'],'VEPTraceGroupClass');
for iF = 1:length(expDay1Files)
    theFile = expDay1Files(iF);
    parts = split(theFile.name,'_');
    animalID = parts{1};
    sessionID = parts{2}(1:end-4);
    vdo.addDataFromPlxFile(theFile.name,dataPath,animalID,sessionID);
    vdo.addMultipleKeysToGroup(grpKey,animalID,...
        sessionID,abcdKeys,channelKeys(theFile.channelNumber));
    vdo.addMultipleKeysToGroup([grpKey 'trace'],animalID,...
        sessionID,'Abcd',channelKeys(theFile.channelNumber));
end

grpKey = 'Exp ';
expABCDGrp = vdo.createNewGroup([grpKey 'ABCD'],'VEPMagGroupClass');
expDCBAGrp = vdo.createNewGroup([grpKey 'DCBA'],'VEPMagGroupClass');
expABCDTrcGrp = vdo.createNewGroup([grpKey 'ABCDtrace'],'VEPTraceGroupClass');
expDCBATrcGrp = vdo.createNewGroup([grpKey 'DCBAtrace'],'VEPTraceGroupClass');
for iF = 1:length(expDay5Files)
    theFile = expDay5Files(iF);
    parts = split(theFile.name,'_');
    animalID = parts{1};
    sessionID = parts{2}(1:end-4);
    vdo.addDataFromPlxFile(theFile.name,dataPath,animalID,sessionID);
    vdo.addMultipleKeysToGroup([grpKey 'ABCD'],animalID,...
        sessionID,abcdKeys,channelKeys(theFile.channelNumber));
    vdo.addMultipleKeysToGroup([grpKey 'DCBA'],animalID,...
        sessionID,dcbaKeys,channelKeys(theFile.channelNumber));
    vdo.addMultipleKeysToGroup([grpKey 'ABCDtrace'],animalID,...
        sessionID,'Abcd',channelKeys(theFile.channelNumber));
    vdo.addMultipleKeysToGroup([grpKey 'DCBAtrace'],animalID,...
        sessionID,'Dcba',channelKeys(theFile.channelNumber));
end


grpKey = 'Ctrl Baseline';
ctrlDay1Grp = vdo.createNewGroup(grpKey,'VEPMagGroupClass');
ctrlBaselineGrp = vdo.createNewGroup([grpKey 'trace'],'VEPMagGroupClass');
for iF = 1:length(ctrlDay1Files)
    theFile = ctrlDay1Files(iF);
    parts = split(theFile.name,'_');
    animalID = parts{1};
    sessionID = parts{2}(1:end-4);
    vdo.addDataFromPlxFile(theFile.name,dataPath,animalID,sessionID);
    vdo.addMultipleKeysToGroup(grpKey,animalID,...
        sessionID,abcdKeys,channelKeys(theFile.channelNumber));
    vdo.addMultipleKeysToGroup([grpKey 'trace'],animalID,...
        sessionID,'Abcd',channelKeys(theFile.channelNumber));
end

grpKey = 'Ctrl ';
ctrlABCDGrp = vdo.createNewGroup([grpKey 'ABCD'],'VEPMagGroupClass');
ctrlDCBAGrp = vdo.createNewGroup([grpKey 'DCBA'],'VEPMagGroupClass');
ctrlABCDTrcGrp = vdo.createNewGroup([grpKey 'ABCDtrace'],'VEPTraceGroupClass');
ctrlDCBATrcGrp = vdo.createNewGroup([grpKey 'DCBAtrace'],'VEPTraceGroupClass');
for iF = 1:length(ctrlDay5Files)
    theFile = ctrlDay5Files(iF);
    parts = split(theFile.name,'_');
    animalID = parts{1};
    sessionID = parts{2}(1:end-4);
    vdo.addDataFromPlxFile(theFile.name,dataPath,animalID,sessionID);
    vdo.addMultipleKeysToGroup([grpKey 'ABCD'],animalID,...
        sessionID,abcdKeys,channelKeys(theFile.channelNumber));
    vdo.addMultipleKeysToGroup([grpKey 'DCBA'],animalID,...
        sessionID,dcbaKeys,channelKeys(theFile.channelNumber));
    vdo.addMultipleKeysToGroup([grpKey 'ABCDtrace'],animalID,...
        sessionID,'Abcd',channelKeys(theFile.channelNumber));
    vdo.addMultipleKeysToGroup([grpKey 'DCBAtrace'],animalID,...
        sessionID,'Dcba',channelKeys(theFile.channelNumber));
end

normalizeByGroupMean(vdo,'Exp Baseline','Exp ABCD');
normalizeByGroupMean(vdo,'Exp ABCD','Exp ABCD');
normalizeByGroupMean(vdo,'Exp DCBA','Exp ABCD');
normalizeByGroupMean(vdo,'Ctrl Baseline','Ctrl ABCD');
normalizeByGroupMean(vdo,'Ctrl ABCD','Ctrl ABCD');
normalizeByGroupMean(vdo,'Ctrl DCBA','Ctrl ABCD');

% vdo.removeSpecifiersFromAllGroups('330042o2',[],[],[]); % corrupt data file

%% Launch a group data plot viewer and populate

fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  {'Baseline' 'ABCD' 'DCBA'});
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
ylim([-250 250]);
legend('Exp ABCD','Ctrl ABCD');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_SeqFX_ExpCtrlABCD'),'-depsc');

fh = figure;
[exp,~] = expDCBATrcGrp.getMeanTrace;
[ctrl,tTr] = ctrlDCBATrcGrp.getMeanTrace;
plot(1e3*tTr,exp,1e3*tTr,ctrl,'linewidth',2);
hold on
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
ylim([-250 250]);
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
ylim([-250 250]);
legend('Exp ABCD','Exp DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_SeqFX_ExpABCDDCBA'),'-depsc');

fh = figure;
[abcd,~] = ctrlABCDTrcGrp.getMeanTrace;
[dcba,tTr] = ctrlDCBATrcGrp.getMeanTrace;
plot(1e3*tTr,abcd,1e3*tTr,dcba,'linewidth',2);
hold on
addMarkerSymbols(gca,1e3*stimXs,zeros(size(stimXs))-150,[0 0 0]);
ylim([-250 250]);
legend('Ctrl ABCD','Ctrl DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'M1_SeqFX_CtrlABCDDCBA'),'-depsc');
