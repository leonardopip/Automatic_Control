clear all
close all
clc
s=tf('s');
Gp = 100/(s^2+5.5*s+4.5);

Gs =1;
Ga = 0.014;
Gr = 1;
Gd = 1;
Da0 =1.5e-3;
ap = 16e-2; 
wp = 0.003;
as = 2e-1;
ws =60;

Kd=1
Gf = 1/(Kd*Gs);
Kp = 22.2;
Kc = Kd^2*1/(Kp*Ga*1.5e-1);

zeta = abs(log(0.12))/(sqrt(pi^2+log(0.12)^2));
Tp_max = 1/(2*zeta*sqrt(1-zeta^2))
Sp_max = (2*zeta*sqrt(2+4*zeta^2+2*sqrt(1+8*zeta^2)))/(sqrt(1+8*zeta^2)+4*zeta^2-1)

wc1 = 1.9708/2;
wc2 = log((5/100)^-1)/zeta*sqrt(sqrt(1+4*zeta^4)-2*zeta^2)/8;

Lin = 22/s*Gp*Ga*Gs*Gf;
myngridst(Tp_max,Sp_max)
nichols(Lin)

%lead
wdes = 1.5
wnorma =2.2;
md = 16
zd =wdes/wnorma;

Rd =(1+s/zd)/(1+s/(md*zd));

%lag
wnorma_lag = 100;
mi = 7;
zi=wdes/wnorma_lag;
Ri = (1+s/(mi*zi))/(1+s/zi);
% Connect the lead compensator to the system

Gc = (22/s)*Rd*Ri;
L = Gc*Gp*Ga*Gs*Gf;
myngridst(Tp_max,Sp_max)
nichols(Lin)
nichols(L)