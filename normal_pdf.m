%filename: normal_pdf.m
%Author: Matheus Lima-Cornejo <https://limacornejo.github.io>
%Maintainer: Matheus Lima-Cornejo <https://limacornejo.github.io>
%Description: This file produces the plots for bivariate normal dist.
%Copyright (C) 2025, all rights reserved

%Simulation of Bivariate Normal

%% 1. Create a grid of evenly spaced points in two-dimensional space
x1 = -4:0.1:4;
x2 = -4:0.1:4;
[X1,X2] = meshgrid(x1,x2);
X = [X1(:) X2(:)];

%% 2. Uncorrelated (Independent)

% Define the parameters mu_i and Sigma_i
mu_i = [0 0];
Sigma_i = [1 0; 0 1];

% Evaluate the pdf of the normal distribution at the grid points
y_i = mvnpdf(X,mu_i,Sigma_i);
y_i = reshape(y_i,length(x2),length(x1));

% Plot the pdf values
figure
surf(x1,x2,y_i)
axis([-4 4 -4 4 0 0.3])
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
title('Uncorrelated Bivariate Normal Distribution')

%% 3. Correlated

% Define the parameters mu_c and Sigma_c
mu_c = [0 0];
Sigma_c = [1 0.75; 0.75 1];

% Evaluate the pdf of the normal distribution at the grid points
y_c = mvnpdf(X,mu_c,Sigma_c);
y_c = reshape(y_c,length(x2),length(x1));

% Check whether Sigma_c symmetric positive definite
try chol(Sigma_c)
    disp('Matrix is symmetric positive definite.')
catch ME
    disp('Matrix is not symmetric positive definite')
end

% Plot the pdf values
figure
surf(x1,x2,y_c)
axis([-4 4 -4 4 0 0.3])
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
title('Correlated Bivariate Normal Distribution')