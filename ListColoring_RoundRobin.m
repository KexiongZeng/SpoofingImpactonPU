%Use list graph coloring and Round Robin scheduling algorithm to simulate Database-driven WSNs
clear;
global Database;
pa=parameter;
% AvaChannelInd=pa.AvaChannelInd;
 AvaLocNum=pa.AvaLocNum;
SUNumber=pa.SUNumber;%Number of SUs
NumOfSimulatedTowers=pa.NumOfSimulatedTowers;
SUProtectRange=pa.SUProtectRange;
SizeOfGrid=pa.SizeOfGrid;
NumOfChannels=pa.NumOfChannels;%Subchannels in one TV band
RunTimes=pa.RunTimes;% Number of Cases
SpoofRange=pa.SpoofRange;%Spoofing capability
BSChannelInd=pa.BSChannelInd;%Available channels at BS
[m,n]=size(BSChannelInd);
TotalAvailableChannelNum=m;
ChannelUsing=zeros(1,SUNumber);%Which channel the SU is using
Coordinate=cell(1,SUNumber);%Store coordinates for SUNumber SUs
FalseAssignedChannel=zeros(1,SUNumber);%Store the channels falsely assigned to spoofed SUs
InterferePU=zeros(RunTimes,NumOfSimulatedTowers);%Store how many interference with PUs
SpoofedSUFlag=zeros(1,SUNumber);%Flag the spoofed SUs
SpoofedSUNum=zeros(1,RunTimes);% Store the number of spoofed SUs
ChannelInterfered=zeros(1,RunTimes);%Store interfered channel for each run 
ChannelInterferedDistribution=zeros(RunTimes,NumOfSimulatedTowers*NumOfChannels);%Store interfered channel distribution for each run 
RealAvailableChannelNumber=zeros(1,SUNumber);%Store real available channel number for every second user
FalseAvailableChannelNumber=zeros(1,SUNumber);%Store False available channel number for every second user
RealDenyofServiceNum=zeros(1,RunTimes);
FalseDenyofServiceNum=zeros(1,RunTimes);
% Run simulations for RunTimes
for r=1:RunTimes
    ChannelIndUsedByEachSU_1=zeros(1,SUNumber);%record channel ind used by each SU in no attacker case
    ChannelIndUsedByEachSU_2=zeros(1,SUNumber);%record channel ind used by each SU in attacker case
    
    Load_Initial_Database;%Reset Database 
    AttackerLocation=[rand(1)*SizeOfGrid,rand(1)*SizeOfGrid];%Attacker Location
    SpoofedLocation=[rand(1)*SizeOfGrid,rand(1)*SizeOfGrid];%Spoofing Location set by attacker
    Lia=ismember(Database(:,ceil(SpoofedLocation(1)),ceil(SpoofedLocation(2))),0);
    AvailableChannelatSpoofedLocation=sum(Lia)/NumOfChannels;
    %Generate SU coordinates and determine spoofed SUs
    for i=1:SUNumber
        row=rand(1)*SizeOfGrid;
        column=rand(1)*SizeOfGrid;
        Coordinate{1,i}=[row,column]; %Store coordinates of the ith SU
        Lia=ismember(Database(:,ceil(row),ceil(column)),0);
        RealAvailableChannelNumber(1,i)=sum(Lia)/NumOfChannels;
        FalseAvailableChannelNumber(1,i)=sum(Lia)/NumOfChannels;
        if(((row-AttackerLocation(1,1))^2+(column-AttackerLocation(1,2))^2)<=SpoofRange^2)
           SpoofedSUFlag(i)=1;%Flag as spoofed
           SpoofedSUNum(r)=SpoofedSUNum(r)+1;
           FalseAvailableChannelNumber(1,i)=AvailableChannelatSpoofedLocation;
        end
    end
    %Simulate NO attack case
    SUTrStatus=zeros(1,SUNumber);%1 means transmission completed
    SUTransFinishedNum=0;

    clock_1=0;
    while(SUTransFinishedNum<SUNumber)
        [B,IX]=sort(AvaLocNum+(rand(TotalAvailableChannelNum,1)-0.5));%Sort available channel from low to high and randomly break the tie
        SortBSChannelInd=BSChannelInd(IX);
       for i=1:TotalAvailableChannelNum
           for j=1:NumOfChannels
               CandidateSU=0;
              AssignedChannelInd=(BSChannelInd(i)-1)*NumOfChannels+j;%Subchannel index
              AvailableChannelNum=10000*ones(1,SUNumber);
              %List vertex coloring
              for k=1:SUNumber
                  if(~SUTrStatus(k))
                      Location=[Coordinate{k}(1),Coordinate{k}(2)];
                      if(~Database(AssignedChannelInd,ceil(Location(1)),ceil(Location(2))))%Channel is available at that location
                          if(~CandidateSU)
                              CandidateSU=AssignedChannelInd;                            
                          else
                              CandidateSU=[CandidateSU,k];
                          end
                        
                          AvailableChannelNum(k)=RealAvailableChannelNumber(k);%Num of available channels at location
                      end
                  end
              end
                if(CandidateSU)
                  [B,IX]=sort(AvailableChannelNum,'ascend');
                  SUTrStatus(IX(1))=1;%Already assigned channel
                  ChannelIndUsedByEachSU_1(IX(1))= AssignedChannelInd;%Record which channel is assigned
                  SUTransFinishedNum=SUTransFinishedNum+1;
                end
           end
       end
       RealDenyofServiceNum(r)=RealDenyofServiceNum(r)+(SUNumber-SUTransFinishedNum);
       clock_1=clock_1+1;
    end
    %Simulate attack case
    SUTrStatus=zeros(1,SUNumber);%1 means transmission completed
    SUTransFinishedNum=0;
    clock_2=0;
    while(SUTransFinishedNum<SUNumber)
       for i=1:TotalAvailableChannelNum
           for j=1:NumOfChannels
               CandidateSU=0;
              AssignedChannelInd=(BSChannelInd(i)-1)*NumOfChannels+j;%Subchannel index
              AvailableChannelNum=10000*ones(1,SUNumber);
              %List vertex coloring
              for k=1:SUNumber
                  if(~SUTrStatus(k))
                      if(SpoofedSUFlag(k))
                      Location=SpoofedLocation;
                      else
                      Location=[Coordinate{k}(1),Coordinate{k}(2)];
                      end
                      if(~Database(AssignedChannelInd,ceil(Location(1)),ceil(Location(2))))%Channel is available at that location
                          if(~CandidateSU)
                              CandidateSU=AssignedChannelInd;                            
                          else
                              CandidateSU=[CandidateSU,k];
                          end
                        
                          AvailableChannelNum(k)=FalseAvailableChannelNumber(k);%Num of available channels at location
                      end
                  end
              end
                if(CandidateSU)
                  [B,IX]=sort(AvailableChannelNum,'ascend');
                  SUTrStatus(IX(1))=1;%Already assigned channel
                  ChannelIndUsedByEachSU_2(IX(1))= AssignedChannelInd;%Record which channel is assigned
                  SUTransFinishedNum=SUTransFinishedNum+1;
                end
           end
       end
       FalseDenyofServiceNum(r)=FalseDenyofServiceNum(r)+(SUNumber-SUTransFinishedNum);
       clock_2=clock_2+1;
    end
    SpoofedSUInd=find(SpoofedSUFlag);
    [m,n]=size(SpoofedSUInd);
    tmpChannelInterfered=0;
    %Check if any spoofed SU interfers with PU
    for k=1:n
       Location= [Coordinate{k}(1),Coordinate{k}(2)];%Real Location
       Ind=SpoofedSUInd(k);
       if(Database(ChannelIndUsedByEachSU_2(Ind),ceil(Location(1)),ceil(Location(2))))%PU is active
          ChannelInterferedDistribution(r,ChannelIndUsedByEachSU_2(Ind))= ChannelInterferedDistribution(r,ChannelIndUsedByEachSU_2(Ind))+1;
          tmpChannelInterfered= tmpChannelInterfered+1;  
       end
    end
     ChannelInterfered(r)= tmpChannelInterfered;
end
beep;
 save('tmp','SpoofedSUNum','ChannelInterfered','ChannelInterferedDistribution','RealDenyofServiceNum','FalseDenyofServiceNum');