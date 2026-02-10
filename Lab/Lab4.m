%% Design of control system using stae feedback 
clear all
close all
clc

%% Problem 1 -> Design a state feedback controller
A = [-0.2 -1;1 0];
B = [0.5;0];
C = [0 1];
D = 0;
x0 = [0;0];

s=tf('s');
r = 1/s;

e = 0 ;
shat = 0.06;
ts2 = 2;

zeta = abs(log(shat))/sqrt(pi^2+log(shat)^2);
wn = log((2/100)^(-1))/zeta*ts2;

lambda1 = -zeta*wn + j*wn*sqrt(1-zeta^2);
lambda2 = -zeta*wn - j*wn*sqrt(1-zeta^2);

lambdades = [lambda1 lambda2];

K = place(A,B,lambdades);

sys = ss(A-B*K,B,C,D);
N = 1/dcgain(sys);

controller = ss(A-B*K,B*N,C,D);

tsim = linspace(0,5,1000);
[y,t,x]=step(controller,tsim);

figure(1)
plot(t,y)

%% Problem 2
clear all
close all
clc

A = [-1.8 -2.8 -2; 1 0 0; 0 1 0];
B = [1;0;0];
C = [0 0.25 1];
D = 0;

e = 0 ;
shat = 0;
ts2 = 1.5;

%Control of the stability
eigenvalues = eig(A) %All the eigenvalues are with negative real part

zeta = abs(log(shat))/sqrt(pi^2+log(shat)^2)
wn = log((2/100)^(-1))/(zeta*ts2)

lambda1 = -wn*zeta + j*wn*sqrt(1-zeta^2);
lambda2 = -wn*zeta - j*wn*sqrt(1-zeta^2);

lambdades = [lambda1 lambda2]
K = place (A,B,lambdades);
sys2 = ss(A-B*K, B, C, D);
N2 = 1/dcgain(sys2);
controller2 = ss(A-B*K, B*N2, C, D);

tsim = linspace (0,4,1000);
[y,t,x]= step(controller2,tsim);

figure(2)
plot(t,y)