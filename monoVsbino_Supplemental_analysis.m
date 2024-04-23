dataDir = './Data/Mono vs Bino/';
figDir = './Figures/MonocBinoc Supplemental Results';
[~,~,~] = mkdir(figPath);

day1Files = dir([dataDir '*_day1.plx*']);
day2Files = dir([dataDir '*_day2.plx*']);
day3Files = dir([dataDir '*_day3.plx*']);
day4Files = dir([dataDir '*_day4.plx*']);
day5Files = dir([dataDir '*_day5.plx*']);
day6Files = dir([dataDir '*_day6.plx*']);
day7Files = dir([dataDir '*_day7.plx*']);
day8Files = dir([dataDir '*_day8.plx*']);
day9Files = dir([dataDir '*_day9.plx*']);
day10Files = dir([dataDir '*_day10.plx*']);

files = [day1Files;day2Files;day3Files;day4Files;day5Files;...
    day6Files;day7Files;day8Files;day9Files;day10Files];

vdo = VEPDataClass.new;
vdo.dataExtractParams.extractTimeWindow = 0.6;
vdo.stimDefs = stimDefs;

for iF = 1:length(files)
    file = files(iF);
    vdo.addDataFromPlxFile(file.name,dataDir);
end


%%
stimXs = 150 * [0 1 2 3];
yScale = [-350 350];

abcdKeys = abcdStims(2:3);
dcbaKeys = dcbaStims(2:3);

vdo.deleteAllGroups;

days = [1 5 6 10]; %1:10

nAnimals = 8;
animalKeys = cell(1,nAnimals);
for day = 1:nAnimals
    animalKeys{day} = sprintf('An%i',day);
end

monocABCDGrps = cell(1,10);
binocABCDGrps = cell(1,10);
monocABCDTrGrps = cell(1,10);
binocABCDTrGrps = cell(1,10);

for day = days 
    dayKey = sprintf('day%i',day);
    monocGrpKey = sprintf('Day%02i ABCD Monoc',day);
    binocGrpKey = sprintf('Day%02i ABCD Binoc',day);
    monocABCDGrps{day} = vdo.createGroupForMultipleKeys(monocGrpKey,...
        animalKeys,dayKey,abcdKeys,'LH');
    binocABCDGrps{day} = vdo.createGroupForMultipleKeys(binocGrpKey,...
        animalKeys,dayKey,abcdKeys,'RH');
    
    monocABCDTrGrps{day} = vdo.createNewGroup(['TR' monocGrpKey ],'VEPTraceGroupClass');
    vdo.addMultipleKeysToGroup(['TR' monocGrpKey ],animalKeys,dayKey,'Abcd','LH');
    binocABCDTrGrps{day} = vdo.createNewGroup(['TR' binocGrpKey ],'VEPTraceGroupClass');
    vdo.addMultipleKeysToGroup(['TR' binocGrpKey ],animalKeys,...
        dayKey,'Abcd','RH');

end

day5MonocDCBAGrp = vdo.createGroupForMultipleKeys('Day05 DCBA Monoc',animalKeys,...
    'day5',dcbaKeys,'LH');
day5BinocDCBAGrp = vdo.createGroupForMultipleKeys('Day05 DCBA Binoc',animalKeys,...
    'day5',dcbaKeys,'RH');
day10MonocDCBAGrp = vdo.createGroupForMultipleKeys('Day10 DCBA Monoc',animalKeys,...
    'day10',dcbaKeys,'LH');
day10BinocDCBAGrp = vdo.createGroupForMultipleKeys('Day10 DCBA Binoc',animalKeys,...
    'day10',dcbaKeys,'RH');
day5MonocDCBATrGrp = vdo.createNewGroup('TRDay05 DCBA Monoc','VEPTraceGroupClass');
vdo.addMultipleKeysToGroup('TRDay05 DCBA Monoc',animalKeys,'day5','Dcba','LH');
day5BinocDCBATrGrp = vdo.createNewGroup('TRDay05 DCBA Binoc','VEPTraceGroupClass');
vdo.addMultipleKeysToGroup('TRDay05 DCBA Binoc',animalKeys,'day5','Dcba','RH');
day10MonocDCBATrGrp = vdo.createNewGroup('TRDay10 DCBA Monoc','VEPTraceGroupClass');
vdo.addMultipleKeysToGroup('TRDay10 DCBA Monoc',animalKeys,'day10','Dcba','LH');
day10BinocDCBATrGrp = vdo.createNewGroup('TRDay10 DCBA Binoc','VEPTraceGroupClass');
vdo.addMultipleKeysToGroup('TRDay10 DCBA Binoc',animalKeys,'day10','Dcba','RH');

%%

for day = days
    if day < 6
        normDay = 1;
    else
        normDay = 6;
    end
    vdo.normalizeByGroupMean(sprintf('Day%02i ABCD Monoc',day),sprintf('Day%02i ABCD Monoc',normDay));
    vdo.normalizeByGroupMean(sprintf('Day%02i ABCD Binoc',day),sprintf('Day%02i ABCD Binoc',normDay));
end
vdo.normalizeByGroupMean('Day05 DCBA Monoc','Day01 ABCD Monoc');
vdo.normalizeByGroupMean('Day05 DCBA Binoc','Day01 ABCD Binoc');
vdo.normalizeByGroupMean('Day10 DCBA Monoc','Day06 ABCD Monoc');
vdo.normalizeByGroupMean('Day10 DCBA Binoc','Day06 ABCD Binoc');

