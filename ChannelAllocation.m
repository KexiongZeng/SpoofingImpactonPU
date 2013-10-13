%Database function
function AvailableChannel=ChannelAllocation(row,column)
global Database;
% tmp=load('Current_Database.mat');
% Database=tmp.Database;
pa=parameter;
NumOfTowers=pa.NumOfTowers;
count_tower=1;
AvailableChannel=0;
while(count_tower<=NumOfTowers)
    if(Database(count_tower,row,column)==0)
        Range_Overlap = 0; % Initially assume that SU protected range does not overlap with any PU or SU
        %Set the boundary of SU protected range
        [ row_lower,row_upper,column_lower,column_upper ] = SetSUProtectBoundary(row,column );
        
        %Check SUProtectRange around an available channel to see if any
        %overlap with primary/secondary user
        
%         for i=row_lower : row_upper
%             for j= column_lower : column_upper
%                 if(Database(count_tower,i,j)==1 || Database(count_tower,i,j)==2 || Database(count_tower,i,j)==3)
%                     Range_Overlap = 1;
%                 end
%             end
%         end
        %Avoid using loop for better efficiency
        RangeMatrix=Database(count_tower,row_lower:row_upper,column_lower:column_upper);%Extract the protecting area
        MaxValue=max(max(RangeMatrix));%Get maximum element in this area
        %If they are not straight zeros
        if(MaxValue~=0)
            Range_Overlap=1;
        end
        %
        % If there is overlap, then continue search for available channels
        if(Range_Overlap == 1)
            count_tower = count_tower + 1;
        else
            Database(count_tower,row_lower:row_upper,column_lower:column_upper)=3; %Indicate channel unavailable in order to protect SU
            AvailableChannel=count_tower;
            Database(count_tower,row,column)=2;%Indicate available channel is using by SU
            %save('Current_Database.mat','Database');
            return
        end        
        
    else
        count_tower=count_tower+1;
    end
end


