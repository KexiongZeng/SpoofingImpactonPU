
function [InterferePU,InterfereSU]=CheckInterference(CorrectDatabase,false_channel,row,column)
% tmp=load('Correct_Database');
% Database=tmp.Database;
%Reset
InterferePU=0;
InterfereSU=0;
 [ row_lower,row_upper,column_lower,column_upper ] = SetSUProtectBoundary(row,column );
 RangeMatrix=CorrectDatabase(false_channel,row_lower:row_upper,column_lower:column_upper);%Extract the protecting area
% if(false_channel==0)
%     InterferenceType=0;%No interference because of no channel allocation
 Lia_PU=ismember(RangeMatrix,1);%Contains 1 or not
 Lia_SU=ismember(RangeMatrix,2)+ismember(RangeMatrix,3);%contains 2 or 3 or not
%     if(Database(false_channel,row,column)==0)
%         InterferenceType=0;%No interference
%     elseif(Database(false_channel,row,column)==1)
%         InterferenceType=1;%Interference with PU
%     else
%         InterferenceType=2;%Coexistence probelm with SU
%     end
if(max(max(Lia_PU))~=0)
    InterferePU=1;
end
if(max(max(Lia_SU))~=0)
    InterfereSU=1;
end
    
    
