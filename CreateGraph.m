%Creating connectivity graph
function [E,Degree]=CreateGraph(Coordinate)
pa=parameter;
SUNumber=pa.SUNumber;%Number of SUs
SUProtectRange=pa.SUProtectRange;
E=zeros((1+SUNumber)*SUNumber/2,2);%Connectivity matrix
Degree=zeros(1,SUNumber);
k=1;%Index of E
for i=1:SUNumber
           [ row_lower,row_upper,column_lower,column_upper ] = SetSUProtectBoundary(Coordinate{1,i}(1), Coordinate{1,i}(2));
   for j=(i+1):SUNumber
        if((Coordinate{1,j}(1)>=row_lower)&&(Coordinate{1,j}(1)<=row_upper)&&(Coordinate{1,j}(2)>=column_lower)&&(Coordinate{1,j}(2)<=column_upper))
            E(k,1)=i;
            E(k,2)=j;
            k=k+1;
            Degree(1,i)=Degree(1,i)+1;
            Degree(1,j)=Degree(1,j)+1;
        end
       
   end
end

E=E(1:k-1,:);
