USE OLIST_STA
CREATE TABLE dbo.[STA_Customers] (
    [customer_id] varchar(50),
    [customer_unique_id] varchar(50),
    [customer_zip_code_prefix] varchar(50),
    [customer_city] varchar(50),
    [customer_state] varchar(50)
);


SELECT *
FROM STA_Customers;

SELECT COUNT(DISTINCT customer_id)
FROM STA_Customers;