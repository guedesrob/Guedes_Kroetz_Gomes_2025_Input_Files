function Y = LSF (X)
    global iter;
    format long;
    iter=iter+1

    %% First call of the LSF
    % Write the current variables in the file "variable.txt"
    fileID = fopen('variable.txt', 'w');            % Open the file for writing
    fprintf(fileID, '%d\n', X);                     % Write the vector to the file, with each element on a new line
    fclose(fileID);                                 % Close the file
    % Write in APDL the values ​​present in "variable.txt"
    system('"C:\Users\User\AppData\Local\Programs\Python\Python311\python.exe" "C:\AnsysWD\VariableToAPDL_R01.py"');
    % Execute Ansys
    system('SET KMP_STACKSIZE=2048k & "C:\Program Files\ANSYS Inc\v170\ansys\bin\winx64\MAPDL.exe"  -p ansys -np 8 -lch -dir "C:\AnsysWD" -j "zteste" -s read -l en-us -b -i "C:\AnsysWD\FE_input.apdl" -o "C:\AnsysWD\zteste"');
    % Recovers the structural response of ANSYS
    RESP_ESTR=uq_readOutput('DESL_MAX.txt');
    U=zeros(3,2);                                   % U_1 Initialization
    U(:,1)=RESP_ESTR(:,1);
    P=zeros(3,2);
    P(:,1)=X(17)+X(18)*(5.5880*1/2+5.5880*1/2);     % Total load P+Q

    %% Second Call of LSF
    X(17)=1.01*X(17);
    X(18)=1.01*X(18);
    % Write the current variables in the file "variable.txt"
    fileID = fopen('variable.txt', 'w');            % Open the file for writing
    fprintf(fileID, '%d\n', X);                     % Write the vector to the file, with each element on a new line
    fclose(fileID);                                 % Close the file
    % Write in APDL the values ​​present in "variable.txt"
    system('"C:\Users\User\AppData\Local\Programs\Python\Python311\python.exe" "C:\AnsysWD\VariableToAPDL_R01.py"');
    % Execute Ansys
    system('SET KMP_STACKSIZE=2048k & "C:\Program Files\ANSYS Inc\v170\ansys\bin\winx64\MAPDL.exe"  -p ansys -np 8 -lch -dir "C:\AnsysWD" -j "zteste" -s read -l en-us -b -i "C:\AnsysWD\FE_input.apdl" -o "C:\AnsysWD\zteste"');
    % Recovers the structural response of ANSYS
    RESP_ESTR=uq_readOutput('DESL_MAX.txt');
    U(:,2)=RESP_ESTR(:,1);
    P(:,2)=X(17)+X(18)*(5.5880*1/2+5.5880*1/2);     % Total load 1.01*(P+Q)
    Delta_P=P(:,2)-P(:,1);
    Delta_U=U(:,2)-U(:,1);

    %% PLOT P x U
    xplot_1=Delta_P/5e4;
    yplot_1=-Delta_U*100;

    %% GRAPH ANGLE P X U
    ANG=zeros(3,1);
    ANG=atand(yplot_1./xplot_1);
    
    %% Limit state function
    % Print Iter
    toc
    % Calculation of limit state function
    Y=X(19)*75-max(abs(ANG))
    end