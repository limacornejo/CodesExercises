%filename: TAClass.m
%Author: Matheus Lima-Cornejo <https://limacornejo.github.io>
%Maintainer: Matheus Lima-Cornejo <https://limacornejo.github.io>
%Description: This file produces the plots shown on the solutions.
%Copyright (C) 2025, all rights reserved

%% 1. Simulate a white noise process with standard Gaussian

% Setting seed
rng("default")
s = rng;

% Sample size
n = 1000;

% Generating process
e = randn(n,1);

% Plot
t = (1:n)';
plot(t, e, ' '), title('Gausian White Noise i.i.d Process')

%% 2. Central moments of e and e2

e2 = e.^2;

Distribution = {'Normal';'Chi-squared'};
Mean = [mean(e);mean(e2)];
Std = [std(e);std(e2)];
Coeff_Skewness = [skewness(e);skewness(e2)];
Coeff_Kurtosis = [kurtosis(e);kurtosis(e2)];

T = table(Distribution,Mean,Std,Coeff_Skewness,Coeff_Kurtosis);
display(T)

%% 3. Uncorrelation vs Independence

% Histograms
figure
subplot(2,1,1), histogram(e), title('Histogram of e')
subplot(2,1,2), histogram(e2), title('Histogram of e^2')

% Scatter plot
figure
scatter(e,e2)

corr(e,e2)

%% 4. Jarque-Bera - Exercise 2

% Normal
JB_value_1 = (n/6)*((T.Coeff_Skewness(1)-0)^2 + 0.25*(T.Coeff_Kurtosis(1)-3)^2);

% Chi-square
JB_value_2 = (n/6)*((T.Coeff_Skewness(2)-0)^2 + 0.25*(T.Coeff_Kurtosis(2)-3)^2);

JB = [JB_value_1;JB_value_2];

T.JB = JB;
display(T)

%% 5. Simulate a RW - Exercise 7

% Vectors of zeros
y_rw = zeros(n,1);

% AR(1) coefficients
phi = 1;

% Loop
for i = 1:n-1
    y_rw(i+1) = phi * y_rw(i) + e(i+1);
end

% Plot
figure
subplot(2,1,1), plot(t,y_rw, ' '), title('Random walk')
subplot(2,1,2), autocorr(y_rw)

%% 6. Simulate an AR(2) - Exercise 12

% Level of the process
c = 0.1;

% AR(2) coefficients
phi1 = 1/3;
phi2 = 1/4;

% Vector of zeros
y12 = zeros(n,1);
y12(1) = c/(1-phi1-phi2);
y12(2) = c/(1-phi1-phi2);

% Loop
for i = 1:n-2
    y12(i+2) = c + phi1 * y12(i+1) + phi2 * y12(i) + e(i+2);
end

% Plot
figure
subplot(2,1,1), plot(t,y12, ' '), title('AR(2)')
subplot(2,1,2), autocorr(y12)

%% 7. Simulate an AR(2) - Exercise 13

% Level of the process
c = 0.1;

% AR(2) coefficients
phi1 = 1.6;
phi2 = -0.63;

% Vector of zeros
y13 = zeros(n,1);
y13(1) = c/(1-phi1-phi2);
y13(2) = c/(1-phi1-phi2);

% Loop
for i = 1:n-2
    y13(i+2) = c + phi1 * y13(i+1) + phi2 * y13(i) + e(i+2);
end

% Plot
figure
subplot(2,1,1), plot(t,y13, ' '), title('AR(2)')
subplot(2,1,2), autocorr(y13)

%% 8. Simulate an AR(2) - Exercise 14

% Level of the process
c = 0.1;

% AR(2) coefficients
phi1 = -0.4;
phi2 = 0.5;

% Vector of zeros
y14 = zeros(n,1);
y14(1) = c/(1-phi1-phi2);
y14(2) = c/(1-phi1-phi2);

% Loop
for i = 1:n-2
    y14(i+2) = c + phi1 * y14(i+1) + phi2 * y14(i) + e(i+2);
end

% Plot
figure
subplot(2,1,1), plot(t,y14, ' '), title('AR(2)')
subplot(2,1,2), autocorr(y14)

