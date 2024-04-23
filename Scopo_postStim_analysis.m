% Compare exp vs control for scopolamine delivered IP after visual exposure

figType = '-djpeg';

dataPath = './Data/Scopolamine after visual stim IP';
figPath = './Figures/SCPFigures';
[~,~] = mkdir(figPath);

extractTimeWindow = 0.650;
yLims = [-250 250];
lineWidth = 2;

% Define stimulus event codes used in Sarkar et al.
abcdKeys = {'Abcd','aBcd','abCd','abcD'};
dcbaKeys = {'Dcba','dCba','dcBa','dcbA'};
stimDefs = containers.Map;
stimDefs(abcdKeys{1}) = 1;
stimDefs(abcdKeys{2}) = 2;
stimDefs(abcdKeys{3}) = 3;
stimDefs(abcdKeys{4}) = 4;
stimDefs(dcbaKeys{1}) = 6;
stimDefs(dcbaKeys{2}) = 7;
stimDefs(dcbaKeys{3}) = 8;
stimDefs(dcbaKeys{4}) = 9;



expDay1Files = struct;
expDay1Files(1).name = '600556o2_day1.plx';
expDay1Files(1).channelNumber = 1;
expDay1Files(1).folder = dataPath;
expDay1Files(2).name = '600556o4_day1.plx';
expDay1Files(2).channelNumber = 2;
expDay1Files(2).folder = dataPath;
expDay1Files(3).name = '608373o2_day1.plx';
expDay1Files(3).channelNumber = 2;
expDay1Files(3).folder = dataPath;
expDay1Files(4).name = '608373o4_day1.plx';
expDay1Files(4).channelNumber = 1;
expDay1Files(4).folder = dataPath;
expDay1Files(5).name = '609015o2_seqday1.plx';
expDay1Files(5).channelNumber = 1;
expDay1Files(5).folder = dataPath;
expDay1Files(6).name = '321980o1_day1.plx';
expDay1Files(6).channelNumber = 2;
expDay1Files(6).folder = dataPath;

expDay5Files = struct;
fileNumber = 1;
expDay5Files(fileNumber).name = '600556o2_day5.plx';
expDay5Files(fileNumber).channelNumber = 1;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '600556o4_day5.plx';
expDay5Files(fileNumber).channelNumber = 2;
expDay5Files(fileNumber).folder = dataPath;
% fileNumber = fileNumber + 1;
% expDay5Files(fileNumber).name = '608373o2_day5.plx';
% expDay5Files(fileNumber).channelNumber = 2;
% expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '608373o4_day5.plx';
expDay5Files(fileNumber).channelNumber = 1;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '609015o2_seqday5.plx';
expDay5Files(fileNumber).channelNumber = 1;
expDay5Files(fileNumber).folder = dataPath;
fileNumber = fileNumber + 1;
expDay5Files(fileNumber).name = '321980o1_day5.plx';
expDay5Files(fileNumber).channelNumber = 2;
expDay5Files(fileNumber).folder = dataPath;

ctrlDay1Files = struct;
ctrlDay1Files(1).name = '600556o3_day1.plx';
ctrlDay1Files(1).channelNumber = 2;
ctrlDay1Files(1).folder = dataPath;
ctrlDay1Files(2).name = '608373o1_day1.plx';
ctrlDay1Files(2).channelNumber = 1;
ctrlDay1Files(2).folder = dataPath;
ctrlDay1Files(3).name = '608373o3_day1.plx';
ctrlDay1Files(3).channelNumber = 1;
ctrlDay1Files(3).folder = dataPath;
ctrlDay1Files(4).name = '609015o1_seqday1.plx';
ctrlDay1Files(4).channelNumber = 2;
ctrlDay1Files(4).folder = dataPath;
ctrlDay1Files(5).name = '609015o3_seqday1.plx';
ctrlDay1Files(5).channelNumber = 1;
ctrlDay1Files(5).folder = dataPath;
ctrlDay1Files(6).name = '321980o2_day1.plx';
ctrlDay1Files(6).channelNumber = 1;
ctrlDay1Files(6).folder = dataPath;
ctrlDay1Files(7).name = '321980o4_day1.plx';
ctrlDay1Files(7).channelNumber = 2;
ctrlDay1Files(7).folder = dataPath;

