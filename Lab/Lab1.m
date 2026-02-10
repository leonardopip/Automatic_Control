clear all 
close all
clc
A = [1 2; 4 3];
B = [5;8];
C = [-1 3];
D = 8;

x0 = [2;2];
%input is a step signal with amplitude 2

sys = ss(A,B,C,D);
H = tf(sys);
s = tf('s');
Y = H*2/s;
[n,d] = tfdata(Y,'v')
[res, pol] = residue(n,d)

f = [s-1 -2;-4 s-3]^(-1)
xzi = f*x0
xzs = f*B*2/s
x = minreal(xzi + xzs,1e-3)

[n,d] = tfdata(x(1),'v')
[res, pol] = residue(n,d)