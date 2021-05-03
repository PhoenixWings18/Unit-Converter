function [] = unitConverter()
%This is the main GUI function which initalizes the GUI figure
    
    %Close all open figures to clear any MATLAB desktop clutter
    close all;

    %Declare global variable
    global gui;

    gui.fig = figure('numbertitle','off','name','Unit Converter');
    
    %Editable text box for number input, calls on radioSelect to perform
    %conversions whenever a value is typed into it
    gui.startNumber = uicontrol('style','edit','unit','normalized','position',[.01 .7 .17 .1], 'callback', {@radioSelect});
    
    %Non-editable text box between radiobutton groups for asthetic
    gui.textBox = uicontrol('style','text','unit','normalized','position',[.25 .25 .5 .5],'string','Convert to');
    
    %First radiobutton group of possible input units
    gui.buttonGroupStart = uibuttongroup('visible','on','unit','normalized','position',[.2 .5 .2 .5],'selectionchangedfcn',{@radioSelect});
    gui.startUnit(1) = uicontrol(gui.buttonGroupStart,'style','radiobutton','unit','normalized','position',[.1 .6 1 .1],'string','Fahrenheit (F)');
    gui.startUnit(2) = uicontrol(gui.buttonGroupStart,'style','radiobutton','unit','normalized','position',[.1 .5 1 .1],'string','Joules (J)');
    gui.startUnit(3) = uicontrol(gui.buttonGroupStart,'style','radiobutton','unit','normalized','position',[.1 .4 1 .1],'string','Pounds (lbs)');

    %Second radiobutton group of possible output units
    gui.buttonGroupEnd = uibuttongroup('visible','on','unit','normalized','position',[.6 .5 .30 .5],'selectionchangedfcn',{@radioSelect});
    gui.endUnit(1) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .7 1 .1],'string','Celsius (C)');
    gui.endUnit(2) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .6 1 .1],'string','Kelvin (K)');
    gui.endUnit(3) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .5 1 .1],'string','British Thermal Units (BTU)');
    gui.endUnit(4) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .4 1 .1],'string','Tons of TNT');
    gui.endUnit(5) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .3 1 .1],'string','Newtons (N)');
    gui.endUnit(6) = uicontrol(gui.buttonGroupEnd,'style','radiobutton','unit','normalized','position',[.1 .2 1 .1],'string','Kilograms (kg)');

    %pushbutton to perform conversion
    gui.convert = uicontrol('style','pushbutton','unit','normalized','position',[.37 .1 .25 .1],'string','Convert Units','callback', {@dispConversion});

end

