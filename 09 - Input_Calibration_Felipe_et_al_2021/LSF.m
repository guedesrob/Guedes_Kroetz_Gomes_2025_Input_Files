function Y = LSF (X)

% Writes the current variables to the file "variable.txt"
fileID = fopen('variable.txt', 'w');  % Open the file for writing
fprintf(fileID, '%d\n', X);  % Write the vector to the file, with each element on a new line
fclose(fileID);  % Close the file

% Writes to the APDL the values present in "variable.txt"
system('C:\Users\User\anaconda3\python.exe C:\AnsysWD\VariableToAPDL_R01.py');

% Runs Ansys
system('SET KMP_STACKSIZE=2048k & "C:\Program Files\ANSYS Inc\v194\ansys\bin\winx64\MAPDL.exe"  -p ansys -smp -np 6 -lch -dir "C:\AnsysWD" -j "zFelipe2021" -s read -l en-us -b -i "C:\AnsysWD\Felipe2021_R00.apdl" -o "C:\AnsysWD\zfile.out"');

% Retrieves the structural response from Ansys
Flimp = uq_readOutput('RESULTADOS.txt');
Fnum  = uq_readOutput('FNUM.txt');

% Define the Limit State Function
Y = Flimp - Fnum;

end
