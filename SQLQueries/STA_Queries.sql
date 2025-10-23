USE OLIST_STA

-- Customers
CREATE TABLE dbo.[STA_Customers] (
    [customer_id] varchar(50),
    [customer_unique_id] varchar(50),
    [customer_zip_code_prefix] VARCHAR(50),
    [customer_city] varchar(50),
    [customer_state] varchar(50)
);

SELECT *
FROM STA_Customers;

SELECT COUNT(DISTINCT customer_id)
FROM STA_Customers;

DROP TABLE dbo.STA_Customers;

-- OrderItems
CREATE TABLE dbo.[STA_OrderItems] (
    [order_id] varchar(50),
    [order_item_id] varchar(50),
    [product_id] varchar(50),
    [seller_id] varchar(50),
    [shipping_limit_date] varchar(50),
    [price] varchar(50),
    [freight_value] varchar(50)
)

SELECT *
FROM STA_OrderItems;

SELECT COUNT(DISTINCT order_id)
FROM STA_OrderItems;

DROP TABLE dbo.STA_OrderItems;

-- OrderPayments

CREATE TABLE dbo.[STA_OrderPayments] (
    [order_id] varchar(50),
    [payment_sequential] varchar(50),
    [payment_type] varchar(50),
    [payment_installments] varchar(50),
    [payment_value] varchar(50)
)

SELECT *
FROM STA_OrderPayments;

SELECT COUNT(DISTINCT order_id)
FROM STA_OrderPayments;

-- OrderReviews

CREATE TABLE dbo.[STA_OrderReviews] (
    [review_id] nvarchar(255),
    [order_id] nvarchar(255),
    [review_score] nvarchar(50),
    [review_comment_title] nvarchar(255),
    [review_comment_message] nvarchar(max),
    [review_creation_date] nvarchar(50),
    [review_answer_timestamp] nvarchar(50)
);

SELECT *
FROM STA_OrderReviews;

SELECT COUNT(DISTINCT review_id)
FROM STA_OrderReviews;

DROP TABLE STA_OrderReviews;

sp_help 'dbo.STA_OrderReviews';

-- Orders

CREATE TABLE dbo.[STA_Orders] (
    [order_id] varchar(50),
    [customer_id] varchar(50),
    [order_status] varchar(50),
    [order_purchase_timestamp] varchar(50),
    [order_approved_at] varchar(50),
    [order_delivered_carrier_date] varchar(50),
    [order_delivered_customer_date] varchar(50),
    [order_estimated_delivery_date] varchar(50)
)

SELECT *
FROM STA_Orders;

SELECT COUNT(DISTINCT order_id)
FROM STA_Orders;

-- Products
CREATE TABLE dbo.[STA_Products] (
    [product_id] varchar(50),
    [product_category_name] varchar(50),
    [product_name_lenght] varchar(50),
    [product_description_lenght] varchar(50),
    [product_photos_qty] varchar(50),
    [product_weight_g] varchar(50),
    [product_length_cm] varchar(50),
    [product_height_cm] varchar(50),
    [product_width_cm] varchar(50)
)

SELECT *
FROM STA_Products;

SELECT COUNT(DISTINCT product_id)
FROM STA_Products;

-- Sellers

CREATE TABLE dbo.[STA_Sellers] (
    [seller_id] varchar(50),
    [seller_zip_code_prefix] varchar(50),
    [seller_city] varchar(50),
    [seller_state] varchar(50)
)

SELECT *
FROM STA_Sellers;

SELECT COUNT(DISTINCT seller_id)
FROM STA_Sellers;

-- ProductTranslations

CREATE TABLE dbo.[STA_ProductTranslations] (
    [product_category_name] varchar(50),
    [product_category_name_english] varchar(50)
)

SELECT *
FROM STA_ProductTranslations;

SELECT COUNT(DISTINCT product_category_name)
FROM STA_ProductTranslations;