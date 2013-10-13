clc;
clear;
close all;
pa = parameter;
NumOfTowers=pa.NumOfTowers;
NumOfPoints=pa.NumOfPoints;
NumOfSimulatedTowers = pa.NumOfSimulatedTowers;
SizeOfGrid =pa.SizeOfGrid; % Decides the size of matrix for storing information about each channel
Channel_Availability = zeros(NumOfTowers, SizeOfGrid, SizeOfGrid); % 3-D matrix containing channel availability for all 11 towers considered
count_tower = 1;
count_points = 1;
dtbs=pa.dtbs;
%For every TV tower
while(count_tower <= NumOfSimulatedTowers)
    latPrev = dtbs(((count_tower-1)*NumOfPoints)+1,2);
    row = 1;
    column = 0;
    count_points = 1;
    %For every 24649 grids
    while(count_points <= NumOfPoints)
        currentIndex = (count_tower-1)*NumOfPoints+count_points ; %Computes the location in pa.dtbs corresponding to the tower being considered
        latPresent = dtbs(currentIndex,2);
        if(latPresent == latPrev)
            column = column + 1;
        else
            row = row + 1;
            column = 1;
        end
        latPrev = latPresent;
        Channel_Availability(count_tower,row,column) = compute_Availability(dtbs(currentIndex,3),pa.PowerThresh);
        count_points = count_points + 1;
    end
    %    
%   
    %read from text file to get latitude, longitude and power level
    % Have a variable called latPrev
    %if(latPresent == latPrev)
        %column = column + 1;
        %Ch1_Availability(row,column) = compute_Availability(PowerLevel);
    %else
        %row = row + 1;
        %column = 1;
        %Ch1_Availability(row,column) = compute_Availability(PowerLevel;
     %end
        
      count_tower = count_tower + 1;      
 
end

save('Initial_Database.mat','Channel_Availability');


