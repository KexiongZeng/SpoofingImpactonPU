function [ row_lower,row_upper,column_lower,column_upper ] = SetSUProtectBoundary(row,column )
% Sets protection boundary limits for SU
pa=parameter;
SUProtectRange = pa.SUProtectRange;
SizeOfGrid = pa.SizeOfGrid;
row_lower=row-SUProtectRange;
row_upper=row+SUProtectRange;
column_lower=column-SUProtectRange;
column_upper=column+SUProtectRange;
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

