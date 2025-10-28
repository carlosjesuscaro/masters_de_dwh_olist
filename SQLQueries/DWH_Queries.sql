USE OLIST_DWH;

-- Sellers

CREATE TABLE dbo.[DWH_DimSellers] (
    [seller_key] INT PRIMARY KEY IDENTITY(1, 1),
    [seller_id] varchar(50),
    [seller_zip_code_prefix] varchar(5),
    [seller_city] varchar(50),
    [seller_state] varchar(2),
    IsInferred BIT NOT NULL DEFAULT 0
);

SELECT *
FROM DWH_DimSellers;

SELECT COUNT(DISTINCT seller_key)
FROM DWH_DimSellers;

SELECT COUNT(DISTINCT seller_id)
FROM DWH_DimSellers;

-- Products

CREATE TABLE dbo.[DWH_DimProducts] (
    [product_key] INT PRIMARY KEY IDENTITY(1, 1),
    [product_id] varchar(50),
    [product_category_name_english] varchar(50),
    [product_category_name_portuguese] varchar(50),
    [product_name_lenght] int,
    [product_description_lenght] int,
    [product_photos_qty] int,
    [product_weight_g] decimal(28, 2),
    [product_length_cm] decimal(28, 2),
    [product_height_cm] decimal(28, 2),
    [product_width_cm] decimal(28, 2),
    IsInferred BIT NOT NULL DEFAULT 0
);

SELECT *
FROM DWH_DimProducts;

SELECT COUNT(DISTINCT product_key)
FROM DWH_DimProducts;

SELECT COUNT(DISTINCT product_id)
FROM DWH_DimProducts;

-- OrderReviews

CREATE TABLE dbo.[DWH_DimOrderReviews] (
    [order_review_key] INT PRIMARY KEY IDENTITY(1, 1),
    [review_id] nvarchar(255),
    [order_id] nvarchar(255),
    [review_score] int,
    [review_comment_title] nvarchar(255),
    [review_comment_message] nvarchar(max),
    [review_creation_date] datetime,
    [review_answer_timestamp] datetime,
    IsInferred BIT NOT NULL DEFAULT 0
);

SELECT *
FROM DWH_DimOrderReviews;

SELECT COUNT(DISTINCT review_id)
FROM DWH_DimOrderReviews;

SELECT COUNT(DISTINCT order_review_key)
FROM DWH_DimOrderReviews;

TRUNCATE TABLE DWH_DimOrderReviews;

-- PrderPayments

CREATE TABLE dbo.[DWH_DimOrderPayments] (
    [order_payment_key] INT PRIMARY KEY IDENTITY(1, 1),
    [order_id] varchar(50),
    [payment_sequential] int,
    [payment_type] varchar(12),
    [payment_installments] int,
    [payment_value] decimal(28,2),
    IsInferred BIT NOT NULL DEFAULT 0
);

SELECT *
FROM DWH_DimOrderPayments;

SELECT COUNT(DISTINCT order_payment_key)
FROM DWH_DimOrderPayments;

SELECT COUNT(DISTINCT order_id)
FROM DWH_DimOrderPayments;

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