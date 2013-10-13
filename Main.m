%Simulate SUs join and request available channels in Database-driven CRNs
global Database;
pa=parameter;
SUNumber=pa.SUNumber;%Number of SUs
SUProtectRange=pa.SUProtectRange;
SizeOfGrid=pa.SizeOfGrid;
RunTimes=pa.RunTimes;% Number of Cases
SpoofRange=pa.SpoofRange;%Spoofing capability
ChannelUsing=zeros(1,SUNumber);%Which channel the SU is using
Coordinate=cell(1,SUNumber);%Store coordinates for SUNumber SUs
SpoofedSUOriginalLocation=cell(1,SUNumber);%Store the original location of SUs spoofed
FalseAvailableChannel=zeros(1,SUNumber);%Store the channels falsely assigned to spoofed SUs
ChannelRunOut=zeros(1,RunTimes);%Store channel run out reports for initial set up for SUNmber SUs
FalseChannelRunOut=zeros(1,RunTimes);%Store how many SUs are falsly denied of service
InterferePU=zeros(1,RunTimes);%Store how many interference with PUs
CoexistenceSU=zeros(1,RunTimes);%Store how many coexistence problems with SU
SpoofedSUIndex=zeros(1,SUNumber);%Store the SU index in Coordinate
for r=1:RunTimes
        Load_Initial_Database;%Reset Database 
        AttackerLocation=[unidrnd(SizeOfGrid),unidrnd(SizeOfGrid)];%Attacker Location
        [ row_lower,row_upper,column_lower,column_upper ] = SetAttackerSpoofBoundary(AttackerLocation(1,1),AttackerLocation(1,2) );
        SpoofedLocation=[unidrnd(SizeOfGrid),unidrnd(SizeOfGrid)];%Spoofing Location set by attacker
        SpoofedSUCount=1;
        %Initial Channel allocation for the first SUNumber SUs
    for i=1:SUNumber
        row=unidrnd(SizeOfGrid);
        column=unidrnd(SizeOfGrid);
        Coordinate{1,i}=[row,column];
       
        %Channel allocation
        AvailableChannel=ChannelAllocation(row,column);
        ChannelUsing(1,i)=AvailableChannel;
        
         %Check if the SU is within spoofing range, if so we store its
        %original location
        if((row>=row_lower)&&(row<=row_upper)&&(column>=column_lower)&&(column<=column_upper))

            SpoofedSUOriginalLocation{1,SpoofedSUCount}=[row,column];
            SpoofedSUIndex(1,SpoofedSUCount)=i;
            SpoofedSUCount=SpoofedSUCount+1;

        end
        
        if(AvailableChannel==0)
        ChannelRunOut(1,r)=ChannelRunOut(1,r)+1;%Store channel run out for every case
        display('Oops!We are out of available channel!')
        end
    end
        %
        

        %Check all spoofed SUs to see if there are any false channel run
        %out and interference with PU and coexistence problems with SU

    for j=1:(SpoofedSUCount-1)
        if(ChannelUsing(1,SpoofedSUIndex(1,j))~=0)
        Channel_Recycle(ChannelUsing(1,SpoofedSUIndex(1,j)),SpoofedSUOriginalLocation{1,j}(1,1),SpoofedSUOriginalLocation{1,j}(1,2)); %recycle channels at the real location
        end       
    end
        %Save the original databse
        save('Correct_Database.mat','Database');
        Correct_Database=Database;

     for j=1:(SpoofedSUCount-1)    
            FalseAvailableChannel(1,j)=ChannelAllocation(SpoofedLocation(1,1),SpoofedLocation(1,2));%allocate channels at the fake location
            if(FalseAvailableChannel(1,j)==0)
                FalseChannelRunOut(1,r)=FalseChannelRunOut(1,r)+1;%The total false deny of service to SU 
            else
                [PU,SU]=CheckInterference( Correct_Database,FalseAvailableChannel(1,j),SpoofedSUOriginalLocation{1,j}(1,1),SpoofedSUOriginalLocation{1,j}(1,2));%Check if there are any interference with PU or coexistence problems with SU
                if(PU==1)
                    InterferePU(1,r)=InterferePU(1,r)+1;%Mark as interference with PU 
                end
                if(SU==1)
                    CoexistenceSU(1,r)=CoexistenceSU(1,r)+1;%Mark as coexistence problems with SU
                end
            end
        %
    end;

end
    filename=['Result_SUNUmber_',num2str(SUNumber),'_SUProtectRange_',num2str(SUProtectRange),'_SpoofRange_',num2str(SpoofRange)];
    save(filename,'FalseChannelRunOut','InterferePU','CoexistenceSU');
