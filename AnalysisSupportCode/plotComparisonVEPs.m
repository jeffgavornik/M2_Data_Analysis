function fh = plotComparisonVEPs(tTr,stdData,devData,params,varargin)
 
% Plot VEPs for data in both stdData and devData
% Use stdStr and devStr to label plots in the legend
 
defaults.stdStr = sprintf('Std n=%i',size(stdData,2));
defaults.devStr = sprintf('Dev n=%i',size(devData,2));
setParameters(params,defaults);
 
% Open figure
fh = figure;
 
% Convert from cell array to numerical array
stdTraces = cell2mat(stdData);
devTraces = cell2mat(devData);
 
% Plot data and create legend
plot(tTr,mean(stdTraces,2),tTr,mean(devTraces,2),varargin{:});
legend(stdStr,devStr)