function [] = radioSelect(~,~)
%This function is called whenever a radiobutton is selected or text is typed into the editbox.
%It performs the mathematics of the unit conversion

    %Declare access to global variable gui
    global gui;
    
    %Get input variable string from selected radiobutton in radiobutton group 1
    input = gui.buttonGroupStart.SelectedObject.String;
    
    %Get output variable string from selected radiobutton in radiobutton
    %group 2
    convertTo = gui.buttonGroupEnd.SelectedObject.String;
    
    %Get input number string from editable text box and convert it to a
    %number (performed regardless of numeric or alphabetic input for simplicity's 
    %sake and to avoid crashes)
    num = str2double(gui.startNumber.String);
    
    %Initalize answer variable compute
    compute = 0;

    %Perform conversion based on the input and output variable selected
    if strcmp(input, 'Joules (J)') && strcmp(convertTo, 'British Thermal Units (BTU)')
        compute = num/1055.05585;

    elseif strcmp(input, 'Joules (J)') && strcmp(convertTo, 'Tons of TNT')
        compute = num/4184000000;

    elseif strcmp(input, 'Pounds (lbs)') && strcmp(convertTo, 'Newtons (N)')
        compute = num/0.22480894244319;

    elseif strcmp(input, 'Pounds (lbs)') && strcmp(convertTo, 'Kilograms (kg)')
        compute = (num/0.22480894244319)/9.81;

    elseif strcmp(input, 'Fahrenheit (F)') && strcmp(convertTo, 'Celsius (C)')
        compute = (num - 32)*(5/9);

    elseif strcmp(input, 'Fahrenheit (F)') && strcmp(convertTo, 'Kelvin (K)')
        compute = (num - 32)*(5/9) + 273.15;

    end
    
    %Convert numeric answer to a string and store as a structure in the
    %global variable for easy access later
    gui.Conversion = num2str(compute);

    %Prepare answer string to display when convert pushbutton is pressed
    %based on units selected (makes it gramatically correct when
    %temperatures are selected) and store it a new structure in the global
    %variable
    if strcmp(input, 'Fahrenheit (F)') && strcmp(convertTo,'Celsius (C)')

        gui.answerString = ['Answer: ', gui.startNumber.String, ' degrees ', gui.buttonGroupStart.SelectedObject.String, ' equals ', ...
            gui.Conversion, ' degrees ', gui.buttonGroupEnd.SelectedObject.String, '.'];

    elseif strcmp(input, 'Fahrenheit (F)') && strcmp(convertTo,'Kelvin (K)')

        gui.answerString = ['Answer: ', gui.startNumber.String, ' degrees ', gui.buttonGroupStart.SelectedObject.String, ' equals ', ...
            gui.Conversion, ' ', gui.buttonGroupEnd.SelectedObject.String, '.'];

    else

        gui.answerString = ['Answer: ', gui.startNumber.String, ' ', gui.buttonGroupStart.SelectedObject.String, ' equals ', ...
            gui.Conversion, ' ', gui.buttonGroupEnd.SelectedObject.String, '.'];

    end

end

function [] = dispConversion(~, ~)
%This function displays the performed conversion if the conversion is valid
%and is called by the pushbutton
    
    %Declare access to global variable gui
    global gui;
    
    %Prepare a new, blank structure to display the answer
    gui.answer = uicontrol('style', 'text', 'units', 'normalized', 'position',...
        [.12 .2 .75 .2], 'string', '');

    %Before the answer is displayed, first check if the editbox was empty or
    %contained a letter. If it did, clear the editbox, display an error message, and start over
    if isnan(str2double(gui.startNumber.String)) || (strlength(gui.startNumber.String) == 0)
        
        errordlg('Only real, rational numeric inputs are allowed. Please enter a number in the input box.', 'Error', 'modal');
        
        gui.startNumber.String = '';
        
        return;

    else

    end

    %For ease of codewriting, save the input units and the output units to
    %the variables inputVar and convertTo, respectively
    inputVar = gui.buttonGroupStart.SelectedObject.String;
    convertTo = gui.buttonGroupEnd.SelectedObject.String;

    %Before the conversion is displayed, next check to see if the desired
    %conversion is valid. If it is not (i.e. trying to convert units of
    %energy to units of mass), display an error message and start over, but
    %do not clear the editbox
    if strcmp(inputVar, 'Pounds (lbs)') && ~(strcmp(convertTo, 'Newtons (N)') || ...
            strcmp(convertTo, 'Kilograms (kg)'))
        
        errordlg('Input units cannot be converted to output units. Please select different output units.', 'Error', 'modal');
        
        return;

    elseif strcmp(inputVar, 'Fahrenheit (F)') && ~(strcmp(convertTo, 'Kelvin (K)') || ...
            strcmp(convertTo, 'Celsius (C)'))
        
        errordlg('Input units cannot be converted to output units. Please select different output units.', 'Error', 'modal');
        
        return;

    elseif strcmp(inputVar, 'Joules (J)') && ~(strcmp(convertTo, 'Tons of TNT') || ...
            strcmp(convertTo, 'British Thermal Units (BTU)'))
        
        errordlg('Input units cannot be converted to output units. Please select different output units.', 'Error', 'modal');
        
        return;

    else

    end

    %Display the answer using the prepared answer string from radioSelect 
    gui.answer.String = gui.answerString;

end

%{
unitConverter.m and its associated files were created by Aussia Stander and 
Helen Philbrick in April-May 2021. You are free to use this code and its associated files 
as long as you make it better and give credit to us, its original authors, 
whenever and wherever it is reproduced.
%}