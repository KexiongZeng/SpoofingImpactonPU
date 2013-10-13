%Matlab code for Received power by secondary User due to primary Transmitter %
% Primary Transmitter power = 100Kwatts
% Malicious Transmitter Power = 4watts
% Network Radius = 1000m
% Distance between Primary transmitter and good secondary user = 100Km
clear all;
close all;
clc;
num_run = 10000; %testing times
format long;
R =1000; %radius of outer circle, changable 30:30:1500 meter
R0 = 30;%radiu of inner circle
sigma_p = 8; %fixed value
sigma_m = 5.5; %fixed value
Pt = 100e3; %%%%%% Primary transmitting power = 100 Kw
Pm = 4; % malicious user transmitting power
dp = 100e3; %%%%% distance between primary transmitter and secondary user
M = 15; %%%% number of malicious users
A = log(10)/10;
E_p = sigma_p*randn(1,num_run);
Gp = 10.^(E_p/10);
Pr_p_tmp = Pt*Gp*dp^(-2); %r. v. received power
Pr_p = sort(Pr_p_tmp);
mu_p = 10*log10(Pt) - 20*log10(dp);
mu_p_2 = (10^(mu_p/10))^2;
P_gama = (1./(A*Pr_p*sigma_p*sqrt(2*pi))).*exp(-((10*log10(Pr_p)-mu_p)/(sqrt(2)*sigma_p)).^2);
figure(1)
[f2,x2] = hist(Pr_p_tmp,4000);
bar(x2,f2/trapz(x2,f2));%normalize
axis([0 1e-4 0 max(P_gama)]); %p_gama=1*10e4?
grid on, hold on;
xlabel('Received power at the secondary receiver: Pr\_p');
ylabel('Probability density function of Pr\_p')
plot(Pr_p, P_gama,'r'); 
axis([0 1e-4 0 max(P_gama)])
legend('simulation', 'computation' ) 