ctrlDay5Files = struct;
ctrlDay5Files(1).name = '600556o3_day5.plx';
ctrlDay5Files(1).channelNumber = 2;
ctrlDay5Files(1).folder = dataPath;
ctrlDay5Files(2).name = '608373o1_day5.plx';
ctrlDay5Files(2).channelNumber = 1;
ctrlDay5Files(2).folder = dataPath;
ctrlDay5Files(3).name = '608373o3_day5.plx';
ctrlDay5Files(3).channelNumber = 1;
ctrlDay5Files(3).folder = dataPath;
ctrlDay5Files(4).name = '609015o1_seqday5.plx';
ctrlDay5Files(4).channelNumber = 2;
ctrlDay5Files(4).folder = dataPath;
ctrlDay5Files(5).name = '609015o3_seqday5.plx';
ctrlDay5Files(5).channelNumber = 1;
ctrlDay5Files(5).folder = dataPath;
ctrlDay5Files(6).name = '321980o2_day5.plx';
ctrlDay5Files(6).channelNumber = 1;
ctrlDay5Files(6).folder = dataPath;
ctrlDay5Files(7).name = '321980o4_day5.plx';
ctrlDay5Files(7).channelNumber = 2;
ctrlDay5Files(7).folder = dataPath;

[expDay1Traces,tTr] = getTracesForFiles(expDay1Files,1,extractTimeWindow);
[ctrlDay1Traces,~] = getTracesForFiles(ctrlDay1Files,1,extractTimeWindow);

[expDay5TracesABCD,~] = getTracesForFiles(expDay5Files,1,extractTimeWindow);
[ctrlDay5TracesABCD,~] = getTracesForFiles(ctrlDay5Files,1,extractTimeWindow);

[expDay5TracesDCBA,~] = getTracesForFiles(expDay5Files,6,extractTimeWindow);
[ctrlDay5TracesDCBA,~] = getTracesForFiles(ctrlDay5Files,6,extractTimeWindow);

tTr = 1000 * tTr; % convert to ms

%%

params = struct;
params.stdStr = 'Exp Day 1';
params.devStr = 'Ctrl Day 1';
ph = plotComparisonVEPs(tTr,expDay1Traces,ctrlDay1Traces,params,'linewidth',lineWidth);
ylim(yLims);
if printFlag
    savePlotToFile(ph,fullfile(figPath,'Day1_ExpVsCtrl'),figType);
end
%%
params = struct;
params.stdStr = 'Exp Day 5 ABCD';
params.devStr = 'Exp Day 5 DCBA';
ph = plotComparisonVEPs(tTr,expDay5TracesABCD,expDay5TracesDCBA,params,'linewidth',lineWidth);
ylim(yLims);
if printFlag
    savePlotToFile(ph,fullfile(figPath,'Day5_Exp'),figType);
end

params = struct;
params.stdStr = 'Ctrl Day 5 ABCD';
params.devStr = 'Ctrl Day 5 DCBA';
ph = plotComparisonVEPs(tTr,ctrlDay5TracesABCD,ctrlDay5TracesDCBA,params,'linewidth',lineWidth);
ylim(yLims);
if printFlag
    savePlotToFile(ph,fullfile(figPath,'Day5_Ctrl'),figType);
end
%%
params = struct;
params.stdStr = 'Exp Day 5 ABCD';
params.devStr = 'Ctrl Day 5 ABCD';
ph = plotComparisonVEPs(tTr,expDay5TracesABCD,ctrlDay5TracesABCD,params,'linewidth',lineWidth);
ylim(yLims);
if printFlag
    savePlotToFile(ph,fullfile(figPath,'Day5_ExpVsCtrl_ABCD'),figType);
end

params = struct;
params.stdStr = 'Exp Day 5 DCBA';
params.devStr = 'Ctrl Day 5 DCBA';
ph = plotComparisonVEPs(tTr,expDay5TracesDCBA,ctrlDay5TracesDCBA,params,'linewidth',lineWidth);
ylim(yLims);
if printFlag
    savePlotToFile(ph,fullfile(figPath,'Day5_ExpVsCtrl_DCBA'),figType);
end

