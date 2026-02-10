clear all
close all
s = tf('s')
Ga = -0.09;
Gs = 1;
Gf = 1;
Gp = 40/(s^2+3*s+4.5);
Kd = 1;

Kc = -3.8;
nu=1;
Lin = (Kc/s^nu)*Ga*Gs*Gp*Gf;

figure(1)
[numLin,denLin] = tfdata(Lin,'v');
nyquist1(numLin,denLin)

Tp_max = 1.05;
Sp_max = 1.36;
figure(2)
myngridst(1.05,1.36)
nichols(Lin);

% Controller Design

wc_des = 3;

%Zero network

wnorm_z = 1; %wcdes/z = wnorm

z = wc_des/wnorm_z;

Rz = (1+s/z);
%Lead network

wnorm_lead1 = 1.2 ;
md1 = 16;

zd1 = wc_des/wnorm_lead1;

Rd1 = (1+s/zd1)/(1+s/(md1*zd1));

% Lag network

%wnorm_lag1 = 100 ; %final 500

%pi1 = wc_des/wnorm_lag1;

%mi1 = 10^(3/20); % final value 22dB

%Ri1 = (1+s/(mi1*pi1))/(1+s/pi1);

% Controller

Gc = Kc/s^nu*Rz*Rd1*1/(1+s/50);
hold on
L = Gc*Gp*Ga*Gs*Gf;
nichols(L)

% Step response

T = minreal(zpk(L/(1+L)));

figure(3)
step(T*Kd,15)

[numGp,denGp] = tfdata(Gp,'v');
[numGc,denGc] = tfdata(Gc,'v');

figure(4)
bodemag(T)