function[] = unitConvert()
    close all;
    global gui;
    gui.fig = figure('numbertitle','off','name','Unit Converter');
    
    gui.startNumber = uicontrol('style','edit','unit','normalized','position',[.01 .7 .17 .1]);
    gui.textBox = uicontrol('style','text','unit','normalized','position',[.25 .25 .5 .5],'string','Convert to');
    
    gui.buttonGroupStart = uibuttongroup('visible','on','unit','normalized','position',[.2 .5 .2 .5],'selectionchangedfcn',{@radioSelect}); 
    gui.startUnit(1) = uicontrol(gui.buttonGroupStart,'style','radiobutton','unit','normalized','position',[.1 .6 1 .1],'string','Fahrenheit');
    gui.startUnit(2) = uicontrol(gui.buttonGroupStart,'style','radiobutton','unit','normalized','position',[.1 .5 1 .1],'string','Joules');
    gui.startUnit(3) = uicontrol(gui.buttonGroupStart,'style','radiobutton','unit','normalized','position',[.1 .4 1 .1],'string','Pounds');
    
    gui.buttonGroupEnd = uibuttongroup('visible','on','unit','normalized','position',[.6 .5 .30 .5],'selectionchangedfcn',{@radioSelect});
    gui.endUnit(1) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .7 1 .1],'string','Celsius');
    gui.endUnit(2) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .6 1 .1],'string','Kelvin');
    gui.endUnit(3) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .5 1 .1],'string','British Thermal Units');
    gui.endUnit(4) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .4 1 .1],'string','Tons of TNT');
    gui.endUnit(5) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .3 1 .1],'string','Newtons');
    gui.endUnit(6) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .2 1 .1],'string','Kilograms');
    
    gui.convert = uicontrol('style','pushbutton','unit','normalized','position',[.37 .1 .25 .1],'string','Convert Units','callback', {@event});
end