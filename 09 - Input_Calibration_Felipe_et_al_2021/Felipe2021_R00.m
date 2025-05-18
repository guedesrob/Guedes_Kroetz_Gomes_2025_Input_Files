%% NONLINEAR VON MISES TRUS RELIABILITY EXAMPLE
% BASED ON FELIPE ET. AL 2021
% Doi: 10.1590/s1983-41952021000400002

%% 1 - INITIALIZE UQLAB
%
% Clear all variables from the workspace, set the random number generator
% for reproducible results, and initialize the UQLab framework:
tic         % Starts the time counter
clearvars
rng(1,'twister')
uqlab

%% 2. My Limit State Function
modelOpts.mFile = 'LSF'; % g(X) = LambPlim - 1
modelOpts.isVectorized = false;
ModelOpts.Format = {'%1.8f'};
% ModelOpts.Display = 'verbose';
myModel = uq_createModel(modelOpts);
%

%% 3 - PROBABILISTIC INPUT MODEL
% variables:
% E
InputOpts.Marginals(1).Name     = ['X', num2str(1)];
InputOpts.Marginals(1).Type     = 'Lognormal';
InputOpts.Marginals(1).Moments  = 205E9*[1 .03];
% % Sigy
InputOpts.Marginals(2).Name     = ['X', num2str(2)];
InputOpts.Marginals(2).Type     = 'Lognormal';
InputOpts.Marginals(2).Moments  = 100E6*[1 .07];
% A0
InputOpts.Marginals(3).Name    = ['X', num2str(3)];
InputOpts.Marginals(3).Type    = 'Gaussian';
InputOpts.Marginals(3).Moments = 1.01*78.5E-4*[1 .04];
% R
InputOpts.Marginals(4).Name    = ['X', num2str(4)];
InputOpts.Marginals(4).Type    = 'Gaussian';
InputOpts.Marginals(4).Moments = .05*[1 .02];
% X0
InputOpts.Marginals(5).Name    = ['X', num2str(5)];
InputOpts.Marginals(5).Type    = 'Gaussian';
InputOpts.Marginals(5).Moments = 2*[1 .02];
% Y0
InputOpts.Marginals(6).Name    = ['X', num2str(6)];
InputOpts.Marginals(6).Type    = 'Gaussian';
InputOpts.Marginals(6).Moments = .1*[1 .02];

% E
InputOpts.Marginals(7).Name     = ['X', num2str(7)];
InputOpts.Marginals(7).Type     = 'Lognormal';
InputOpts.Marginals(7).Moments  = 205E9*[1 .03];
% % Sigy
InputOpts.Marginals(8).Name     = ['X', num2str(8)];
InputOpts.Marginals(8).Type     = 'Lognormal';
InputOpts.Marginals(8).Moments  = 100E6*[1 .07];
% A0
InputOpts.Marginals(9).Name    = ['X', num2str(9)];
InputOpts.Marginals(9).Type    = 'Gaussian';
InputOpts.Marginals(9).Moments = 1.01*78.5E-4*[1 .04];
% R
InputOpts.Marginals(10).Name    = ['X', num2str(10)];
InputOpts.Marginals(10).Type    = 'Gaussian';
InputOpts.Marginals(10).Moments = .05*[1 .02];
% X0
InputOpts.Marginals(11).Name    = ['X', num2str(11)];
InputOpts.Marginals(11).Type    = 'Gaussian';
InputOpts.Marginals(11).Moments = 2*[1 .02];
% Y0
InputOpts.Marginals(12).Name    = ['X', num2str(12)];
InputOpts.Marginals(12).Type    = 'Gaussian';
InputOpts.Marginals(12).Moments = .1*[1 .02];

% Create the INPUT object
myInput = uq_createInput(InputOpts);
%

%% 4 - RELIABILITY ANALYSIS USING AK-MCS
%
% Select the reliability analysis technique:
AKOptions.Type = 'Reliability';
AKOptions.Method = 'AKMCS';

%
% Run the analysis:
AKAnalysis = uq_createAnalysis(AKOptions);

%
% Print out a report of the analysis:
uq_print(AKAnalysis)
uq_print(AKAnalysis.Results.Kriging)

%
% Create a graphical representation of the results:
uq_display(AKAnalysis)

%
elapsed_time = toc;         % Stops the timer and obtains the elapsed time in seconds
elapsed_time_in_minutes = elapsed_time / 60;   % Converts the elapsed time to minutes
disp(['Elapsed time: ', num2str(elapsed_time_in_minutes), ' minutes']);
