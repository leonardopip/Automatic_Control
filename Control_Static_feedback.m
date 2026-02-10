%%
clear all
close all
clc

A = [-0.1 -1; 1 0];
B = [1 0]';
C = [0 1];
D = 0;
x0 = [0 0]';
%Requirements
e = 0;
shat = 0.10;
ts2 = 6.5;

%Check the reachability factor

M_r = ctrb(A,B);
rank_M = rank(M_r) %The rank is two so the system is reachable 

zeta = abs (log(shat))/(sqrt(pi^2+log(shat)^2));
wn = log((2/100)^(-1))/(zeta*ts2);


lambda1 = - zeta*wn + j*wn*sqrt(1-zeta^2);
lambda2 = - zeta*wn - j*wn*sqrt(1-zeta^2);

lambdaDes = [lambda1 lambda2];
% Calculate the desired state feedback gain using pole placement
K = place(A, B, lambdaDes);

%Compute N
A_C = A-B*K;
B_C = B;
C_C = C;
D_C = D;
sys_N = ss(A_C,B_C,C_C,D_C);
N = 1/dcgain(sys_N);

sys_Control = ss (A-B*K,B*N,C,D);
t_sim = linspace (0,10,10000);
[y,t,x]=step(sys_Control,t_sim);

figure(1)
plot(t,y)

%% Feedbacj with integral action
A = [-0.1 -1;1 0];

B = [1 0]';
C = [0 1];
D = 0;

%requirements
e = 0;
shat = 0.10;
ts2 = 6.5;

M = ctrb(A,B) %its rank is 2 thus in controllability 

%Define the system requirements
zeta = abs(log(shat))/(sqrt(pi^2+log(shat)^2));
wn = log((2/100)^(-1))/(zeta*ts2);

%define eigenvalue to assign
lambda1 = -wn*zeta + j*wn*sqrt(1-zeta^2);
lambda2 = -wn*zeta - j*wn*sqrt(1-zeta^2);
lambda3 = -5*wn*zeta;

lambdades = [lambda1 lambda2 lambda3];

A_aug = [0 -C; zeros(size(A,1),1) A]

B_aug = [0;B];

K_aug = place(A_aug,B_aug,lambdades);
Kq = K_aug(1);
Kx = K_aug(2:end);

A_tilde_aug = [0 -C; -B*Kq A-B*Kx];
B_tilde_aug = [1;zeros(2,1)];
C_tilde_aug = [0 C];
D_tilde_aug = 0;

controller = ss(A_tilde_aug,B_tilde_aug,C_tilde_aug,D_tilde_aug);
% Simulate the closed-loop response of the augmented system
t_sim_aug = linspace(0, 20, 10000);
[y_aug, t_aug, x_aug] = step(controller, t_sim_aug);

figure(2)
plot(t_aug,y_aug)