%% Launch a group data plot viewer and populate

fh1 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh1,...
  {'Day01 ABCD' 'Day05 ABCD' 'Day05 DCBA'});
GroupDataBarPlotter('newRow',fh1,...
  {'Monoc' 'Binoc'})
GroupDataBarPlotter('AutoFill',fh1)
GroupDataBarPlotter('SetPlotStyle',fh1,'Box')

%%
fh2 = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh2,...
  {'Day06 ABCD' 'Day10 ABCD' 'Day10 DCBA'});
GroupDataBarPlotter('newRow',fh2,...
  {'Monoc' 'Binoc'})
GroupDataBarPlotter('AutoFill',fh2)
GroupDataBarPlotter('SetPlotStyle',fh2,'Box')

%%
fh = figure;
violinPlotGroupData(monocABCDGrps{1},monocABCDGrps{5},...
    binocABCDGrps{1},binocABCDGrps{5},...
    day5MonocDCBAGrp,day5BinocDCBAGrp,'ClipRange',false,'Bandwidth',5);
savePlotToFile(fh,fullfile(figDir,'MonocBinoc_Day1Day5_Violin'),'-depsc');

%%
fh = figure;
violinPlotGroupData(monocABCDGrps{5},day5MonocDCBAGrp,...
    binocABCDGrps{10},day10BinocDCBAGrp,'ClipRange',false,'Normalize',true);
savePlotToFile(fh,fullfile(figDir,'MonocBinoc_Day1Day5_Fold_Violin'),'-depsc');

%%
fh = figure;
violinPlotGroupData(monocABCDGrps{6},monocABCDGrps{10},...
    binocABCDGrps{6},binocABCDGrps{10},...
    day10MonocDCBAGrp,day10BinocDCBAGrp,'ClipRange',false,'Bandwidth',30);
savePlotToFile(fh,fullfile(figDir,'MonocBinoc_Day6Day10_Violin'),'-depsc');

%%
fh = figure;
violinPlotGroupData(monocABCDGrps{5},day5MonocDCBAGrp,'ClipRange',false,'Bandwidth',10);
ylim([0 200])
savePlotToFile(fh,fullfile(figDir,'Violin_Monoc_ABCDvsDCBA'),'-depsc');

fh = figure;
violinPlotGroupData(binocABCDGrps{10},day10BinocDCBAGrp,'ClipRange',false,'Bandwidth',30);
ylim([0 600])
savePlotToFile(fh,fullfile(figDir,'Violin_Binoc_ABCDvsDCBA'),'-depsc');


%%

fh = figure;
[DAY1,~] = monocABCDTrGrps{1}.getMeanTrace;
[DAY5,tTr] = monocABCDTrGrps{5}.getMeanTrace;
phs = plot(1e3*tTr,DAY1,1e3*tTr,DAY5,'linewidth',2);
hold on
ylim(yScale);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Day01 ABCD','DAY05 ABCD');
title('Monoc');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figDir,'Monoc_Day1VsDay5_ABCD_Traces'),'-depsc');

fh = figure;
[ABCD,~] = monocABCDTrGrps{5}.getMeanTrace;
[DCBA,tTr] = day5MonocDCBATrGrp.getMeanTrace;
plot(1e3*tTr,ABCD,1e3*tTr,DCBA,'linewidth',2);
hold on
ylim(yScale);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Monoc ABCD','Monoc DCBA');
title('Day 05');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figDir,'Monoc_Day5_ABCDvsDCBA_Traces'),'-depsc');


fh = figure;
[ABCD,~] = monocABCDTrGrps{10}.getMeanTrace;
[DCBA,tTr] = day10MonocDCBATrGrp.getMeanTrace;
plot(1e3*tTr,ABCD,1e3*tTr,DCBA,'linewidth',2);
hold on
ylim(yScale);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Monoc ABCD','Monoc DCBA');
title('Day 10');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figDir,'Monoc_Day10_ABCDvsDCBA_Traces'),'-depsc');

%%


fh = figure;
[ABCD,~] = binocABCDTrGrps{5}.getMeanTrace;
[DCBA,tTr] = day5BinocDCBATrGrp.getMeanTrace;
plot(1e3*tTr,ABCD,1e3*tTr,DCBA,'linewidth',2);
hold on
ylim(yScale);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Binoc ABCD','Binoc DCBA');
title('Day 05');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figDir,'Binoc_Day5_ABCDvsDCBA_Traces'),'-depsc');

fh = figure;
[DAY6,~] = binocABCDTrGrps{6}.getMeanTrace;
[DAY10,tTr] = binocABCDTrGrps{10}.getMeanTrace;
plot(1e3*tTr,DAY6,1e3*tTr,DAY10,'linewidth',2);
hold on
ylim(yScale);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Day06 ABCD','DAY10 ABCD');
title('Binoc');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figDir,'Binoc_Day6VsDay10_ABCD_Traces'),'-depsc');

fh = figure;
[ABCD,~] = binocABCDTrGrps{10}.getMeanTrace;
[DCBA,tTr] = day10BinocDCBATrGrp.getMeanTrace;
plot(1e3*tTr,ABCD,1e3*tTr,DCBA,'linewidth',2);
hold on
ylim(yScale);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Binoc ABCD','Binoc DCBA');
title('Day 10');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figDir,'Binoc_Day10_ABCDvsDCBA_Traces'),'-depsc');



