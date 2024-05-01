%filename: FirstClassTA.m
%Author: Matheus Lima-Cornejo <https://mvtth43us.github.io>
%Maintainer: Matheus Lima-Cornejo <https://mvtth43us.github.io>
%Description: This file produces the plots shown on the solutions.
%Copyright (C) 2024, all rights reserved

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

%% 2. Simulate an invertible MA(1)

% MA(1) coefficient
theta = 0.5;

% Vector of zeros
y1 = zeros(n,1);

% Loop
for i = 1:n-1
    y1(i+1) = e(i+1) - theta * e(i);
end

% Plot - Figure 1
figure
subplot(2,1,1), plot(t,y1, ' '), title('MA(1) with \theta = 0.5')
subplot(2,1,2), autocorr(y1)

%% 3. Simulate a non-invertible MA(1)

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

%% 4. Simulate an AR(2) - Exercise 10

% Level of the process
c = 0.1;

% AR(2) coefficients
phi1 = 0.8;
phi2 = -0.8;

% Vector of zeros
y3 = zeros(n,1);

% Loop
for i = 1:n-2
    y3(i+2) = c + phi1 * y3(i+1) + phi2 * y3(i) + e(i+2);
end

% Plot - Figure 3
figure
subplot(2,1,1), plot(t,y3, ' '), title('AR(2)')
subplot(2,1,2), autocorr(y3)

%% 4. Simulate an AR(2) - Appendix - Example 1

% AR(2) coefficients
phi1 = 0.9;
phi2 = -0.2;

% Vector of zeros
y4 = zeros(n,1);

% Loop
for i = 1:n-2
    y4(i+2) = phi1 * y4(i+1) + phi2 * y4(i) + e(i+2);
end

% Plot - Figure 4
figure
subplot(2,1,1), plot(t,y4, ' '), title('AR(2)with \phi_1 = 0.9 and \phi_2 = -0.2')
subplot(2,1,2), autocorr(y4)

%% 5. Simulate an AR(2) - Appendix - Example 2

% AR(2) coefficients
phi1 = -0.8;
phi2 = -0.16;

% Vector of zeros
y5 = zeros(n,1);

% Loop
for i = 1:n-2
    y5(i+2) = phi1 * y5(i+1) + phi2 * y5(i) + e(i+2);
end

% Plot - Figure 4
figure
subplot(2,1,1), plot(t,y5, ' '), title('AR(2) with \phi_1 = -0.8 and \phi_2 = -0.16')
subplot(2,1,2), autocorr(y5)