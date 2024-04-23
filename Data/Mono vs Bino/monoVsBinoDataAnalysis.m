
% Monocular Data

dataDir = './';

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

stimMap = containers.Map;
stimMap('A') = 1;
stimMap('B') = 2;
stimMap('C') = 3;
stimMap('D') = 4;
stimMap('ABCD-Avg') = [1 2 3 4];

stimMap('D_') = 6;
stimMap('C_') = 7;
stimMap('B_') = 8;
stimMap('A_') = 9;
stimMap('DCBA-Avg') = [6 7 8 9];

stimMap('At') = 11;
stimMap('Bt') = 12;
stimMap('Ct') = 13;
stimMap('Dt') = 14;
stimMap('ABCDt-Avg') = [11 12 13 14];


vdo.stimDefs = stimMap;
vdo.dataExtractParams.extractTimeWindow = 0.6 %0.150;


for iF = 1:length(files)
    file = files(iF);
    vdo.addDataFromPlxFile(file.name,dataDir);
end

% Uncomment to include 600 ms sequence data
% stimMap = containers.Map;
% stimMap('ABCD') = 1;
% vdo.stimDefs = stimMap;
% vdo.dataExtractParams.extractTimeWindow = 0.6;
% 
% for iF = 1:length(files)
%     file = files(iF);
%     vdo.addDataFromPlxFile(file.name,dataDir);
% end



%%


plotWaveforms = false;  %#ok<*UNRCH>

vdo.deleteAllGroups;

% Define the relevant groups for animals with monoc = LH and binoc = RH

nAnimals = 8;
animals = cell(1,nAnimals);
for day = 1:nAnimals
    animals{day} = sprintf('An%i',day);
end

if plotWaveforms
    stimKeys = {'A'}; 
    dcbaKeys = {'D_'};
    abcdtKeys = {'At'};
else
    stimKeys = {'ABCD-Avg'};
    dcbaKeys = {'DCBA-Avg'};
    abcdtKeys = {'ABCDt-Avg'};
end

day1Monoc = vdo.createGroupForMultipleKeys('Day 1 ABCD Monoc',animals,...
    'day1',stimKeys,'LH');
day1Binoc = vdo.createGroupForMultipleKeys('Day 1 ABCD Binoc',animals,...
    'day1',stimKeys,'RH');
day2Monoc = vdo.createGroupForMultipleKeys('Day 2 ABCD Monoc',animals,...
    'day2',stimKeys,'LH');
day2Binoc = vdo.createGroupForMultipleKeys('Day 2 ABCD Binoc',animals,...
    'day2',stimKeys,'RH');
day3Monoc = vdo.createGroupForMultipleKeys('Day 3 ABCD Monoc',animals,...
    'day3',stimKeys,'LH');
day3Binoc = vdo.createGroupForMultipleKeys('Day 3 ABCD Binoc',animals,...
    'day3',stimKeys,'RH');
day4Monoc = vdo.createGroupForMultipleKeys('Day 4 ABCD Monoc',animals,...
    'day4',stimKeys,'LH');
day4Binoc = vdo.createGroupForMultipleKeys('Day 4 ABCD Binoc',animals,...
    'day4',stimKeys,'RH');
day5Monoc = vdo.createGroupForMultipleKeys('Day 5 ABCD Monoc',animals,...
    'day5',stimKeys,'LH');
day5Binoc = vdo.createGroupForMultipleKeys('Day 5 ABCD Binoc',animals,...
    'day5',stimKeys,'RH');

day5MonocDCBA = vdo.createGroupForMultipleKeys('Day 5 DCBA Monoc',animals,...
    'day5',dcbaKeys,'LH');
day5BinocDCBA = vdo.createGroupForMultipleKeys('Day 5 DCBA Binoc',animals,...
    'day5',dcbaKeys,'RH');

day5MonocABCDt = vdo.createGroupForMultipleKeys('Day 5 NovT Monoc',animals,...
    'day5',abcdtKeys,'LH');
day5BinocABCDt = vdo.createGroupForMultipleKeys('Day 5 NovT Binoc',animals,...
    'day5',abcdtKeys,'RH');

day6Binoc = vdo.createGroupForMultipleKeys('Day 6 ABCD Monoc',animals,...
    'day6',stimKeys,'LH');
day7Binoc = vdo.createGroupForMultipleKeys('Day 7 ABCD Monoc',animals,...
    'day7',stimKeys,'LH');
day8Binoc = vdo.createGroupForMultipleKeys('Day 8 ABCD Monoc',animals,...
    'day8',stimKeys,'LH');
