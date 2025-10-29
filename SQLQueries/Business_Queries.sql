USE OLIST_DWH;

SELECT
	A.order_id, 
	B.payment_value,
	B.payment_type
FROM DWH_FactOrders AS A
LEFT JOIN DWH_DimOrderPayments AS B
ON A.order_id = B.order_id
WHERE 
	B.payment_value > 5000;

SELECT TOP 10 *
FROM DWH_FactOrders;

-- Business questions

-- 1. Rank the states based on number of orders

-- 2. Rank the states based on the averagew order value

-- 3. Rank the states based on average order value per customer

-- 4. Rank the sellers based on average and number of orders

-- 5. What sellers have the shortest delivery time

-- 6. Rank the sellers based on the number of late deliveries

-- 7. Rank the products based on reviews

-- 8. What are the most popular categories

-- 9. What is the average product value based on the number of photos per product amd/pr category?

-- 10. What state has the highest average of number of installments?

SELECT COUNT(DISTINCT order_id)
FROM DWH_FactOrders;

SELECT TOP 10 *
FROM DWH_DimOrderPayments;

SELECT TOP 10 *
FROM DWH_DimOrderReviews;

SELECT TOP 10 *
FROM DWH_DimOrderItems;

SELECT TOP 10 *
FROM DWH_DimCustomers;

SELECT TOP 10 *
FROM DWH_DimProducts;

SELECT TOP 10 *
FROM DWH_DimSellers;