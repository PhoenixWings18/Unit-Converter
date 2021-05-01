function [] = radioSelect(~,~)

    global gui;
    
%Need to find out if return or break is the correct command to use.

    inputVar = gui.buttonGroup1.SelectedObject.String;
    convertTo = gui.buttonGroup2.SelectedObject.String;

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
    end

    if isnan(str2double(gui.Text.String)) || gui.Text.String == ''
        errordlg('Only real, rational numeric values are allowed. Please enter a number in the input box.', 'Error', 'modal');
        return;
        
    else
        number = str2double(gui.Text.String);
        conversion(number, inputVar, convertTo);
    end

end

function [] = conversion(number, inputVar, convertTo)

    global gui; 
    
    %Do I need to restate the input variables to this function, or will it
    %just work? Need to test this with the completed GUI_Control.
    
    if strcmp(inputVar, 'Joules') && strcmp(convertTo, 'British Thermal Units')
        compute = number/1055.05585;
        
    elseif strcmp(inputVar, 'Joules') && strcmp(convertTo, 'Tons of TNT')
        compute = number/4184000000;
        
    elseif strcmp(inputVar, 'Pounds') && strcmp(convertTo, 'Newtons')
        compute = number/0.22480894244319;
        
    elseif strcmp(inputVar, 'Pounds') && strcmp(convertTo, 'Kilograms')
        compute = (number/0.22480894244319)/9.81;
        
    elseif strcmp(inputVar, 'Fahrenheit') && strcmp(convertTo, 'Celsius')
        compute = (number - 32)*(5/9);
        
    elseif strcmp(inputVar, 'Fahrenheit') && strcmp(convertTo, 'Kelvin')
        compute = (number - 32)*(5/9) + 273.15;
        
    else 
        errordlg('Please select the input units and the desired conversion units', 'Error', 'modal');
   
    end
    
     dispConversion(compute);
     
end

%{
Need to make sure the dispConversion can access the compute variable and
be called by the gui function, then display the result in the non-editable text box
when the pushbutton "convert" is pressed. 
%}

function [] = dispConversion(~, ~, compute)

    global gui;
    
    answerString = [gui.Text.String, ' ', gui.buttonGroup1.SelectedObject.String, ' equals ', ...
       compute, ' ', gui.buttonGroup2.SelectedObject.String, '.'];
   
    gui.answer = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.15 .78 .5 .05], 'string', answerString, 'horizontalalignment', 'right');
    

end

%{
Unit-Converter.m and its associated files were made by Aussia Stander and 
Helen Philbrick in April-May 2021. You are free to use the code and its files 
as long as you make it better and give credit to us, its original authors, 
whenever and wherever it is reproduced.
%}