%% 9. Simulate an AR(2) - Exercise 15

% Level of the process
c = 0.1;

% AR(2) coefficients
phi1 = 0.8;
phi2 = -0.8;

% Vector of zeros
y15 = zeros(n,1);
y15(1) = c/(1-phi1-phi2);
y15(2) = c/(1-phi1-phi2);

% Loop
for i = 1:n-2
    y15(i+2) = c + phi1 * y15(i+1) + phi2 * y15(i) + e(i+2);
end

% Plot
figure
subplot(2,1,1), plot(t,y15, ' '), title('AR(2)')
subplot(2,1,2), autocorr(y15)

%% 10. Simulate an AR(2) - Exercise 16

% Level of the process
c = 0.1;

% AR(2) coefficients
phi1 = 0.1;
phi2 = -0.3;

% Vector of zeros
y16 = zeros(n,1);
y16(1) = c/(1-phi1-phi2);
y16(2) = c/(1-phi1-phi2);

% Loop
for i = 1:n-2
    y16(i+2) = c + phi1 * y16(i+1) + phi2 * y16(i) + e(i+2);
end

% Plot
figure
subplot(2,1,1), plot(t,y16, ' '), title('AR(2)')
subplot(2,1,2), autocorr(y16)

%% 11. Simulate an AR(2) - Exercise 17

% Level of the process
c = 0.1;

% AR(2) coefficients
phi1 = 0.5;
phi2 = -0.1;

% Vector of zeros
y17 = zeros(n,1);
y17(1) = c/(1-phi1-phi2);
y17(2) = c/(1-phi1-phi2);

% Loop
for i = 1:n-2
    y17(i+2) = c + phi1 * y17(i+1) + phi2 * y17(i) + e(i+2);
end

% Plot
figure
subplot(2,1,1), plot(t,y17, ' '), title('AR(2)')
subplot(2,1,2), autocorr(y17)

%% 12. Simulate an AR(2) - Mock Exam - Question 3

% Level of the process
c = 0.1;

% AR(2) coefficients
phi1 = 0.5;
phi2 = 0.3;

% Vector of zeros
yme3 = zeros(n,1);
yme3(1) = c/(1-phi1-phi2);
yme3(2) = c/(1-phi1-phi2);

% Loop
for i = 1:n-2
    yme3(i+2) = c + phi1 * yme3(i+1) + phi2 * yme3(i) + e(i+2);
end

% Plot
figure
subplot(2,1,1), plot(t,yme3, ' '), title('AR(2)')
subplot(2,1,2), autocorr(yme3)

%% 13. Uncorrelation vs Independence - Example 3

% Sample size
n1 = 100000;

% Setting seed
rng("default")
s1 = rng;

% Sampling from U(0,1)
u = rand(n1,1);

% Histogram
figure
histogram(u)

% Define variable X (u_sin)
u_sin = sin(2*pi*u);

% Define variable Y (u_cos)
u_cos = cos(2*pi*u);

% Scatter plots
figure
subplot(3,1,1),scatter(u,u_sin)
subplot(3,1,2),scatter(u,u_cos)
subplot(3,1,3),scatter(u_sin,u_cos)

% Correlation
corr(u_sin,u_cos)


%% 14. Simulate an invertible MA(1) - Further Exercise 4

% MA(1) coefficient
theta = 0.5;

% Vector of zeros
y1 = zeros(n,1);

% Loop
for i = 1:n-1
    y1(i+1) = e(i+1) - theta * e(i);
end

% Plot
figure
subplot(2,1,1), plot(t,y1, ' '), title('MA(1) with \theta = 0.5')
subplot(2,1,2), autocorr(y1)

%% 15. Simulate a non-invertible MA(1) - Further Exercise 4 and 5

% MA(1) coefficient
theta = 2;

% Vector of zeros
y2 = zeros(n,1);

% Loop
for i = 1:n-1
    y2(i+1) = e(i+1) - theta * e(i);
end

% Plot - Figure 2
figure
subplot(2,1,1), plot(t,y2, ' '), title('MA(1) with \theta = 2')
subplot(2,1,2), autocorr(y2)