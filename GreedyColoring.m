%Greedy Coloring
function ColorChannel=GreedyColoring(E,Degree,Coordinate,AvailableChannelNumber)
pa=parameter;
SUNumber=pa.SUNumber;%Number of SUs
NumOfTowers=pa.NumOfTowers;
NumOfChannels=pa.NumOfChannels;
global Database;
%Database(151:300,:,:)=0;
ColorChannel=zeros(1,SUNumber);
ColoringClass=zeros(1,NumOfTowers*NumOfChannels);%Channel already assigned
Degree_Channel=Degree-AvailableChannelNumber;
[D,SortSUIndex]=sort(Degree_Channel,'descend');
 ColorIndex=1;%Used by coloringclass
%Assign channel
for i=1:SUNumber
    RealIndex=SortSUIndex(1,i);
    if(Degree(1,RealIndex)~=0) %Have neighbors
      Neighbors=[E(find(E(:,1)==RealIndex),2); E(find(E(:,2)==RealIndex),1)];%Find index of neighboring SUs
      NeighborChannel=zeros(1,size(Neighbors,1));  
          for j=1:size(Neighbors,1)
            NeighborChannel(1,j)=ColorChannel(1,Neighbors(j));%Neighbors(j) is real index 
          end
    else
        Neighbors=0;
        NeighborChannel=0;
    end
    

    %Try to Assign used channel first
    backup=0;%
    for j=1:NumOfTowers*NumOfChannels
        if(Database(j,Coordinate{1,RealIndex}(1),Coordinate{1,RealIndex}(2))==0&&isempty(find(NeighborChannel(:)==j)))%No interference with PU or neighbor's assigned channels
            if(isempty(find(ColoringClass(:)==j))~=1)%Channel j is at the assigned class
               ColorChannel(1,RealIndex)=j; 
               break;
            else
                backup=j;
            end
        end
    end
    
    if(ColorChannel(1,RealIndex)==0&&backup~=0)%If no channel in class can be assigned then assign a new channel
        ColorChannel(1,RealIndex)=backup;
        ColoringClass(1, ColorIndex)=backup;
        ColorIndex=ColorIndex+1;
    end
    
%     while(ColoringClass(1,ColorIndex)~=0&&ColorIndex<=NumOfTowers)
%         if((Database(ColoringClass(1,ColorIndex),Coordinate{1,RealIndex}(1),Coordinate{1,RealIndex}(2))==0)&&isempty(find(NeighborChannel(:)==ColoringClass(1,ColorIndex))))
%             %Check interference with PU or neighbor's assigned channels
%             ColorChannel(1,RealIndex)=ColoringClass(1,ColorIndex);
%             break;
%         else
%             ColorIndex=ColorIndex+1;
%         end
%     end

end