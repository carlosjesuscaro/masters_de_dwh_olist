USE OLIST_DWH;

-- Customers

CREATE TABLE dbo.[DWH_DimCustomers] (
    [customer_key] INT PRIMARY KEY IDENTITY(1, 1),
    [customer_id] varchar(50),
    [customer_unique_id] varchar(50),
    [customer_zip_code_prefix] varchar(5),
    [customer_city] varchar(50),
    [customer_state] varchar(2)
);

ALTER TABLE DWH_DimCustomers
ADD IsInferred BIT NOT NULL DEFAULT 0;

SELECT *
FROM DWH_DimCustomers;

SELECT *
FROM DWH_DimCustomers;

SELECT COUNT(DISTINCT customer_id)
FROM DWH_DimCustomers;

USE OLIST_ODS;

SELECT *
FROM ODS_Customers;