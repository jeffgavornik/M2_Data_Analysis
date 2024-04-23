analysisSetup;

dataPath = './Data/Scopolamine after visual stim IP';
figPath = './Figures/SCPFigures';
[~,~] = mkdir(figPath);

SCP_data_selection;

extractTimeWindow = 0.6;
yLims = [-350 350];
stimXs = 150 * [0 1 2 3];

channelKeys = {'LH','RH'};

figType = '-depsc';
% figType = '-djpeg';

vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = extractTimeWindow;
vdo.stimDefs = stimDefs;

%% Add all data
days = 1:5;
grpStrs = ["Exp" "Ctrl"];
for day = days
    for grpStr = grpStrs
        fileStrct = eval(sprintf('%sFiles{%i}',lower(grpStr),day));
        for iF = 1:length(fileStrct)
            theFile = fileStrct(iF);
            parts = split(theFile.name,'_');
            animalID = parts{1};
            sessionID = regexprep(parts{2}(1:end-4),'seq','');
            vdo.addDataFromPlxFile(theFile.name,dataPath,animalID,sessionID);
        end
    end
end


%% Create ABCD Groups for days 1 to 5
vdo.deleteAllGroups;

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
            sessionID = regexprep(parts{2}(1:end-4),'seq','');
            vdo.addMultipleKeysToGroup(grpKey,animalID,...
                sessionID,abcdKeys,channelKeys(theFile.channelNumber));
            vdo.addMultipleKeysToGroup(grpKey+"trace",animalID,...
                sessionID,'Abcd',channelKeys(theFile.channelNumber));
        end
    end
end

%Create ABCD and DCBA groups for day 5
seqABCDKeys = abcdKeys(2:3);
seqDCBAKeys = dcbaKeys(2:3);
grpKeys = ["Exp" "Ctrl"];
for grpKey = grpKeys
    cmdStr = grpKey + "ABCDGrp = vdo.createNewGroup('" + grpKey + " ABCD','VEPMagGroupClass');";
    eval(grpKey + "ABCDGrp = vdo.createNewGroup('" + grpKey + " ABCD','VEPMagGroupClass');");
    eval(grpKey + "DCBAGrp = vdo.createNewGroup('" + grpKey + " DCBA','VEPMagGroupClass');");
    eval(grpKey + "ABCDTrcGrp = vdo.createNewGroup('" + grpKey + " ABCDtrace','VEPTraceGroupClass');");
    eval(grpKey + "DCBATrcGrp = vdo.createNewGroup('" + grpKey + " DCBAtrace','VEPTraceGroupClass');");
    day5Files = eval(lower(grpKey) + "Files{5}");
    for iF = 1:length(day5Files)
        theFile = day5Files(iF);
        parts = split(theFile.name,'_');
        animalID = parts{1};
        sessionID = regexprep(parts{2}(1:end-4),'seq','');
        vdo.addMultipleKeysToGroup(char(grpKey+" ABCD"),animalID,...
            sessionID,seqABCDKeys,channelKeys(theFile.channelNumber));
        vdo.addMultipleKeysToGroup(char(grpKey+" DCBA"),animalID,...
            sessionID,seqDCBAKeys,channelKeys(theFile.channelNumber));
        vdo.addMultipleKeysToGroup(char(grpKey+" ABCDtrace"),animalID,...
            sessionID,'Abcd',channelKeys(theFile.channelNumber));
        vdo.addMultipleKeysToGroup(char(grpKey+" DCBAtrace"),animalID,...
            sessionID,'Dcba',channelKeys(theFile.channelNumber));
    end
end

vdo.removeSpecifiersFromAllGroups('600556o3',[],[],[]); % missing data

for day = 1:5
    normalizeByGroupMean(vdo,char("Exp Day" + day),'Exp Day1');
    normalizeByGroupMean(vdo,char("Ctrl Day" + day),'Ctrl Day1');
