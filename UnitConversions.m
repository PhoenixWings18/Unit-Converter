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
    
    %Do I need to restate the input variables to this function, or will it
    %just work? Need to test this with the completed GUI_Control.
    
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

%{
Need to make sure the dispConversion can access the compute variable and
be called by the gui function, then display the result in the non-editable text box
when the pushbutton "convert" is pressed. Will need to see the pushbutton
function in the GUI before I can write this. 

Note: DO NOT create a non-editable text box in the GUI! It will not appear until the button is
pushed, the whole point of dispConversion is to display it after the
button is pushed.
%}

function [] = dispConversion(~, ~, compute)

    global gui;
    
    answerString = [gui.Text.String, ' ', gui.buttonGroup1.SelectedObject.String, ' equals ', ...
       compute, ' ', gui.buttonGroup2.SelectedObject.String, '.'];
   
    gui.answer = uicontrol('style', 'text', 'units', 'normalized', 'position',...
    [.15 .78 .5 .05], 'string', answerString, 'horizontalalignment', 'right');
    

end
