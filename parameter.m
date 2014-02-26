% parameter.m
function pa=parameter
pa.dtn='WhiteSpaceFinder.txt';
pa.PowerThresh = -114 ; % Power level in dBm to indicate if a channel is available
pa.NumOfPoints = 25600; % Num of Points used from L-R model
pa.SizeOfGrid = sqrt(pa.NumOfPoints);%Square size
pa.NumOfTowers = 51; % Total Num of Towers/Channels considered
pa.NumOfChannels=1;%subchannel in each TV band
pa.NumOfSimulatedTowers = 51; % Num of Towers whose Propagation characteristics is considered
pa.dtbs=importdata(pa.dtn);
pa.dtbs(isnan(pa.dtbs))=0;
pa.BSChannelInd=[ 6
     7
     9
    12
    16
    21
    22
    26
    27
    29
    33
    34
    35
    38
    39
    43
    45
    47
    48
    50
    51];
% pa.dtbs(:,3)=pa.dtbs(:,3)-129.05; % converts power in dBu to dBm
% B=unique(pa.dtbs);
% pa.AvaChannelInd=B(2:end);%All possible available channels in the cell
pa.AvaLocNum=histc(pa.dtbs(:),pa.BSChannelInd);%Number of grids where channel is available 
pa.Resolution=8;%0.5mile=800m resolution
%Every gird is 121.1m north-south and 96.3m east-west
%157*157 square
pa.SUProtectRange=1;%Neighboring Protected Range
pa.SUNumber=21*pa.NumOfChannels*60;%
pa.SpoofRange=10;
pa.RunTimes=30;

% longitude=zeros(1,157);
% latitude=zeros(1,157);
% longitude_sample=zeros(1,20);
% latitude_sample=zeros(1,20);
% for i=1:157
%     longitude(1,i)=pa.dtbs(i,1);
%     latitude(1,i)=pa.dtbs((i-1)*157+1,2);
% end
%   
% for i=1:20
%     longitude_sample(1,i)=longitude(1,4+8*(i-1));
%     latitude_sample(1,i)=latitude(1,4+8*(i-1));
% end
% latitude_sample=latitude_sample';
% save('longitude_latitude','longitude_sample','latitude_sample');