/*
====================================
BULK INSERT sql query
====================================
*/
/*
=========================================
Example:

BULK INSERT bronze.source_tableName
FROM 'destination'
WITH
(
Specify any file configuration inputs. There is lots of them how you wanna do it.
	firstrow=2 			  (1st row always a header),
	fieldterminator = ',' (delimiter, how values are separated in CSV)
	tablock			  	  (optional, system locks this table while loading/inserting data, so no one can use it)	
)
=============================================
*/

TRUNCATE TABLE bronze.crm_cust_info; 	--optional, way to refresh table 

BULK INSERT bronze.crm_cust_info 
FROM 'C:\home\usr\Document\WH Project\source\crm_cust_info.csv'
WITH(
	firstrow = 2,
	fieldterminator = ',',
	tablock
);

/*
============================================
Note:
AFTER INSERT, validate data input correctly-
-rows, columns, values, format of data, correct data in each column
-count
============================================
*/

