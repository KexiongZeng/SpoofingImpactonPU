%function RefineDatabase
clear;
global Database;
pa=parameter;
SizeOfGrid=pa.SizeOfGrid;
Resolution=pa.Resolution;
SideLength=SizeOfGrid/Resolution;
NumOfTowers=pa.NumOfTowers;
NumOfChannels=pa.NumOfChannels;
NumOfSimulatedTowers=pa.NumOfSimulatedTowers;
Database=zeros(NumOfTowers*NumOfChannels,SizeOfGrid,SizeOfGrid);
PUMap=zeros(NumOfSimulatedTowers,SizeOfGrid,SizeOfGrid);
  %Go through all grids and devide them to 2 parts. One part has a certain
  %probability of 1, the other has a certain probability of 0.
for l=1:NumOfSimulatedTowers/2
X1=unidrnd(SizeOfGrid);
Y1=unidrnd(SizeOfGrid);
X2=unidrnd(SizeOfGrid);
Y2=unidrnd(SizeOfGrid);
%Linear fucntion y=k*x+b
    if(X1==X2)
     for i=1:SizeOfGrid
       for j=1:SizeOfGrid
           if(j>=X1)
              PUMap(l,i,j)=1;
           else
              PUMap(l,i,j)=0;
           end
       end
     end
    elseif(Y1==Y2)
    for i=1:SizeOfGrid
       for j=1:SizeOfGrid
           if(i>=Y1)
              PUMap(l,i,j)=1;
           else
              PUMap(l,i,j)=0;
           end
       end
    end
    else
    k=(Y1-Y2)/(X1-X2);
    b=Y1-k*X1;
  
        for i=1:SizeOfGrid
           for j=1:SizeOfGrid
               if(i>=k*j+b)
                  PUMap(l,i,j)=1;
               else
                  PUMap(l,i,j)=0;
               end
           end
        end
    end
end

for l=(NumOfSimulatedTowers/2+1):NumOfSimulatedTowers
X1=unidrnd(SizeOfGrid);
Y1=unidrnd(SizeOfGrid);
X2=unidrnd(SizeOfGrid);
Y2=unidrnd(SizeOfGrid);
%Linear fucntion y=k*x+b
    if(X1==X2)
     for i=1:SizeOfGrid
       for j=1:SizeOfGrid
           if(j<=X1)
              PUMap(l,i,j)=1;
           else
              PUMap(l,i,j)=0;
           end
       end
     end
    elseif(Y1==Y2)
    for i=1:SizeOfGrid
       for j=1:SizeOfGrid
           if(i<=Y1)
              PUMap(l,i,j)=1;
           else
              PUMap(l,i,j)=0;
           end
       end
    end
    else
    k=(Y1-Y2)/(X1-X2);
    b=Y1-k*X1;
  
        for i=1:SizeOfGrid
           for j=1:SizeOfGrid
               if(i<=k*j+b)
                  PUMap(l,i,j)=1;
               else
                  PUMap(l,i,j)=0;
               end
           end
        end
    end
end

%Base station coordinate
X_BS=SizeOfGrid/2;
Y_BS=SizeOfGrid/2;

%database is channel availability, PUMap is PU activity 
for l=1:NumOfSimulatedTowers
   for i=1: SizeOfGrid
      for j= 1: SizeOfGrid
          %r=round(sqrt((i-X_BS)^2+(j-Y_BS)^2));
          r_square=(i-X_BS)^2+(j-Y_BS)^2;
%           row_lower=max(1,i-r);
%           row_upper=min(SizeOfGrid,i+r);
%           column_lower=max(1,j-r);
%           column_upper=min(SizeOfGrid,j+r);
%           Lia=ismember(PUMap(l,row_lower:row_upper,column_lower:column_upper),1);
%           if(max(max(Lia))==1)
%           Database(NumOfChannels*(l-1)+1:NumOfChannels*l,i,j)=1;%Check the whole communication range of PU interference
%           else
%           Database(NumOfChannels*(l-1)+1:NumOfChannels*l,i,j)=0;
%           end

% Check area availability
flag=false;
          for m=1: SizeOfGrid
             for  k=1: SizeOfGrid
                 if((i-m)^2+(j-k)^2<=r_square)
                     %If any PU is active in the transmission range
                     if(PUMap(l,m,k)==1)
                         Database(NumOfChannels*(l-1)+1:NumOfChannels*l,i,j)=1;
                         flag=true;
                         break;
                     end
                 end
             end
             if(flag)
                break; 
             end
          end
      end
   end
end

save('Initial_Database.mat','Database');