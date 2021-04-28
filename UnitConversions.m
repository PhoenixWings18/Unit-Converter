function [] = radioSelect(~,~)

    global gui;

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

    if gui.Text.String %if this has a letter
        errordlg('Only real, rational numeric values are allowed. Please enter a number in the input box', 'Error', 'modal');
        return;
    else
        number = str2num(gui.Text.String);
        conversion(number, inputVar, convertTo);
    end



end

function [] = conversion(number, inputVar, convertTo)

    global gui;
    
    if strcmp(inputVar, 'Joules (J)') && strcmp(convertTo, 'British Thermal Units (BTU)')
        compute = number/1055.05585;
    elseif strcmp(inputVar, 'Joules (J)') && strcmp(convertTo, 'Tons of TNT')
        compute = number/4184000000;
    elseif strcmp(inputVar, 'Pounds (lbs)') && strcmp(convertTo, 'Newtons (N)')
        compute = number/0.22480894244319;
    elseif strcmp(inputVar, 'Pounds (lbs)') && strcmp(convertTo, 'Kilograms (kg)')
        compute = (number/0.22480894244319)/9.81;
    elseif strcmp(inputVar, 'Fahrenheit (F)') && strcmp(convertTo, 'Celsius (C)')
        compute = (number - 32)*(5/9);
    elseif strcmp(inputVar, 'Fahrenheit (F)') && strcmp(convertTo, 'Kelvin (K)')
        compute = (number - 32)*(5/9) + 273.15;
    else 
        errordlg('Please select the input units and the desired conversion units', 'Error', 'modal');
    end
    
     dispConversion(compute);
     
end

%need to make sure the dispConversion can access the compute variable and
%be called by the gui function.

function [] = dispConversion(compute)
    global gui;
    

end
