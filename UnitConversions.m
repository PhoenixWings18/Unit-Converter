function [] = radioSelect(~,~)

    global gui;
%Need to find out if return or break is the correct command to use.
    
    inputVar = gui.buttonGroup1.SelectedObject.String;
    convertTo = gui.buttonGroup2.SelectedObject.String;

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
    
    if strcmp(inputVar, 'Joules (J)') & strcmp(convertTo, 'British Thermal Units (BTU)')
        compute = number/1055.05585;
    elseif strcmp(inputVar, 'Joules (J)') & strcmp(convertTo, 'Tons of TNT')
        compute = number/4184000000;
    elseif strcmp(inputVar, 'Pounds (lbs)') & strcmp(convertTo, 'Newtons (N)')
        compute = number/0.22480894244319;
    elseif strcmp(inputVar, 'Pounds (lbs)') & strcmp(convertTo, 'Kilograms (kg)')
        compute = (number/0.22480894244319)/9.81;
    elseif strcmp(inputVar, 'Fahrenheit (F)') & strcmp(convertTo, 'Celsius (C)')
        compute = (number - 32)*(5/9);
    elseif strcmp(inputVar, 'Fahrenheit (F)') & strcmp(convertTo, 'Kelvin (K)')
        compute = (number - 32)*(5/9) + 273.15;
    else 
        errordlg('Please select the input units and the desired conversion units', 'Error', 'modal');
    end
    
     dispConversion(compute);
     
end

%Need to make sure the dispConversion can access the compute variable and
%be called by the gui function, then display the result in the non-editable text box
%when the pushbutton "convert" is pressed. Will need to see the pushbutton
%function in the GUI before I can write this.

function [] = dispConversion(~, ~, compute)
    global gui;
    
    initialNumber = gui.Text.String;
    initalUnit = gui.buttonGroup1.SelectedObject.String;
    convertUnit = gui.buttonGroup2.SelectedObject.String;
    answerString = ;
    gui.answer = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.15 .78 .5 .05], 'string', answerString, 'horizontalalignment', 'right');
    

end
