% parameter.m
function pa=parameter
pa.dtn='tvdata_24649.txt';
pa.PowerThresh = -114 ; % Power level in dBm to indicate if a channel is available
pa.NumOfPoints = 25600; % Num of Points used from L-R model
pa.SizeOfGrid = sqrt(pa.NumOfPoints);%Square size
pa.NumOfTowers = 10; % Total Num of Towers/Channels considered
pa.NumOfTowers = 10; % Total Num of Towers/Channels considered
pa.NumOfSimulatedTowers = 10; % Num of Towers whose Propagation characteristics is considered
% pa.dtbs=importdata(pa.dtn);
% pa.dtbs(:,3)=pa.dtbs(:,3)-129.05; % converts power in dBu to dBm
pa.Resolution=8;%0.5mile=800m resolution
%Every gird is 121.1m north-south and 96.3m east-west
%157*157 square
pa.SUProtectRange=0;%Neighboring Protected Range
pa.SUNumber=200;
pa.SpoofRange=50;
pa.RunTimes=1000;