A = [0 1;-0.2 -0.5];
B = [0;1];
C = [1 0];
D = 0;

zeta = 0.6;
wn = 5;

lambda1 = -wn*zeta +j*wn*sqrt(1-zeta^2)
lambda2 = -wn*zeta -j*wn*sqrt(1-zeta^2)

lambdades= [lambda1 lambda2];
K = place(A,B,lambdades)
sys = ss(A-B*K,B,C,D);

tsim = linspace(0,10,1000)
[y,t,x] = step(sys,tsim)

figure(1)
plot(t,y)
%%
s=tf('s');
H = 0.1*(s+2)/(2*s^3+6*s^2+5*s-1);
u = 0.4/s;
Y = u*H;
[num,den]=tfdata(Y,'v');
[res,pole]=residue(num,den)
