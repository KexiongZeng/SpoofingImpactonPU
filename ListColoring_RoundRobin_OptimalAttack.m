%Use list graph coloring and Round Robin scheduling algorithm to simulate Database-driven WSNs
clear;
global Database;
pa=parameter;
% AvaChannelInd=pa.AvaChannelInd;
Resolution=pa.Resolution;
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
ChannelInterfered_RandomAttack=zeros(1,RunTimes);%Store interfered channel for each run 
 ChannelInterfered_GreedyAttack=zeros(1,RunTimes);%
 ChannelInterfered_OptimalAttack=zeros(1,RunTimes);%Store interfered channel for each run 
ChannelInterferedDistribution_RandomAttack=zeros(RunTimes,NumOfSimulatedTowers*NumOfChannels);%Store interfered channel distribution for each run 
ChannelInterferedDistribution_GreedyAttack=zeros(RunTimes,NumOfSimulatedTowers*NumOfChannels);%Store interfered channel distribution for each run 
ChannelInterferedDistribution_OptimalAttack=zeros(RunTimes,NumOfSimulatedTowers*NumOfChannels);%Store interfered channel distribution for each run 
RealAvailableChannelNumber=zeros(1,SUNumber);%Store real available channel number for every second user
AvailableChannelNumber=zeros(1,SUNumber);%Store False available channel number for every second user
RealDenyofServiceNum=zeros(1,RunTimes);
FalseDenyofServiceNum=zeros(1,RunTimes);

