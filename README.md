# Structural-Safety-of-Historical-Truss-Bridges-Input-Files
This repository contains supplementary materials and detailed information related to the finite element model analysis, conducted in AKMCS reliability study for the Hercilio Luz Bridge Access Span.

Content of each folder:

01 - FE_input.apdl (FEA Ansys input file)

02 - cmdansys.bat (Routine to initialize Ansys in batch file)

03 - LSF.m (Limit state function definition to be called by UQLab)

04 - results_AKMCS.mat (AKMCS analysis results. If results_AKMCS.mat.001 and results_AKMCS.mat002 is avaiable joint files using Winrar)

05 - PROPSEC.MAC (A macro that gives section properties for the APDL input file)

06 - uq_figure_1.fig (Convergence graph MATLAB figure)

07 - uq_figure_1.png (Convergence graph in PNG format)

08 - uq_readOuput.m (A routine that reads the meta-modeling response)

09 - variable.txt (Temporarily saves a realization for the random vector X)

10 - VariableToAPDL_R01.py (It reads the values for each X random vector realization and substitutes into the APDL input file)
