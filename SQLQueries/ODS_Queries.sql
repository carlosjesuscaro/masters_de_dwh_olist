USE OLIST_STA;

SELECT TOP 10 *
FROM STA_Customers;

SELECT TOP 10 *
FROM STA_OrderItems

SELECT DISTINCT order_item_id
FROM STA_OrderItems;

SELECT DISTINCT customer_state
FROM STA_Customers;

-----------------------------------------------------------------------------------
USE OLIST_ODS;

-- Customers
CREATE TABLE dbo.[ODS_Customers] (
    [customer_id] varchar(50),
    [customer_unique_id] varchar(50),
    [customer_zip_code_prefix] varchar(5),
    [customer_city] varchar(50),
    [customer_state] varchar(2)
)

SELECT *
FROM ODS_Customers;

SELECT COUNT(DISTINCT customer_id)
FROM ODS_Customers;

-- OrderItems

CREATE TABLE dbo.[ODS_OrderItems] (
    [order_id] varchar(50),
    [order_item_id] varchar(4),
    [product_id] varchar(50),
    [seller_id] varchar(50),
    [shipping_limit_date] datetime,
    [price] decimal(28,2),
    [freight_value] decimal(28,2),
)

SELECT *
FROM ODS_OrderItems;

SELECT COUNT(DISTINCT order_id)
FROM ODS_OrderItems;

EXEC sp_help 'ODS_OrderItems';

DROP TABLE ODS_OrderItems;

-----------------------------------------------------------------------------------

USE OLIST_ADM
CREATE TABLE dbo.[TechnicalRejects] (
    [RejectsDate] datetime,
    [RejectsPkgAndTask] nvarchar(100),
    [RejectColumn] nvarchar(50),
    [RejectDescription] nvarchar(90)
) WITH (DATA_COMPRESSION = PAGE)

SELECT *
FROM TechnicalRejects;
