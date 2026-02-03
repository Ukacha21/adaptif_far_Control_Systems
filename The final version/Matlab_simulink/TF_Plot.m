% Adaptive Headlight System - Transfer Function Analysis
clc; clear; close all;

%% 1. Define System Parameters
V_nominal = 12;         % Volts
w_no_load = 10.47;      % rad/s (100 RPM)
T_stall = 0.176;        % N.m (1.8 kg.cm)

% Derived Electrical Constants
Kb = V_nominal / w_no_load;    % Back EMF constant (V.s/rad)
Kt = Kb;                       % Torque constant (N.m/A)
R = (Kt * V_nominal) / T_stall;% Resistance (Ohms)

% Estimated Mechanical Constants (Based on 3D printed plastic parts)
% You can tune these values if the simulation doesn't match real life
J_eq = 2.5e-6;   % Inertia (kg.m^2)
D_eq = 1.0e-5;   % Viscous Damping (N.m.s/rad)

%% 2. Create Transfer Function
% G(s) = Theta(s) / V(s)
% Numerator: Kt
% Denominator: s * [ (R*J_eq)s + (R*D_eq + Kt*Kb) ]

num = [Kt];
den = [ (R*J_eq), (R*D_eq + Kt*Kb), 0 ]; % The '0' at the end represents the free integrator 's'

sys_tf = tf(num, den);

% Display the Transfer Function
disp('System Transfer Function G(s):');
sys_tf

%% 3. Plotting
figure('Name', 'System Response');

% A. Step Response (Open Loop)
% This shows the speed increasing to max when 12V is applied
subplot(2,1,1);
step(12 * sys_tf); % 12V input
title('Position Response to 12V Step Input (Open Loop)');
xlabel('Time (seconds)');
ylabel('Position (radians)');
grid on;

% B. Closed Loop Response (Simulating the Arduino P-Control)
% Assume a Proportional Gain Kp (matches Arduino code)
Kp = 5; 
sys_closed = feedback(Kp * sys_tf, 1);

subplot(2,1,2);
step(270 * (pi/180) * sys_closed); % Step input to 270 degrees (in radians)
title('Closed Loop Position Response (Target: 270 deg)');
xlabel('Time (seconds)');
ylabel('Position (radians)');
grid on;