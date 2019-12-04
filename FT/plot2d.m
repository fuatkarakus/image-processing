
clear
M = 300;
D0 = 20;
x = 1:M;
for x = 1:M/2
 y(1,x) = exp(-x*x/(2*D0*D0));
end

plot(y)