% Run simulations for RunTimes
for r=1:RunTimes
    fprintf('We are running case %d\n',r);
    ChannelIndUsedByEachSU_RandomAttack=zeros(1,SUNumber);%record channel ind used by each SU in random attack case
    ChannelIndUsedByEachSU_GreedyAttack=zeros(1,SUNumber);%record channel ind used by each SU in greedy attack case
    ChannelIndUsedByEachSU_OptimalAttack=zeros(1,SUNumber);%record channel ind used by each SU in Optimal attack case
    Load_Initial_Database;%Reset Database 
    AttackerLocation=[rand(1)*SizeOfGrid,rand(1)*SizeOfGrid];%Attacker Location
    AvlbChIndatAttckLoc=find(Database(:,ceil(AttackerLocation(1)),ceil(AttackerLocation(2)))==0);
    %Generate SU coordinates and determine spoofed SUs
    row=rand(1,SUNumber)*SizeOfGrid;
    column=rand(1,SUNumber)*SizeOfGrid;
    %identify spoofed SUs
    for i=1:SUNumber
        Coordinate{1,i}=[row(i),column(i)]; %Store coordinates of the ith SU
        Lia=ismember(Database(:,ceil(row(i)),ceil(column(i))),0);
        AvailableChannelNumber(1,i)=sum(Lia)/NumOfChannels;
        if(((row(i)-AttackerLocation(1,1))^2+(column(i)-AttackerLocation(1,2))^2)<=SpoofRange^2)
           SpoofedSUFlag(i)=1;%Flag as spoofed
           SpoofedSUNum(r)=SpoofedSUNum(r)+1;       
        end
    end
    %Generate random spoof location 
    SpoofedLocation=[rand(1)*SizeOfGrid,rand(1)*SizeOfGrid];%Spoofing Location set by attacker
    Lia=ismember(Database(:,ceil(SpoofedLocation(1)),ceil(SpoofedLocation(2))),0);
    AvailableChannelatSpoofedLocation=sum(Lia)/NumOfChannels;
    FalseAvailableChannelNumber_RandomAttack= AvailableChannelNumber;
    SpoofedSUInd=find(SpoofedSUFlag);
    FalseAvailableChannelNumber_RandomAttack(SpoofedSUInd)= AvailableChannelatSpoofedLocation;

    %Simulate random attack case
    SUTrStatus=zeros(1,SUNumber);%1 means transmission completed
    SUTransFinishedNum=0;
    clock_RandomAttack=0;
    while(SUTransFinishedNum<SUNumber)
        [B,IX]=sort(AvaLocNum+(rand(TotalAvailableChannelNum,1)-0.5));%Sort available channel from low to high and randomly break the tie
        SortBSChannelInd=BSChannelInd(IX);
       for i=1:TotalAvailableChannelNum
           for j=1:NumOfChannels
               CandidateSU=0;
              AssignedChannelInd=(SortBSChannelInd(i)-1)*NumOfChannels+j;%Subchannel index
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
                        
                          AvailableChannelNum(k)=FalseAvailableChannelNumber_RandomAttack(k);%Num of available channels at location
                      end
                  end
              end
                if(CandidateSU)
                  [B,IX]=sort(AvailableChannelNum+(rand(1,SUNumber)-0.5));%Sort by color degree from low to high, break tie randomly
                  SUTrStatus(IX(1))=1;%Already assigned channel
                  ChannelIndUsedByEachSU_RandomAttack(IX(1))= AssignedChannelInd;%Record which channel is assigned
                  SUTransFinishedNum=SUTransFinishedNum+1;
                end
           end
       end
       FalseDenyofServiceNum(r)=FalseDenyofServiceNum(r)+(SUNumber-SUTransFinishedNum);
       clock_RandomAttack=clock_RandomAttack+1;
    end
    n=SpoofedSUNum(r);
    tmpChannelInterfered=0;
    %Check if any spoofed SU interfers with PU
    for k=1:n
                 Ind=SpoofedSUInd(k);
                   Location= [Coordinate{Ind}(1),Coordinate{Ind}(2)];%Real Location
       if(Database(ChannelIndUsedByEachSU_RandomAttack(Ind),ceil(Location(1)),ceil(Location(2))))%PU is active
          ChannelInterferedDistribution_RandomAttack(r,ChannelIndUsedByEachSU_RandomAttack(Ind))= ChannelInterferedDistribution_RandomAttack(r,ChannelIndUsedByEachSU_RandomAttack(Ind))+1;
          tmpChannelInterfered= tmpChannelInterfered+1;  
       end
    end
     ChannelInterfered_RandomAttack(r)= tmpChannelInterfered/clock_RandomAttack;
     save('tmp_RandomAttack','SpoofedSUNum','ChannelInterfered_RandomAttack','ChannelInterferedDistribution_RandomAttack');
         %Generate greedy spoof location 
         Phi=zeros(1,(SizeOfGrid/Resolution)^2);
         RowInd=zeros(1,(SizeOfGrid/Resolution)^2);
         ColumnInd=zeros(1,SizeOfGrid^2);
         for i=1:(SizeOfGrid/Resolution)
            for j=1:(SizeOfGrid/Resolution)
               AvailableChannelInd=find(Database(:,(i-1)*Resolution+1,(j-1)*Resolution+1)==0);
               [n,m]=size(AvailableChannelInd);
               N_Total=n;
               Lia=ismember(AvailableChannelInd,AvlbChIndatAttckLoc);
               DiffChannelInd=find(Lia(:)==0);
               [n,m]=size(DiffChannelInd);
               N_Prime=n;
               Phi((i-1)*SizeOfGrid/Resolution+j)=N_Prime/N_Total;
               RowInd((i-1)*SizeOfGrid/Resolution+j)=i;
               ColumnInd((i-1)*SizeOfGrid/Resolution+j)=j;
            end
         end
         [B,IX]=sort(Phi,'descend');
    SpoofedLocation=[(RowInd(IX(1))-1)*Resolution+1,(ColumnInd(IX(1))-1)*Resolution+1];%Spoofing Location set by attacker
    Lia=ismember(Database(:,ceil(SpoofedLocation(1)),ceil(SpoofedLocation(2))),0);
    AvailableChannelatSpoofedLocation=sum(Lia)/NumOfChannels;
    FalseAvailableChannelNumber_GreedyAttack= AvailableChannelNumber;
    SpoofedSUInd=find(SpoofedSUFlag);
    FalseAvailableChannelNumber_GreedyAttack(SpoofedSUInd)= AvailableChannelatSpoofedLocation;

    %Simulate greedy attack case
    SUTrStatus=zeros(1,SUNumber);%1 means transmission completed
    SUTransFinishedNum=0;
    clock_GreedyAttack=0;
    while(SUTransFinishedNum<SUNumber)
        [B,IX]=sort(AvaLocNum+(rand(TotalAvailableChannelNum,1)-0.5));%Sort available channel from low to high and randomly break the tie
        SortBSChannelInd=BSChannelInd(IX);
       for i=1:TotalAvailableChannelNum
           for j=1:NumOfChannels
               CandidateSU=0;
              AssignedChannelInd=(SortBSChannelInd(i)-1)*NumOfChannels+j;%Subchannel index
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
                        
                          AvailableChannelNum(k)=FalseAvailableChannelNumber_GreedyAttack(k);%Num of available channels at location
                      end
                  end
              end
                if(CandidateSU)
                  [B,IX]=sort(AvailableChannelNum+(rand(1,SUNumber)-0.5));%Sort by color degree from low to high, break tie randomly
                  SUTrStatus(IX(1))=1;%Already assigned channel
                  ChannelIndUsedByEachSU_GreedyAttack(IX(1))= AssignedChannelInd;%Record which channel is assigned
                  SUTransFinishedNum=SUTransFinishedNum+1;
                end
           end
       end
       FalseDenyofServiceNum(r)=FalseDenyofServiceNum(r)+(SUNumber-SUTransFinishedNum);
       clock_GreedyAttack=clock_GreedyAttack+1;
    end
    n=SpoofedSUNum(r);
    tmpChannelInterfered=0;
    %Check if any spoofed SU interfers with PU
    for k=1:n
                 Ind=SpoofedSUInd(k);
                 Location= [Coordinate{Ind}(1),Coordinate{Ind}(2)];%Real Location
       if(Database(ChannelIndUsedByEachSU_GreedyAttack(Ind),ceil(Location(1)),ceil(Location(2))))%PU is active
        ChannelInterferedDistribution_GreedyAttack(r,ChannelIndUsedByEachSU_GreedyAttack(Ind))= ChannelInterferedDistribution_GreedyAttack(r,ChannelIndUsedByEachSU_GreedyAttack(Ind))+1;
          tmpChannelInterfered= tmpChannelInterfered+1;  
       end
    end
     ChannelInterfered_GreedyAttack(r)= tmpChannelInterfered/clock_GreedyAttack;
       save('tmp_GreedyAttack','SpoofedSUNum','ChannelInterfered_GreedyAttack','ChannelInterferedDistribution_GreedyAttack');
               %Generate Brutal forceOptimal spoof location 
