USE OLIST_STA;

SELECT TOP 10 *
FROM STA_OrderReviews;

SELECT TOP 10 *
FROM STA_Customers;

SELECT TOP 10 *
FROM STA_OrderItems;

SELECT TOP 10 *
FROM STA_OrderPayments;

SELECT DISTINCT payment_type
FROM STA_OrderPayments;

SELECT DISTINCT order_item_id
FROM STA_OrderItems;

SELECT DISTINCT customer_state
FROM STA_Customers;



-----------------------------------------------------------------------------------
USE OLIST_ODS;

-- OrderReviews

CREATE TABLE dbo.[ODS_OrderReviews] (
    [review_id] nvarchar(255),
    [order_id] nvarchar(255),
    [review_score] int,
    [review_comment_title] nvarchar(255),
    [review_comment_message] nvarchar(max),
    [review_creation_date] datetime,
    [review_answer_timestamp] datetime
)

SELECT *
FROM ODS_OrderReviews;

SELECT COUNT(DISTINCT order_id)
FROM ODS_OrderReviews;


-- OrderPayments

CREATE TABLE dbo.[ODS_OrderPayments] (
    [order_id] varchar(50),
    [payment_sequential] int,
    [payment_type] varchar(12),
    [payment_installments] int,
    [payment_value] decimal(28,2)
)

SELECT *
FROM ODS_OrderPayments;

SELECT COUNT(DISTINCT order_id)
FROM ODS_OrderPayments;

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

USE OLIST_ADM;
CREATE TABLE dbo.[TechnicalRejects] (
    [RejectsDate] datetime,
    [RejectsPkgAndTask] nvarchar(100),
    [RejectColumn] nvarchar(50),
    [RejectDescription] nvarchar(90)
) WITH (DATA_COMPRESSION = PAGE)

SELECT *
FROM TechnicalRejects;
