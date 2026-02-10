%% BIBO stability of LTI system
clear all
close all 
clc
%% Problem 1

A = [1 0 0; 0 -2 3; 0 -3 -2];
B = [0 1 1]';
C = [0 1 2];
D = 0;

% Internal stability 

eigenvalues = eig(A) % uno con parte reale maggiore di zero e due complessi con parte reale minore di zero,
% Il sistema sarebbe internamente instabile

% Bibo stability

sys = ss(A,B,C,D);
H = tf(sys);

[num,den]=tfdata(H,'v');
[res,pol]=residue(num,den) %poli è uno complesso con parte reale minore di zero e quindi il sistema è stabile per la BIBO stability

%% Problem 2
s = tf('s');
H = 1 /(s^3+2*s^2+5.25*s+4.25);
[numH,denH]=tfdata(H,'v');
[resH,polH]=residue(numH,denH)

u = 3*0.1^2/(s^2+0.1^2) +2/s;

Y = H*u;

[num,den]=tfdata(Y,'v');
[res,pol]=residue(num,den)

% Compute the amplitude of a sinusoidal input of the form

%% Problem 4 
% Compute the step responde of a second order system
s = tf('s');
H = 10 /(s^2+1.6*s+4);

%Evalutate wn zeta and time constant of the pole
