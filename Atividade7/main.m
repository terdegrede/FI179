clc, clearvars, close all
% Oscillatory blood flux

dt = 0.001;

Tu = 0.3;       % Time of systole
Td = 0.5;       % Time of diastole
T = Tu + Td;    % One period duration(seconds)
N = 5;          % Number of periods

% Period parameters
tu = 0 : dt : Tu;
td = Tu+dt : dt : T;
t = [tu td];

% Signal
I0 = 450;
i_tu = I0*sin(pi*tu/Tu);
i_td = zeros(1, length(td));
i = [i_tu i_td];

% Periodic signal
i_t = repmat(i,1 , N);
t_t = dt: dt :N*(T+dt); % Time steps

% Figure
figure
plot(t_t, i_t, 'LineWidth', 2)
title('Systole and Diastole')
xlabel('Time(s)')
ylabel('Amplitude i(t)')
axis tight
axis square

%% Numerical integration
clc, close all
R = 1;
C = 1;

% To solve equation:
% dp/dt = 1/c(i - P/R)

% Allocation
p = 80*ones(1, length(t) +1);
dp = zeros(1, length(t) +1);

% Numerical differentiation
figure
for R = 0.5:0.5:2.5
    for n = 1: length(t_t)
        dp(n + 1) = 1/C*(i_t(n) - p(n)/ R);
        p(n+ 1) = dp(n)*dt + p(n);
        
    end
    plot(t_t, p(1:end-1), 'LineWidth', 2)
    hold on
end

% plot(t_t, i_t, 'r--'), hold on

%axis([-0.2 max(t_t)+0.2 min(p) max(p) ])
 axis tight
legend('R = 0.5', 'R = 1', 'R = 1.5', 'R = 2', 'R = 2.5')
xlabel('time')
ylabel('P(t)')
grid minor