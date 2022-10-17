clc, clearvars, close all
% Oscillatory blood flux

dt = 0.01;

Tu = 0.3;       % Time of systole
Td = 0.5;       % Time of diastole
T = Tu + Td;    % One period duration(seconds)
N = 5;          % Number of periods

% Period parameters
tu = 0 : dt : Tu;
td = Tu+dt : dt : T;
t = [tu td];

% Signal
I0 = 10;
i_tu = I0*sin(pi*tu/Tu);
i_td = zeros(1, length(td));
i = [i_tu i_td];

% Periodic signal
i_t = repmat(i,1 , N);
t_t = dt: dt :N*(T+dt);

% Figure
figure
plot(t_t, i_t, 'LineWidth', 2)
title('Systole and Diastole')
xlabel('Time(s)')
ylabel('Amplitude i(t)')
axis tight
axis square

%% Numerical integration

