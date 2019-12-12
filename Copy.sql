
-- copy a table, but not its structure (primary key, index, ...)
SELECT * INTO NewCopyTableName FROM TableName;


/*************** OR **************/
--1 COPY TABLE STRUCTURE : 
--Database -> Task -> Generate Scripts...
--OR Script Table as -> CREATE To -> New Query Editor Window
CREATE TABLE NewCopyTableName ... ;
--2 - 
INSERT INTO NewCopyTableName SELECT * FROM TableName;


/*************** OR **************/

