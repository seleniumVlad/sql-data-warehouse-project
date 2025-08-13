/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

--create new database
create database DataWarehouse;

use DataWarehouse;
--create schemas
create schema bronze;
create schema silver;
create schema gold;


if OBJECT_ID ('bronze.crm_cust_info', 'U') is not null
	drop table bronze.crm_cust_info;
--Create Tables on bronze layer
create table bronze.crm_cust_info
(
cst_id int,
cst_key nvarchar(50),
cst_firstname nvarchar(50),
cst_lastname nvarchar(50),
cst_marital_status nvarchar(50),
cst_gndr nvarchar(50),
cst_create_date date
);
create table bronze.crm_prd_info
(
prd_id int,
prd_key nvarchar(50),
prd_nm nvarchar(50),
prd_cost int,
prd_line nvarchar(50),
prd_start_dt datetime,
prd_end_dt datetime
);
create table bronze.crm_sales_details
(
sls_ord_num nvarchar(50),
sls_prd_key nvarchar(50),
sls_cust_id int,
sls_order_dt int,
sls_ship_dt int,
sls_due_dt int,
sls_sales int,
sls_quantity int,
sls_price int
);

--Create Table on Bronze Layer
if object_id ('bronze.erp_cust_AZ12', 'U') is not null
	drop table bronze.erp_cust_AZ12;
create table bronze.erp_cust_AZ12
(
CID nvarchar(50),
BDATE date,
GEN nvarchar(50)
);
create table bronze.erp_loc_A101
(
CID nvarchar(50),
CNTRY nvarchar(50)
);
create table bronze.erp_px_cat_G1V2
(
ID nvarchar(50),
CAT nvarchar(50),
SUBCAT nvarchar(50),
MAINTENANCE nvarchar(50)
);













