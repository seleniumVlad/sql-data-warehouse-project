/*
=====================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
====================================================
Script Purpose:
  This stored procedure loads data into the 'bronze' schema from external
  CSV files. It performs the following actions:
  -Truncates the bronze tables before loading data.
  -Uses the 'BULK INSERT' command to load data from csv files to bronze talbes.

Parameters:
  None
This Stored Procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
=====================================================
*/

CREATE OR ALTER PROCEDURE bronze.crm_cust_info 
BEGIN 
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

print 'Catch an error if occur-If SQL fails, CATCH will execute'
	-CATCH can be: create a log with error, log error to specific log, ignore error, perform STOP, etc
BEGIN TRY
	SET @batch_start_time = GETDATE();
	print '####################################';
	print 'Loading Bronze Layer';
	print '####################################';
	print '------------------------------------';
	print 'Loading source_CRM table';
	print '------------------------------------';
	
	SET @start_time = GETDATE();
	print '>>Truncating table - Bronze'					>identifying actions
	TRUNCATE TABLE bronze.crm_cust_info;
	
	print '>>Inserting Data'
	INSERT BULK bronze.crm_cust_info 
	FROM 'C:\home\usr\Document\WH Project\source\crm_cust_info.csv'
	WITH
	(
		firstrow = 2,
		fieldterminator = ',',
		tablock
	);
	SET @end_time = GETDATE();
	print '>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR + ' seconds';
			>takes 3 arguments(unit:seconds, minutes, hours),(first date),(second date)
	print '-------------------------------------';
	
	@SET @batch_end_time = GETDATE();
	print '####################################################';
	print 'Loading Bronze Layer is Completed';
	print '		-Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR + ' seconds';
	print '####################################################';
	
END TRY
BEGIN CATCH 
	print '==============================================';
	print 'Error ocurred during BULK loading Bronze Layer';
	print 'Error Message: ' + error_message();
	print 'Error Number: ' + cast(error_number() as NVARCHAR);
	print 'Error State: ' + cast(error_state() as NVARCHAR);
	print '=============================================';
	-google for more options
	-Add ETL Duration, helps keep track time, helps with optimization, detect issue, monitor performance, etc
END CATCH 
END;

EXEC bronze.crm_cust_info
