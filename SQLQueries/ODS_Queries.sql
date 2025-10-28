USE OLIST_STA;

SELECT TOP 10 *
FROM STA_Sellers;

SELECT TOP 10 *
FROM STA_Products;

SELECT TOP 10 *
FROM STA_Orders;

SELECT TOP 10 *
FROM STA_OrderReviews;

SELECT TOP 10 *
FROM STA_Customers;

SELECT *
FROM STA_OrderReviews
WHERE review_comment_message IS NOT NULL;

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

SELECT DISTINCT product_category_name
FROM STA_Products;

SELECT product_category_name, product_category_name_english
FROM STA_ProductTranslations;

SELECT *
FROM STA_Products
WHERE product_id = 'c8316575e7ce05609496b6d0b9bce6bd'

SELECT *
FROM STA_Products
WHERE product_category_name IS NULL;

SELECT *
FROM STA_Products
WHERE product_description_lenght = '';

SELECT *
FROM STA_Products
WHERE product_name_lenght = '';

-----------------------------------------------------------------------------------
USE OLIST_ODS;

-- Sellers

CREATE TABLE dbo.[ODS_Sellers] (
    [seller_id] varchar(50),
    [seller_zip_code_prefix] varchar(5),
    [seller_city] varchar(50),
    [seller_state] varchar(2)
);

SELECT *
FROM ODS_Sellers;

SELECT COUNT(DISTINCT seller_id)
FROM ODS_Sellers;

-- Products

CREATE TABLE dbo.[ODS_Products] (
    [product_id] varchar(50),
    [product_category_name_english] varchar(50),
    [product_category_name_portuguese] varchar(50),
    [product_name_lenght] int,
    [product_description_lenght] int,
    [product_photos_qty] int,
    [product_weight_g] decimal(28, 2),
    [product_length_cm] decimal(28, 2),
    [product_height_cm] decimal(28, 2),
    [product_width_cm] decimal(28, 2)
);

SELECT *
FROM ODS_Products;

SELECT *
FROM ODS_Products
WHERE product_category_name_english = '';

SELECT COUNT(DISTINCT product_id)
FROM ODS_Products;

DROP TABLE dbo.ODS_Products;

TRUNCATE TABLE dbo.ODS_Products;

-- Orders

CREATE TABLE dbo.[ODS_Orders] (
    [order_id] varchar(50),
    [customer_id] varchar(50),
    [order_status] varchar(50),
    [order_purchase_timestamp] datetime,
    [order_approved_at] datetime,
    [order_delivered_carrier_date] datetime,
    [order_delivered_customer_date] datetime,
    [order_estimated_delivery_date] datetime,
);

SELECT *
FROM ODS_Orders;

SELECT COUNT(DISTINCT order_id)
FROM ODS_Orders;

-- OrderReviews

CREATE TABLE dbo.[ODS_OrderReviews] (
    [review_id] nvarchar(255),
    [order_id] nvarchar(255),
    [review_score] int,
    [review_comment_title] nvarchar(255),
    [review_comment_message] nvarchar(max),
    [review_creation_date] datetime,
    [review_answer_timestamp] datetime
);

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
);

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
);

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
);

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

TRUNCATE TABLE TechnicalRejects;
