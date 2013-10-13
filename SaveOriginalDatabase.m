function SaveOriginalDatabase
tmp=load('Current_Database');
Database=tmp.Database;
save('Correct_Database.mat','Database');