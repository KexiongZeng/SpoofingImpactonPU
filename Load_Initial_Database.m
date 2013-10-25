%Load initial database 
function Load_Initial_Database
global Database;
Initial_Database=load('Initial_Database');
Database=Initial_Database.Database;
%save('Current_Database.mat','Database');