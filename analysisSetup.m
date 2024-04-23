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

% Make sure plot support code is in the path
addpath('./AnalysisSupportCode');
