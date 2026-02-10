%% Lab5 _ Design of control system using state feedback

%% Problem 1 _ state feedback contrl law with integral action

A = [-0.2 -1; 1 0];
B = [0.5;0];
C = [0 1];
D = 0;

x0 = [0 0];

er = 0;
shat = 0.06;
ts2 = 2;

%Stability control
eigenvalues = eig(A);

zeta = abs(log(shat))/sqrt(pi^2+log(shat)^2);
wn = log((2/100)^(-1))/(ts2*zeta);

lambda1 = -wn*zeta + j*wn*(1-zeta^2);
lambda2 = -wn*zeta - j*wn*(1-zeta^2);
lambda3 = -5*wn*zeta

lambdaDes = [lambda1 lambda2 lambda3]

Aaug = [0 -C; zeros(size(A,1),1) A];
Baug = [0;B]
Caug = [0 C];
Daug = D;

K = place(Aaug,Baug,lambdaDes);
Kq = K(1,1)
Kx = K(1,2:end)

Aaugtilde = [0 -C; -B*Kq A-B*Kx];
Br = [1;0;0]

controller = ss(Aaugtilde,Br,Caug,0);
% Simulate the closed-loop system response
t_sim_aug = linspace(0, 20, 10000);
[y_aug, t_aug, x_aug] = step(controller, t_sim_aug);

figure(2)
plot(t_aug,y_aug)

%% Problem 2
clear all
close all
clc

A = [-0.2 -1; 1 0];
B = [0.5;0];
C = [0 1];
D = 0;

eigA = eig(A) ;
Mr = ctrb(A,B);
Mo = obsv(A,C);
rho_MO = rank(Mo)


%system requirements
e = 0;
shat = 0.06;
ts2 = 2;

zeta = abs(log(shat))/(pi^2+log(shat)^2);
wn = log((2/100)^(-1))/(ts2*zeta);

lambda1 = -wn*zeta +j*wn*sqrt(1-zeta^2);
lambda2 = -wn*zeta -j*wn*sqrt(1-zeta^2);

lambdades = [lambda1 lambda2];
K = place(A,B,lambdades);

sys = ss(A-B*K,B,C,D);
N = 1/dcgain(sys);

controller = ss(A-B*K,B*N,C,D);

tsim= linspace(0,5,1000);
[y,t,x] = step(controller,tsim);

figure(1)
plot(t,y)

%Observer design
%compute observer gain

lambda_obs_des =[-zeta*wn -zeta*wn]*5;
L = acker(A',C',lambda_obs_des)';



%Completed control system
A_I = [A -B*K;L*C A-B*K-L*C];
B_I = [B;B]*N;
C_I = [C zeros(1,2)];
sys_cont = ss(A_I, B_I, C_I, D);

t_sim2 = linspace(0,5,1000);
u_smi = ones(size(t_sim2));
[y,t,x_I]=lsim(sys_cont,u_smi,t_sim2);

figure(2)
plot(t,y)

%% Problem 3
clear all 
close all
clc

A = [-1 0; 0 10];
B = [1;1];
C = [1 0];
D = 0;

eigenvalues = eig(A) %One eigenvalues is greater than zero so the system is non stable 
Mr = ctrb(A,B)
rho_mr = rank(Mr)

lamndaDes = [-1 -2];
K = place(A,B,lamndaDes);
sys = ss(A-B*K,B,C,D);
N = 1/dcgain(sys);

sys_cont = ss(A-B*K,B*N,C,D);
tsim = linspace(0,10,1000);
[y, t, x] = step(sys_cont, tsim);
figure(1)
plot(t, y);
xlabel('Time (s)');
ylabel('Output');
title('Step Response of the Closed-Loop System');

% punto 3
Mo = obsv(A,C)
rank_mo = rank(Mo)
