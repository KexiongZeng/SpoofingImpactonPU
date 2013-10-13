%   Matlab code for Received power by secondary User due to Malicious Users %
clear all;
close all;
clc;
num_run = 10000;   %testing times
format long;
R =1000;   %radius of outer circle, changeable 30:30:1500 meter
R0 = 30;  %radius of inner circle
sigma_p = 8;   %fixed value
sigma_m = 5.5;   %fixed value
Pt = 100e3; %%%%%% Primary transmitting power = 100 Kw
Pm = 4;    %malicious user transmitting power
dp = 100e3; %%%%% distance between primary transmitter and secondary user
M = 10; %%%% number of malicious users
A = log(10)/10;
%%%% Random Points within circle with radius R & radius R0
xCoordinates = [];
yCoordinates = [];
n = M;
while n > 0
x = unifrnd(-R,R,1,1);
y = unifrnd(-R,R,1,1);
norms = sqrt((x.^2) + (y.^2));
inBounds = find((R0 <= norms) & (norms <= R));
xCoordinates = [xCoordinates; x(inBounds)];
yCoordinates = [yCoordinates; y(inBounds)];
n = M - numel(xCoordinates);
end
%%%%%%%%% Distance between jth malicious user and secondary user %%%%%%%
for i= 1 : M % number of malicious users 

d(i)=sqrt((xCoordinates(i))^2 + (yCoordinates(i))^2);
end
%%%%% Received power at secondary user from malicious users %%%%%%
for kk = 1:num_run
E_j= sigma_m*randn(M,1);
G = 10.^(E_j/10);
for j = 1:M
P(j) = Pm*(d(j)^(-4))*G(j);
end
Pr_m_tmp(kk)= sum(P);
end
Pr_m = sort(Pr_m_tmp);
[f1,x1] = hist(Pr_m_tmp,4000);
figure(2)
bar(x1,f1/trapz(x1,f1));
axis([0 max(x1) 0 max(f1/trapz(x1,f1))])
grid on; hold on;
xlabel('Received power at the secondary receiver from malicious users: Pr \_m')
ylabel('simulated pdf. Probability density function of Pr\_m')
sigma_x_2 = (1/A^2)*(log(mean(Pr_m.^2)) - 2*log(mean(Pr_m)));
mu_x = (1/A)*(2*log(mean(Pr_m)) - 0.5*log(mean(Pr_m.^2)));
P_m_gama = (1./(A*Pr_m*sqrt(sigma_x_2)*sqrt(2*pi))).*exp(-((10*log10(Pr_m)-mu_x)).^2/(2*sigma_x_2)); %Equ (11)
plot(Pr_m, P_m_gama,'r-.');
xlabel('Received power at the secondary receiver from malicious users: ' )
ylabel('calculated pdf')% axis([0 max(Pr_m) 0 max(P_m_gama)])
legend('simulation', 'computation' )