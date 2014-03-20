function [ row_lower,row_upper,column_lower,column_upper ] = SetBoundary(row,column,range )
% Sets protection boundary limits for SU
pa=parameter;
SizeOfGrid=pa.SizeOfGrid;
row_lower=ceil(row-range);
row_upper=ceil(row+range);
column_lower=ceil(column-range);
column_upper=ceil(column+range);
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

