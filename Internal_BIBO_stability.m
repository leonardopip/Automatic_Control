%% 
clear all
close all
clc

A = [0 1 0 0; -1 0 0 0; 3 0 0 0; 0 0 2 0];
B = [1 0 0 0]';
C = [1 0 0 0];
D = 0;
s= tf('s');

sys = ss(A,B,C,D);
H = tf(sys);

u1 = sqrt(2)/(s^2+2);
Y1 = H*u1

[n,d] = tfdata (Y1,'v')
[r,p] = residue(n,d)


u2 = 1 /(s^2+1);
Y2 = H*u2;

[n2,d2] = tfdata (Y2,'v')
[r2,p2] = residue(n2,d2)


