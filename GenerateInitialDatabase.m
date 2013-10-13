%Generate Initial Database with 0.5 mile resolution
clc;
clear;
close all;
pa = parameter;
NumOfTowers=pa.NumOfTowers;
NumOfPoints=pa.NumOfPoints;
NumOfSimulatedTowers = pa.NumOfSimulatedTowers;
Resolution=pa.Resolution;
SizeOfGrid =pa.SizeOfGrid; % Decides the size of matrix for storing information about each channel
Channel_Availability = zeros(NumOfTowers, SizeOfGrid, SizeOfGrid); % 3-D matrix containing channel availability for all 11 towers considered
count_tower = 1;
count_points = 1;
NumOfBlock=ceil(SizeOfGrid/Resolution);%Resolution*Resolution block

for i=1:NumOfTowers
    for j=1:NumOfBlock
        %Row start and end index
           if(j*Resolution>SizeOfGrid)
               row_end=SizeOfGrid;
           else
               row_end=j*Resolution;
           end
           row_start=(j-1)*Resolution+1;
           %Column start and end index
       for k=1:NumOfBlock

           if(k*Resolution>SizeOfGrid)
              column_end=SizeofGrid; 
           else
               column_end=k*Resolution;
           end
          
           column_start=(k-1)*Resolution+1;
           Channel_Availability(i,row_start:row_end,column_start:column_end)=round(rand(1));
       end
    end
    
end


save('Initial_Database.mat','Channel_Availability');