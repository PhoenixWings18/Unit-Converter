function [] = unitConverter()
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
    
    gui.convert = uicontrol('style','pushbutton','unit','normalized','position',[.37 .1 .25 .1],'string','Convert Units','callback', {@dispConversion});
   
    
end

function [] = radioSelect(~,~)

    global gui;
    
    input = gui.buttonGroupStart.SelectedObject.String;
    convertTo = gui.buttonGroupEnd.SelectedObject.String;
    num = str2num(gui.startNumber.String);
    
    compute = 0;
    
    if strcmp(input, 'Joules') && strcmp(convertTo, 'British Thermal Units')
        compute = num/1055.05585;
        
    elseif strcmp(input, 'Joules') && strcmp(convertTo, 'Tons of TNT')
        compute = num/4184000000;
        
    elseif strcmp(input, 'Pounds') && strcmp(convertTo, 'Newtons')
        compute = num/0.22480894244319;
        
    elseif strcmp(input, 'Pounds') && strcmp(convertTo, 'Kilograms')
        compute = (num/0.22480894244319)/9.81;
        
    elseif strcmp(input, 'Fahrenheit') && strcmp(convertTo, 'Celsius')
        compute = (num - 32)*(5/9);
        
    elseif strcmp(input, 'Fahrenheit') && strcmp(convertTo, 'Kelvin')
        compute = (num - 32)*(5/9) + 273.15;
   
    end
    
    gui.Conversion = num2str(compute);
    
end

function [] = dispConversion(~, ~)

    global gui;
    
    
     if isnan(str2double(gui.startNumber.String)) || (strlength(gui.startNumber.String) == 0)
        errordlg('Only real, rational numeric values are allowed. Please enter a number in the input box.', 'Error', 'modal');
        return;
        
     else
         
     end   
     
    inputVar = gui.buttonGroupStart.SelectedObject.String;
    convertTo = gui.buttonGroupEnd.SelectedObject.String;
    
    if strcmp(inputVar, 'Pounds') && ~(strcmp(convertTo, 'Newtons') || ...
            strcmp(convertTo, 'Kilograms'))
        errordlg('Input units cannot be converted to output units. Please select different output units.', 'Error', 'modal');
        return;
        
    elseif strcmp(inputVar, 'Fahrenheit') && ~(strcmp(convertTo, 'Kelvin') || ...
            strcmp(convertTo, 'Celsius'))
        errordlg('Input units cannot be converted to output units. Please select different output units.', 'Error', 'modal');
        return;
        
    elseif strcmp(inputVar, 'Joules') && ~(strcmp(convertTo, 'Tons of TNT') || ...
            strcmp(convertTo, 'British Thermal Units'))
        errordlg('Input units cannot be converted to output units. Please select different output units.', 'Error', 'modal');
        return;
    
    else   
    
    answer = str2num(gui.Conversion);
    
    answerString = [gui.startNumber.String, ' ', gui.buttonGroupStart.SelectedObject.String, ' equals ', ...
       answer, ' ', gui.buttonGroupEnd.SelectedObject.String, '.'];
   
    gui.answer = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.19 .23 .5 .1], 'string', answerString, 'horizontalalignment', 'right');

    end
    
end

%{
Unit-Converter.m and its associated files were made by Aussia Stander and 
Helen Philbrick in April-May 2021. You are free to use the code and its files 
as long as you make it better and give credit to us, its original authors, 
whenever and wherever it is reproduced.
%}