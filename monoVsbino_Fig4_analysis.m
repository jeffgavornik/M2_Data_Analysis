analysisSetup;
dataDir = './Data/Mono vs Bino/';
figDir = './Figures/MonocBinoc Fig4 Results';
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
abcdKeys = abcdStims;
figType = '-depsc'; %'-djpeg';
clipRange = false; % for violin plots

%%
vdo.deleteAllGroups;

days = 1:10;

nAnimals = 8;
animalKeys = cell(1,nAnimals);
for day = 1:nAnimals
    animalKeys{day} = sprintf('An%i',day);
end

monocGrps = cell(1,10);
binocGrps = cell(1,10);
monocTrGrps = cell(1,10);
binocTrGrps = cell(1,10);

for day = days 
    dayKey = sprintf('day%i',day);
    monocGrpKey = sprintf('Day%02i ABCD Monoc',day);
    binocGrpKey = sprintf('Day%02i ABCD Binoc',day);
    monocGrps{day} = vdo.createGroupForMultipleKeys(monocGrpKey,...
        animalKeys,dayKey,abcdKeys,'LH');
    binocGrps{day} = vdo.createGroupForMultipleKeys(binocGrpKey,...
        animalKeys,dayKey,abcdKeys,'RH');
    
    monocTrGrps{day} = vdo.createNewGroup(['TR' monocGrpKey ],'VEPTraceGroupClass');
    vdo.addMultipleKeysToGroup(['TR' monocGrpKey ],animalKeys,dayKey,'Abcd','LH');
    binocTrGrps{day} = vdo.createNewGroup(['TR' binocGrpKey ],'VEPTraceGroupClass');
    vdo.addMultipleKeysToGroup(['TR' binocGrpKey ],animalKeys,...
        dayKey,'Abcd','RH');

end


for day = days
    if day < 6
        normDay = 1;
    else
        normDay = 6;
    end
    vdo.normalizeByGroupMean(sprintf('Day%02i ABCD Monoc',day),sprintf('Day%02i ABCD Monoc',normDay));
    vdo.normalizeByGroupMean(sprintf('Day%02i ABCD Binoc',day),sprintf('Day%02i ABCD Binoc',normDay));
end

%% Show data and export to CSV for stats
% Note: this is day 1-5 for monoc and 6-10 for binoc but labeled as 1-5 for
% both
normFlag = true;
if normFlag
    outName = 'MonoVsBinoc_Days1to5Vs6to10_Fold';
else
    outName = 'MonoVsBinoc_Days1to5Vs6to10_uV';
end
tableType = 'Columns';
fh = figure;
ah = axes('Parent',fh); 
dpo = dataPlotterClass; 
dpo.ah = ah;
grpKeys = cell(1,10);
colNames = cell(1,5);
for iD = 1:5
    colNames{iD} = char("Day"+num2str(iD));
    monoGrp = monocGrps{iD};
    [data,dataNorm] = monoGrp.getGroupData('AverageByAnimal'); %#ok<ASGLU>
    grpKeys{iD} = monoGrp.ID;
    if normFlag
        data = dataNorm;
    end
    dpo.addData('Mono',colNames{iD},data);
end
for iD = 6:10
    binocGrp = binocGrps{iD};
    [data,dataNorm] = binocGrp.getGroupData('AverageByAnimal'); %#ok<ASGLU>
    grpKeys{iD} = binocGrp.ID;
    if normFlag
        data = dataNorm;
    end
    dpo.addData('Binoc',colNames{iD-5},data);
end
dpo.titleStr = 'Monoc (1-5) Binoc (6-10)';
dpo.yLabelStr = outName(strfind(outName,'0_')+2:end);
dpo.setLegendLocation('eastoutside');
dpo.render; % actually plot the data
savePlotToFile(fh,fullfile(figDir,outName),figType);
fid = fopen(fullfile(figDir,[outName '.csv']),'w');
generateStatsTableForGroups(vdo,grpKeys(1:5),[],'monoc',true,normFlag,...
    'AverageByAnimal',true,fid,tableType,colNames);
generateStatsTableForGroups(vdo,grpKeys(6:10),[],'binoc',false,normFlag,...
    'AverageByAnimal',true,fid,tableType,colNames);
fclose(fid);

%%