end
normalizeByGroupMean(vdo,'Exp ABCD','Exp ABCD');
normalizeByGroupMean(vdo,'Exp DCBA','Exp ABCD');
normalizeByGroupMean(vdo,'Ctrl ABCD','Ctrl ABCD');
normalizeByGroupMean(vdo,'Ctrl DCBA','Ctrl ABCD');

%% Launch a group data plot viewer and populate

fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  {'Day1' 'Day2' 'Day3' 'Day4' 'Day5'});
GroupDataBarPlotter('newRow',fh1,...
  {'Exp' 'Ctrl'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')

%%
fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  {'ABCD' 'DCBA'});
GroupDataBarPlotter('newRow',fh1,...
  {'Exp' 'Ctrl'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')

%%

fh = figure;
violinPlotGroupData(expGrps{:},ctrlGrps{:},'ClipRange',false,'Bandwidth',30);
ylim([0 800]);
savePlotToFile(fh,fullfile(figPath,'violin_SCP2_ExpVsCtrl_Days1to5'),figType);

%%
fh = figure;
violinPlotGroupData(ExpABCDGrp,ExpDCBAGrp,CtrlABCDGrp,CtrlDCBAGrp,'ClipRange',false,'Bandwidth',30);
ylim([0 800]);
savePlotToFile(fh,fullfile(figPath,'violin_SCP2_ExpVsCtrl_ABCDvsDCBA'),figType);

%% 

for day = 1:5
    fh = figure;
    [exp,~] = expTrGrps{day}.getMeanTrace;
    [ctrl,tTr] = ctrlTrGrps{day}.getMeanTrace;
    plot(1e3*tTr,exp,1e3*tTr,ctrl,'linewidth',2);
    hold on
    ylim(yLims);
    addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
    legend(['Exp Day' num2str(day)],['Ctrl Day' num2str(day)]);
    fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
    savePlotToFile(fh,fullfile(figPath,char("Scp_ExpvsCtrl_Day"+day)),figType);
end



%% 
fh = figure;
[abcd,~] = ExpABCDTrcGrp.getMeanTrace;
[dcba,tTr] = ExpDCBATrcGrp.getMeanTrace;
plot(1e3*tTr,abcd,1e3*tTr,dcba,'linewidth',2);
hold on
ylim(yLims);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Exp ABCD','Exp DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Scp_SeqFX_ExpABCDDCBA'),figType);

fh = figure;
[abcd,~] = CtrlABCDTrcGrp.getMeanTrace;
[dcba,tTr] = CtrlDCBATrcGrp.getMeanTrace;
plot(1e3*tTr,abcd,1e3*tTr,dcba,'linewidth',2);
hold on
ylim(yLims);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Ctrl ABCD','Ctrl DCBA');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figPath,'Scp_SeqFX_CtrlABCDDCBA'),figType);


%%
[expABCD,normExpABCD] = ExpABCDGrp.getGroupData('AverageByAnimal');
[expDCBA,normExpDCBA] = ExpDCBAGrp.getGroupData('AverageByAnimal');
[ctrlABCD,normCtrlABCD] = CtrlABCDGrp.getGroupData('AverageByAnimal');
[ctrlDCBA,normCtrlDCBA] = CtrlDCBAGrp.getGroupData('AverageByAnimal');

fid = fopen(fullfile(figPath,'SCP_ABCDvsDCBA.txt'),'w');
[h,p,~,stats] = ttest(expABCD,expDCBA,'tail','right');
fprintf(fid,'EXP, h = %i, t(%i)=%0.4f, p = %0.4f\n',h,stats.df,stats.tstat,p);
[h,p,ci,stats] = ttest(ctrlABCD,ctrlDCBA,'tail','right');
fprintf(fid,'CTRL, h = %i, t(%i)=%0.4f, p = %0.4f\n',h,stats.df,stats.tstat,p);
fclose(fid);
