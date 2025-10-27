USE OLIST_DWH;

-- Date
SELECT *
FROM DWH_DimDate;

-- OrderItems

CREATE TABLE dbo.[DWH_DimOrderItems] (
    [order_item_key] INT PRIMARY KEY IDENTITY(1, 1),
    [order_id] varchar(50),
    [order_item_id] varchar(4),
    [product_id] varchar(50),
    [seller_id] varchar(50),
    [shipping_limit_date] datetime,
    [price] decimal(28,2),
    [freight_value] decimal(28,2),
    IsInferred BIT NOT NULL DEFAULT 0
);

DROP TABLE DWH_DimOrderItems;

SELECT *
FROM DWH_DimOrderItems;

SELECT COUNT(DISTINCT order_item_key)
FROM DWH_DimOrderItems;

SELECT COUNT(DISTINCT order_id)
FROM DWH_DimOrderItems;

TRUNCATE TABLE DWH_DimOrderItems;
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