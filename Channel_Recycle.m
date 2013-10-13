
function Channel_Recycle( count_tower, row, column )
% Modifies the database to release channel and surrounding SU Protected
% Range 
global Database;
[row_lower,row_upper,column_lower,column_upper] = SetSUProtectBoundary(row,column);
Database(count_tower,row_lower:row_upper,column_lower:column_upper)=0;
end

