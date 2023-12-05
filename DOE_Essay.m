%--------------------------------Input---------------------------------
%------------------------------------------------------------------------
% Define minimum, average, and maximum values for each variable
Tamb = [266, 280, 294]; %is the ambient temperature [K]
Beta = [16, 20, 24]; % is the pressure ratio [-]
TIT = [1040, 1300, 1560]; %is the turbine inlet temperature (or combustor exit) [K]

% Create all possible combinations of variable values
[XX, YY, ZZ] = meshgrid(Tamb, Beta, TIT);

% Arrange variable values in vector form
x1 = XX(:);
x2 = YY(:);
x3 = ZZ(:);

% Plot factorial design - inputs
subplot(1, 2, 1);
scatter3(x1, x2, x3, 100, 'filled');
xlabel('Tamb');
ylabel('Beta');
zlabel('TIT');
title('Input Factors');
colorbar;


%--------------------------------Output---------------------------------
%------------------------------------------------------------------------
% Calculate response values 
y_values = x1 + x2 - x3; 

% Plot response values
subplot(1, 2, 2);
scatter3(x1, x2, x3, 100, y_values, 'filled'); % Color based on response values
xlabel('Tamb');
ylabel('Beta');
zlabel('TIT');
title('Response Values');
colorbar;
%------------------------------------------------------------------------
%------------------------------------------------------------------------


% Calculate the number of different cases
num_cases = numel(x1);
disp(['Number of different cases: ', num2str(num_cases)]);

% Response values (here, a constant value is considered for each point)
y = ones(size(x1)); % Put the constant value or desired function here

% ANOVA
tbl = table(x1, x2, x3, y, 'VariableNames', {'Tamb', 'Beta', 'TIT', 'Response'});
model = fitlm(tbl, 'Response ~ Tamb*Beta*TIT');
anova_result = anova(model);

% Identify the variable with the highest effect
effects = anova_result.F(end-3:end-1); % Statistical values of variable effects
[max_effect, max_idx] = max(effects);
max_var = {'Tamb', 'Beta', 'TIT'};
disp(['Variable with the highest effect: ', max_var{max_idx}]);

% Display ANOVA results and variable effects
disp(anova_result);
disp('Variable effects:');
disp(effects);
