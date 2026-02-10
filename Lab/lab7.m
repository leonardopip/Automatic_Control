s = tf('s');

L3 = 10/(s^2*(s+10)^2)

figure(1)
bode(L3)
figure(2)
nyquist(L3)