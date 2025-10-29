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