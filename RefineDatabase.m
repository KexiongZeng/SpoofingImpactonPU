function RefineDatabase
global Database;
global PUMap;
pa=parameter;
SizeOfGrid=pa.SizeOfGrid;
Resolution=pa.Resolution;
SideLength=SizeOfGrid/Resolution;
NumOfTowers=pa.NumOfTowers;
NumOfChannels=pa.NumOfChannels;
Database=zeros(NumOfTowers*NumOfChannels,SizeOfGrid,SizeOfGrid);
PUMap=zeros(NumOfTowers,SideLength,SideLength);

  %Go through all grids and devide them to 2 parts. One part has a certain
  %probability of 1, the other has a certain probability of 0.
for l=1:NumOfTowers
X1=unidrnd(SideLength);
Y1=unidrnd(SideLength);
X2=unidrnd(SideLength);
Y2=unidrnd(SideLength);
%Linear fucntion y=k*x+b
    if(X1==X2)
     for i=1:SideLength
       for j=1:SideLength
           if(j>=X1)
              PUMap(l,i,j)=randi(10)>2;
           else
              PUMap(l,i,j)=randi(10)<2;
           end
       end
     end
    elseif(Y1==Y2)
    for i=1:SideLength
       for j=1:SideLength
           if(i>=Y1)
              PUMap(l,i,j)=randi(10)>2;
           else
              PUMap(l,i,j)=randi(10)<2;
           end
       end
    end
    else
    k=(Y1-Y2)/(X1-X2);
    b=Y1-k*X1;
  
        for i=1:SideLength
           for j=1:SideLength
               if(i>=k*j+b)
                  PUMap(l,i,j)=randi(10)>2;
               else
                  PUMap(l,i,j)=randi(10)<2;
               end
           end
        end
    end
end

for l=1:NumOfTowers
   for i=1: SideLength
      for j= 1: SideLength
          Database(NumOfChannels*(l-1)+1:NumOfChannels*l,Resolution*(i-1)+1:Resolution*i,Resolution*(j-1)+1:Resolution*j)=PUMap(l,i,j);%Extend PUMap to Database
      end
   end
end