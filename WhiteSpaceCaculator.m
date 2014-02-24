%WhiteSpaceCaculator
clear;
pa=parameter;
dtbs=pa.dtbs;
SizeOfGrid=pa.SizeOfGrid;
Resolution=pa.Resolution;
SideLength=SizeOfGrid/Resolution;
NumOfTowers=pa.NumOfTowers;
NumOfChannels=pa.NumOfChannels;
%NumOfChannels=1;
NumOfSimulatedTowers=pa.NumOfSimulatedTowers;
Database=zeros(NumOfTowers*NumOfChannels,SizeOfGrid,SizeOfGrid);
PUMap=ones(NumOfSimulatedTowers,SizeOfGrid,SizeOfGrid);
PUMapIntersection=ones(NumOfSimulatedTowers,SizeOfGrid,SizeOfGrid);%Intersection available channel between BS and SU
%Store channel availability with resolution
   for j=1: SideLength
      for k=1:SideLength
          Index=(j-1)*SideLength+k;
          count=1;
          while(dtbs(Index,count))
              ChannelIndex=dtbs(Index,count);
              PUMap(ChannelIndex,j,k)=0;
              count=count+1;
          end
      end
   end

   %BSIndex=(SideLength/2-1)*SideLength+SideLength;
   BSChannel=PUMap(:,SideLength/2,SideLength/2);%Base station available channel
   for j=1: SideLength
      for k=1:SideLength
            for i=1:NumOfSimulatedTowers
                Index=(j-1)*SideLength+k;
               if(BSChannel(i)==0&&PUMap(i,j,k)==0) 
                   PUMapIntersection(i,j,k)=0;
               end
            end
      end
   end

    for j=1: SideLength
             for  k=1: SideLength                  
                for l=1:NumOfSimulatedTowers  
                         Database(NumOfChannels*(l-1)+1:NumOfChannels*l,(j-1)*Resolution+1:j*Resolution,(k-1)*Resolution+1:k*Resolution)=PUMapIntersection(l,j,k);
                end
               
             end
    end


save('Initial_Database.mat','Database');   