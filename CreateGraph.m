%Creating connectivity graph
function [E,Degree]=CreateGraph(Coordinate)
pa=parameter;
SUNumber=pa.SUNumber;%Number of SUs
SizeOfGrid=pa.SizeOfGrid;
E=zeros((1+SUNumber)*SUNumber/2,2);%Connectivity matrix
Degree=zeros(1,SUNumber);
k=1;%Index of E
%Base station coordinate
X_BS=SizeOfGrid/2;
Y_BS=SizeOfGrid/2;
for i=1:SUNumber
          X_1=Coordinate{1,i}(1);
          Y_1=Coordinate{1,i}(2);
%           X_1=80;
%           Y_1=75;
          r_1_square=(X_1-X_BS)^2+(Y_1-Y_BS)^2;
           %[ row_lower,row_upper,column_lower,column_upper ] = SetSUProtectBoundary(Coordinate{1,i}(1), Coordinate{1,i}(2));
   for j=(i+1):SUNumber
       %If two circles are overlapped, nodes are connected
          X_2=Coordinate{1,j}(1);
          Y_2=Coordinate{1,j}(2);
%           X_2=80;
%           Y_2=85;
       r_2_square=(X_2-X_BS)^2+(Y_2-Y_BS)^2;
       d_square=(X_1-X_2)^2+(Y_1-Y_2)^2;
       %Check if one is in the transmission range
       % if(d_square<r_1_square||d_square<r_2_square)
        if(1)%all nodes are connected at BaseStation
            E(k,1)=i;
            E(k,2)=j;
            k=k+1;
            Degree(1,i)=Degree(1,i)+1;
            Degree(1,j)=Degree(1,j)+1;
        end
       
   end
end

E=E(1:k-1,:);