fh = figure;
violinPlotGroupData(monocGrps{:},binocGrps{:},'ClipRange',clipRange,'Bandwidth',20);
title('MonocBinoc Day1to10');
ylabel('\muV')
savePlotToFile(fh,fullfile(figDir,'Violin_MonocBinoc_Day1to10_uV'),figType);

fh = figure;
violinPlotGroupData(monocGrps{1:5},'ClipRange',clipRange,'Bandwidth',13);
title('Monoc Day1to5');
ylabel('\muV')
savePlotToFile(fh,fullfile(figDir,'Violin_Monoc_Day1to5_uV'),figType);

fh = figure;
violinPlotGroupData(binocGrps{1:5},'ClipRange',clipRange,'Bandwidth',3);
title('Binoc Day1to5');
ylabel('\muV')
savePlotToFile(fh,fullfile(figDir,'Violin_Binoc_Day1to5_uV'),figType);

fh = figure;
violinPlotGroupData(monocGrps{6:10},'ClipRange',clipRange,'Bandwidth',13);
title('Monoc Day6to10');
ylabel('\muV')
savePlotToFile(fh,fullfile(figDir,'Violin_Monoc_Day6to10_uV'),figType);

fh = figure;
violinPlotGroupData(binocGrps{6:10},'ClipRange',clipRange,'Bandwidth',20);
title('Binoc Day6to10');
ylabel('\muV')
savePlotToFile(fh,fullfile(figDir,'Violin_Binoc_Day6to10_uV'),figType);

%%
violinArgs = {'ClipRange',clipRange,'Bandwidth',0.125};

fh = figure;
violinPlotGroupData('Normalize',true,monocGrps{:},binocGrps{:},violinArgs{:});
title('MonocBinoc Day1to10');
ylabel('Fold')
savePlotToFile(fh,fullfile(figDir,'Violin_MonocBinoc_Day1to10_Fold'),figType);

fh = figure;
violinPlotGroupData('Normalize',true,monocGrps{1:5},binocGrps{6:10},violinArgs{:});
title('MonocBinoc Day1to5*');
ylabel('Fold')
ylim([0 4])
savePlotToFile(fh,fullfile(figDir,'Violin_MonoVsBinoc_Days1to5Vs6to10_Fold'),figType);

fh = figure;
violinPlotGroupData('Normalize',true,monocGrps{1:5},violinArgs{:});
title('Monoc Day1to5');
ylabel('Fold')
ylim([0 4])
savePlotToFile(fh,fullfile(figDir,'Violin_Monoc_Day1to5_Fold'),figType);

fh = figure;
violinPlotGroupData('Normalize',true,binocGrps{1:5},violinArgs{:});
title('Binoc Day1to5');
ylabel('Fold')
savePlotToFile(fh,fullfile(figDir,'Violin_Binoc_Day1to5_Fold'),figType);

fh = figure;
violinPlotGroupData('Normalize',true,monocGrps{6:10},violinArgs{:});
title('Monoc Day6to10');
ylabel('Fold')
savePlotToFile(fh,fullfile(figDir,'Violin_Monoc_Day6to10_Fold'),figType);

fh = figure;
violinPlotGroupData('Normalize',true,binocGrps{6:10},violinArgs{:});
title('Binoc Day6to10');
ylabel('Fold')
savePlotToFile(fh,fullfile(figDir,'Violin_Binoc_Day6to10_Fold'),figType);


%%

fh = figure;
[DAY1,~] = monocTrGrps{1}.getMeanTrace;
[DAY5,tTr] = monocTrGrps{5}.getMeanTrace;
plot(1e3*tTr,DAY1,1e3*tTr,DAY5,'linewidth',2);
hold on
ylim(yScale);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Day01 ABCD','DAY05 ABCD');
title('Monoc');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figDir,'Monoc_Day1VsDay5_ABCD_Traces'),figType);

fh = figure;
[DAY6,~] = binocTrGrps{6}.getMeanTrace;
[DAY10,tTr] = binocTrGrps{10}.getMeanTrace;
plot(1e3*tTr,DAY6,1e3*tTr,DAY10,'linewidth',2);
hold on
ylim(yScale);
addMarkerSymbols(gca,stimXs,zeros(size(stimXs))-150,[0 0 0]);
legend('Day06 ABCD','DAY10 ABCD');
title('Binoc');
fh = prettyPlotFromExistingPlot(fh,true,[100 100],{'ms' '\muV'});
savePlotToFile(fh,fullfile(figDir,'Binoc_Day6VsDay10_ABCD_Traces'),figType);
