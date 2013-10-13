function [ row_lower,row_upper,column_lower,column_upper ] = SetAttackerSpoofBoundary(row,column )
% Sets Spoof boundary of the attacker
pa=parameter;
SpoofRange = pa.SpoofRange;
SizeOfGrid = pa.SizeOfGrid;
row_lower=row-SpoofRange;
row_upper=row+SpoofRange;
column_lower=column-SpoofRange;
column_upper=column+SpoofRange;
if(row_lower<1)
    row_lower=1;
end
if(column_lower<1)
    column_lower=1;
end
if(row_upper>SizeOfGrid)
    row_upper=SizeOfGrid;
end
if(column_upper>SizeOfGrid)
    column_upper=SizeOfGrid;
end


end

