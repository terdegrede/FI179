%% 1D
clc, clearvars, close all

% Random walks of N particles starting at position 0. Each random walk is
% done in T generations with +/- jumps of distance L.

% Parameters
L = 1;      % Step distance
% M = 1;      % Number of simulations
N = 500;    % Number of particles
T = 2000;   % Number of steps

X = zeros(N, T + 1); % Allocation (Initial positions at 0)
MSD = zeros(1, T + 1);

for m = 1: 20           % Several simulations (to check MSD behavior)
    for t = 1: T

        P = rand(N, 1); % Probability distribution
        X(:, t+ 1) = X(:, t) + L*(P<=0.5) - L*(P>0.5);
        MSD(t + 1) = mean((X(:, t + 1)).^2);
    end
    plot(MSD)
    hold on             % Several simulations (to check MSD behavior)
end


axis square

D = max(MSD)/2/T; % Estimation of the diffusion coefficient.
xlabel('Steps')
ylabel('MSD')
% (A.15)MSD = 2*D*t

%% 3D
clc, clearvars, close all

% Random walks of N particles starting at position (0, 0, 0). Each random
% walk is done in T generations with +/- 3D jumps of distance Lx, Ly, or
% Lz.

% Parameters
L = 1;
Lx = L;          % Jump distance
Ly = L;
Lz = L;

N = 500;         % Number of particles
T = 2000;       % Number of jumps

X = zeros(N, T + 1);  
Y = zeros(N, T + 1);
Z = zeros(N, T + 1);

MSD = zeros(1, T + 1);

for m = 1: 20           % Several simulations (to check MSD behavior)
    for t = 1: T
        Px = rand(N, 1); % Probability distribution (x component)
        Py = rand(N, 1);    % ''    ''  (y component)
        Pz = rand(N, 1); %  ''      ''      (z component)

        % x components
        X(:, t+ 1)= X(:, t) + Lx*(Px<=0.5) - Lx*(Px>0.5);

        % y components
        Y(:, t+ 1)= Y(:, t) + Ly*(Py<=0.5) - Ly*(Py>0.5);

        % z components
        Z(:, t+ 1)= Z(:, t) + Lz*(Pz<=0.5) - Lz*(Pz>0.5);


        MSD(t + 1) = mean((X(:, t + 1)).^2 + (Y(:, t + 1)).^2+ ...
            (Z(:, t + 1)).^2);

    end
    plot(MSD)
    hold on         % Several simulations (to check MSD behavior)
end

%%
vid = VideoWriter('brownian3D'); 
open(vid)
for t = 1: T

            scatter3(X(:, t), Y(:, t), Z(:, t))
            axis([-100 100 -100 100 -100 100])
            xlabel('x')
            ylabel('y')
            zlabel('z')
            axis square
            drawnow 
            frame = getframe(gcf);
            writeVideo(vid, frame);

end
close(vid)


