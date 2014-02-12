%Use FIFO scheduling algorithm to simulate Database-driven WSNs
clear;
global Database;
pa=parameter;
SUNumber=pa.SUNumber;%Number of SUs
NumOfSimulatedTowers=pa.NumOfSimulatedTowers;
SUProtectRange=pa.SUProtectRange;
SizeOfGrid=pa.SizeOfGrid;
NumOfChannels=pa.NumOfChannels;%Subchannels in one TV band
RunTimes=pa.RunTimes;% Number of Cases
SpoofRange=pa.SpoofRange;%Spoofing capability
ChannelUsing=zeros(1,SUNumber);%Which channel the SU is using
Coordinate=cell(1,SUNumber);%Store coordinates for SUNumber SUs
SpoofedSUOriginalLocation=cell(1,SUNumber);%Store the original location of SUs spoofed
FalseAvailableChannel=zeros(1,SUNumber);%Store the channels falsely assigned to spoofed SUs
InterferePU=zeros(RunTimes,NumOfSimulatedTowers);%Store how many interference with PUs
SpoofedSUFlag=zeros(1,SUNumber);%Flag the spoofed SUs
SpoofedSUNum=zeros(1,RunTimes);% Store the number of spoofed SUs
RemainingServiceTime=zeros(1,SUNumber);% Record the remaining service time of all SUs 
TransmitState=zeros(1,SUNumber);%Indicate the SU transmit status
Clock=zeros(1,RunTimes);%Record completion time 
% Run simulations for RunTimes
for r=1:RunTimes
    Load_Initial_Database;%Reset Database 
    AttackerLocation=[rand(1)*SizeOfGrid,rand(1)*SizeOfGrid];%Attacker Location
    SpoofedLocation=[rand(1)*SizeOfGrid,rand(1)*SizeOfGrid];%Spoofing Location set by attacker
    %Generate SU coordinates and determine spoofed SUs
    for i=1:SUNumber
        row=rand(1)*SizeOfGrid;
        column=rand(1)*SizeOfGrid;
        Coordinate{1,i}=[row,column]; %Store coordinates of the ith SU
        if(((row-AttackerLocation(1,1))^2+(column-AttackerLocation(1,2))^2)<=SpoofRange^2)
           SpoofedSUFlag(i)=1;%Flag as spoofed
           SpoofedSUNum(r)=SpoofedSUNum(r)+1;
        end
    end
    RemainingServiceTime=unidrnd(5,1,SUNumber);%Create channel request
    while(sum(RemainingServiceTime))
        
       Clock(r)=Clock(r)+1; %Refresh clock 
    end
end