day9Binoc = vdo.createGroupForMultipleKeys('Day 9 ABCD Monoc',animals,...
    'day9',stimKeys,'LH');
day10Binoc = vdo.createGroupForMultipleKeys('Day 10 ABCD Monoc',animals,...
    'day10',stimKeys,'LH');
day6Binoc = vdo.createGroupForMultipleKeys('Day 6 ABCD Binoc',animals,...
    'day6',stimKeys,'RH');
day7Binoc = vdo.createGroupForMultipleKeys('Day 7 ABCD Binoc',animals,...
    'day7',stimKeys,'RH');
day8Binoc = vdo.createGroupForMultipleKeys('Day 8 ABCD Binoc',animals,...
    'day8',stimKeys,'RH');
day9Binoc = vdo.createGroupForMultipleKeys('Day 9 ABCD Binoc',animals,...
    'day9',stimKeys,'RH');
day10Binoc = vdo.createGroupForMultipleKeys('Day 10 ABCD Binoc',animals,...
    'day10',stimKeys,'RH');

day10MonocDCBA = vdo.createGroupForMultipleKeys('Day 10 DCBA Monoc',animals,...
    'day10',dcbaKeys,'LH');
day10BinocDCBA = vdo.createGroupForMultipleKeys('Day 10 DCBA Binoc',animals,...
    'day10',dcbaKeys,'RH');

day10MonocABCDt = vdo.createGroupForMultipleKeys('Day 10 NovT Monoc',animals,...
    'day10',abcdtKeys,'LH');
day10BinocABCDt = vdo.createGroupForMultipleKeys('Day 10 NovT Binoc',animals,...
    'day10',abcdtKeys,'RH');

for day = 1:10
    if day < 6
        normDay = 1;
    else
        normDay = 6;
    end
    vdo.normalizeByGroupMean(sprintf('Day %i ABCD Monoc',day),sprintf('Day %i ABCD Monoc',normDay));
    vdo.normalizeByGroupMean(sprintf('Day %i ABCD Binoc',day),sprintf('Day %i ABCD Binoc',normDay));
end


%%
fh = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh,...
    {'Day 1 ABCD' 'Day 2 ABCD' 'Day 3 ABCD' 'Day 4 ABCD' 'Day 5 ABCD'});
GroupDataBarPlotter('newRow',fh,...
    {'Monoc','Binoc'})
GroupDataBarPlotter('AutoFill',fh)


%%
fh = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh,...
    {'Day 6 ABCD' 'Day 7 ABCD' 'Day 8 ABCD' 'Day 9 ABCD' 'Day 10 ABCD'});
GroupDataBarPlotter('newRow',fh,...
    {'Monoc','Binoc'})
GroupDataBarPlotter('AutoFill',fh)


%%
fh = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh,...
    {'Day 6' 'Day 7' 'Day 8' 'Day 9' 'Day 10'});
GroupDataBarPlotter('newRow',fh,...
    {'Binoc'})
GroupDataBarPlotter('AutoFill',fh)


%%

for day = [5 10]
    vdo.normalizeByGroupMean(sprintf('Day %i ABCD Monoc',day),sprintf('Day %i ABCD Monoc',day));
    vdo.normalizeByGroupMean(sprintf('Day %i ABCD Binoc',day),sprintf('Day %i ABCD Binoc',day));
    vdo.normalizeByGroupMean(sprintf('Day %i DCBA Monoc',day),sprintf('Day %i ABCD Monoc',day));
    vdo.normalizeByGroupMean(sprintf('Day %i DCBA Binoc',day),sprintf('Day %i ABCD Binoc',day));
    vdo.normalizeByGroupMean(sprintf('Day %i NovT Monoc',day),sprintf('Day %i ABCD Monoc',day));
    vdo.normalizeByGroupMean(sprintf('Day %i NovT Binoc',day),sprintf('Day %i ABCD Binoc',day));
end

%%
fh = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh,...
    {'Day 5 ABCD','Day 5 DCBA','Day 5 NovT'});
GroupDataBarPlotter('newRow',fh,...
    {'Monoc','Binoc'})
GroupDataBarPlotter('AutoFill',fh)

%%
fh = GroupDataBarPlotter(vdo);
GroupDataBarPlotter('newColumn',fh,...
    {'Day 10 ABCD','Day 10 DCBA','Day 10 NovT'});
GroupDataBarPlotter('newRow',fh,...
    {'Monoc','Binoc'})
GroupDataBarPlotter('AutoFill',fh)

