function params = setParameters(overrides,defaults)
% Create variables in caller's worskpace to instantiate parameters
% If a field in defaults is also present as a field in overrides, the value
% from overrides is used
% If a field only exists for overrides, it is used
% If output variable is defined, will return a structure with the correct
% fields
%
% Hacky solution to non-supported data types works if the name of the
% variable passed to this function are 'params' and 'defaults' in the
% calling workspace
 
if nargout == 0
    setVariable = true;
else
    setVariable = false;
    params = struct;
end
 
paramFields = fields(defaults);
for iP=1:length(paramFields)
    paramField = paramFields{iP};
    if isfield(overrides,paramField)
        varName = 'params'; % guess name for non-supported types
        value = overrides.(paramField);
    else
        varName = 'defaults'; % guess name for non-supported types
        value = defaults.(paramField);
    end
    if setVariable
        valueStr = '';
        switch class(value)
            case 'double'
                valueStr = makeDoubleString(value);
            case 'char'
                valueStr = ['''' value ''''];
            case 'logical'
                if value
                    valueStr = 'true';
                else
                    valueStr = 'false';
                end
            otherwise
                warning('%s: can not set variable for field class %s',mfilename,class(value));
        end
        if isempty(valueStr)
            evalin('caller',sprintf('%s = %s.%s;',paramField,varName,paramField));
        else
            % fprintf('%s = %s;',paramField,valueStr);
            evalin('caller',sprintf('%s = %s;',paramField,valueStr));
        end
    else
        params.(paramField) = value;
    end
    if isfield(overrides,paramField)
        overrides = rmfield(overrides,paramField);
    end
end
 
paramFields = fields(overrides);
for iP=1:length(paramFields)
    paramField = paramFields{iP};
    value = overrides.(paramField);
    if setVariable
        valueStr = '';
        switch class(value)
            case 'double'
                valueStr = makeDoubleString(value);
            case 'char'
                valueStr = ['''' value ''''];
            case 'logical'
                if value
                    valueStr = 'true';
                else
                    valueStr = 'false';
                end
            otherwise
                warning('%s: can not set variable for field class %s',mfilename,class(value));
        end
        if isempty(valueStr)
            evalin('caller',sprintf('%s = params.%s;',paramField,paramField));
        else
            evalin('caller',sprintf('%s = %s;',paramField,valueStr));
        end
    else
        params.(paramField) = value;
    end
end
 
function valueStr = makeDoubleString(value)
if isempty(value)
    valueStr = '[]';
else
    valueStr = '[';
    [rows,cols] = size(value);
    for row = 1:rows
        for col = 1:cols
            valueStr = sprintf('%s%s,',valueStr,num2str(value(row,col)));
        end
        valueStr(end) = ';';
    end
    valueStr(end) = ']';
end
 
% paramFields = fields(defaults);
% for iP=1:length(paramFields)
%     paramField = paramFields{iP};
%     if isfield(overrides,paramField)
%         varName = 'params';
%     else
%         varName = 'defaults';
%     end
%     evalin('caller',sprintf('%s = %s.%s;',paramField,varName,paramField));
%     if isfield(overrides,paramField)
%         overrides = rmfield(overrides,paramField);
%     end
% end
% 
% paramFields = fields(overrides);
% for iP=1:length(paramFields)
%     paramField = paramFields{iP};
%     evalin('caller',sprintf('%s = params.%s;',paramField,paramField));
% end