%         ChannelInterferedBrutalForce=zeros(1,(SizeOfGrid/Resolution)^2);
%          for p=1:(SizeOfGrid/Resolution)
%             for q=1:(SizeOfGrid/Resolution)
% 
%                 SpoofedLocation=[(p-1)*Resolution+1,(q-1)*Resolution+1];%Spoofing Location set by attacker
%                 Lia=ismember(Database(:,ceil(SpoofedLocation(1)),ceil(SpoofedLocation(2))),0);
%                 AvailableChannelatSpoofedLocation=sum(Lia)/NumOfChannels;
%                 FalseAvailableChannelNumber_OptimalAttack= AvailableChannelNumber;
%                 SpoofedSUInd=find(SpoofedSUFlag);
%                 FalseAvailableChannelNumber_OptimalAttack(SpoofedSUInd)= AvailableChannelatSpoofedLocation;
% 
%                 %Simulate optimal attack case
%                 SUTrStatus=zeros(1,SUNumber);%1 means transmission completed
%                 SUTransFinishedNum=0;
%                 clock_OptimalAttack=0;
%                 while(SUTransFinishedNum<SUNumber)
%                     [B,IX]=sort(AvaLocNum+(rand(TotalAvailableChannelNum,1)-0.5));%Sort available channel from low to high and randomly break the tie
%                     SortBSChannelInd=BSChannelInd(IX);
%                    for i=1:TotalAvailableChannelNum
%                        for j=1:NumOfChannels
%                            CandidateSU=0;
%                           AssignedChannelInd=(SortBSChannelInd(i)-1)*NumOfChannels+j;%Subchannel index
%                           AvailableChannelNum=10000*ones(1,SUNumber);
%                           %List vertex coloring
%                           for k=1:SUNumber
%                               if(~SUTrStatus(k))
%                                   if(SpoofedSUFlag(k))
%                                   Location=SpoofedLocation;
%                                   else
%                                   Location=[Coordinate{k}(1),Coordinate{k}(2)];
%                                   end
%                                   if(~Database(AssignedChannelInd,ceil(Location(1)),ceil(Location(2))))%Channel is available at that location
%                                       if(~CandidateSU)
%                                           CandidateSU=AssignedChannelInd;                            
%                                       else
%                                           CandidateSU=[CandidateSU,k];
%                                       end
% 
%                                       AvailableChannelNum(k)=FalseAvailableChannelNumber_OptimalAttack(k);%Num of available channels at location
%                                   end
%                               end
%                           end
%                             if(CandidateSU)
%                               [B,IX]=sort(AvailableChannelNum+(rand(1,SUNumber)-0.5));%Sort by color degree from low to high, break tie randomly
%                               SUTrStatus(IX(1))=1;%Already assigned channel
%                               ChannelIndUsedByEachSU_OptimalAttack(IX(1))= AssignedChannelInd;%Record which channel is assigned
%                               SUTransFinishedNum=SUTransFinishedNum+1;
%                             end
%                        end
%                    end
%                    FalseDenyofServiceNum(r)=FalseDenyofServiceNum(r)+(SUNumber-SUTransFinishedNum);
%                    clock_OptimalAttack=clock_OptimalAttack+1;
%                 end
%                 n=SpoofedSUNum(r);
%                 tmpChannelInterfered=0;
%                 %Check if any spoofed SU interfers with PU
%                 for k=1:n
%                     Ind=SpoofedSUInd(k);
%                    Location= [Coordinate{Ind}(1),Coordinate{Ind}(2)];%Real Location
%                    if(Database(ChannelIndUsedByEachSU_OptimalAttack(Ind),ceil(Location(1)),ceil(Location(2))))%PU is active
%                     ChannelInterferedDistribution_OptimalAttack(r,ChannelIndUsedByEachSU_OptimalAttack(Ind))= ChannelInterferedDistribution_OptimalAttack(r,ChannelIndUsedByEachSU_OptimalAttack(Ind))+1;
%                       tmpChannelInterfered= tmpChannelInterfered+1;  
%                    end
%                 end
%                  
%                    ChannelInterferedBrutalForce((p-1)*SizeOfGrid/Resolution+q)=tmpChannelInterfered;
%             end
%          end
%          [B,IX]=sort(ChannelInterferedBrutalForce,'descend');
%          ChannelInterfered_OptimalAttack(r)= B(1)/clock_OptimalAttack;
%save('tmp_OptimalAttack','SpoofedSUNum','ChannelInterfered_OptimalAttack','ChannelInterferedDistribution_OptimalAttack','ChannelInterferedBrutalForce');
      
end
beep;
