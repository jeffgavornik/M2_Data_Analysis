function [traces,tTr] = getTracesForFiles(files,stimValue,extractTimeWindow)
 
nF = length(files);
traces = cell(1,nF);
for iF = 1:nF
    data = simplePlxReader(fullfile(files(iF).folder,files(iF).name));
    [theTraces,tTr] = extractEventTriggeredTraces(...
        data.eventTimestamps(data.eventValues == stimValue),data.adData(files(iF).channelNumber,:),...
        data.adTimestamps,extractTimeWindow);
    traces{iF} = 1e3*theTraces;
end