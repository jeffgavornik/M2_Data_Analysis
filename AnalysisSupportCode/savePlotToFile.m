function savePlotToFile(hFig,fileName,figType)
if strcmp(figType,'-depsc')
    hFig.Renderer='Painters';
end
print(hFig,fileName,figType);