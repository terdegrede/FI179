clc,clearvars, close all

% Model parameters
I = 50;
tf = 100; % time

gNa = 120;
eNa = 115;
gK = 36;
eK = -82;
gL = 0.3;
eL = -59;
Cm = 1;

% Computation parameters
dt = 0.001;
t = 0: dt: tf;

% - Allocation
v = zeros(1, length(t));
n = zeros(1, length(t));
m = zeros(1, length(t));
h = zeros(1, length(t));

dmdt = m;  dvdt = v;    dhdt = h;   dndt = n;

% Initial conditions
v(1) = -65;
m(1) = 0.5;
h(1) = 0.06;
n(1) = 0.5;
nn= 1;


% Integration
for k = 1: length(t)
    
    dvdt(k + 1) = (gNa*m(k)^3*h(k)*(eNa-(v(k)+65)) + ...
        gK*n(k)^4*(eK-(v(k)+65)) + gL*(eL-(v(k)+65)) + I);
    dndt(k + 1) = alphaN(v(k))*(1 - n(k)) - betaN(v(k))*n(k);
    dmdt(k + 1) = alphaM(v(k))*(1 - m(k)) - betaM(v(k))*m(k);
    dhdt(k + 1) = alphaH(v(k))*(1 - h(k)) - betaH(v(k))*h(k);
    
    v(k + 1) = dvdt(k)*dt + v(k);
    m(k + 1) = dmdt(k)*dt + m(k);
    n(k + 1) = dndt(k)*dt + n(k);
    h(k + 1) = dhdt(k)*dt + h(k);
    
end


figure
% subplot(411)
plot(t, v(1: end -1), 'LineWidth', 2)
title('Potential V(t)')
axis([0 100 -150 50])
xticks([0 100])
yticks([-150 50])

% subplot(412)
% plot(t, n(1: end -1), 'LineWidth', 2)
% title('Potassium - activation n(t)')
% axis([0 100 0 1])
% xticks([0 100])
% yticks([0 1])
% 
% subplot(413)
% plot(t, m(1: end -1), 'LineWidth', 2)
% title('Sodium - activation m(t)')
% axis([0 100 0 1])
% xticks([0 100])
% yticks([0 1])
% 
% subplot(414)
% plot(t, h(1: end -1), 'LineWidth', 2)
% title('Potasium - inactivation h(t)')
% axis([0 100 0 1])
% xticks([0 100])
% yticks([0 1])

%% Complementary functions
function alM = alphaM(r)
alM = (2.5 - 0.1*(r + 65))./(exp(2.5 - 0.1*(r + 65)) - 1);
end

function alN = alphaN(r)
alN = (0.1 - 0.01*(r + 65)) ./ (exp(1 - 0.1*(r + 65)) - 1);
end

function alH = alphaH(r)
alH = 0.07*exp(-(r + 65)/20);
end

function btM = betaM(r)
btM = 4*exp(-(r + 65)/18);
end

function btH = betaH(r)
btH = 1./(exp(3.0 - 0.1*(r + 65)) + 1);
end

function btN = betaN(r)
btN = 0.125*exp(-(r + 65)/80);
end



