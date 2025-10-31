USE OLIST_DWH;

-- 1. Rank the states based on number of orders

SELECT TOP 10
	dc.customer_state,
	COUNT(DISTINCT fo.order_id) AS orders_count
FROM DWH_FactOrders AS fo
LEFT JOIN DWH_DimCustomers AS dc
	ON fo.customer_key = dc.customer_key
LEFT JOIN DWH_DimOrderPayments AS dop
	ON fo.order_id = dop.order_id
GROUP BY customer_state
ORDER BY orders_count DESC;

-- 2. Rank the states based on the average order value

SELECT TOP 10
	dc.customer_state,
	AVG(dop.payment_value) AS avg_payment
FROM DWH_FactOrders AS fo
LEFT JOIN DWH_DimCustomers AS dc
	ON fo.customer_key = dc.customer_key
LEFT JOIN DWH_DimOrderPayments AS dop
	ON fo.order_id = dop.order_id
GROUP BY customer_state
ORDER BY avg_payment DESC;	

-- 3. Seller ranking based on number of order and including the seller's state

SELECT
	DISTINCT doi.seller_id,
	ds.seller_state,
	COUNT(doi.order_id) OVER(PARTITION BY doi.seller_id) AS count_order_per_seller
FROM DWH_DimOrderItems AS doi
LEFT JOIN DWH_DimSellers AS ds
ON doi.seller_id = ds.seller_id
ORDER BY count_order_per_seller DESC;

-- 4. Top 10 product_categories with the higghest reviews

SELECT TOP 10
	dp.product_category_name_english,
	AVG(dor.review_score) AS product_category_review
FROM DWH_FactOrders AS fo
LEFT JOIN DWH_DimOrderItems AS doi
ON fo.order_id = doi.order_id
LEFT JOIN DWH_DimProducts AS dp
ON doi.product_id = dp.product_id
LEFT JOIN DWH_DimOrderReviews AS dor
ON dor.order_id = doi.order_id
WHERE 
	dp.product_category_name_english IS NOT NULL
	AND dor.review_score IS NOT NULL
GROUP BY product_category_name_english
ORDER BY product_category_review DESC;

-- 5. Top 10 sellers with the highest number of late deliveries
WITH delivery AS (
	SELECT 
	fo.order_id,
	CASE
		WHEN fo.order_delivered_customer_date > fo.order_estimated_delivery_date THEN 'Late'
			ELSE 'On time'
		END AS deadline
	FROM DWH_FactOrders AS fo)
SELECT TOP 10
	ds.seller_id,
	COUNT(delivery.deadline) AS late_count
FROM DWH_DimOrderItems AS doi
LEFT JOIN delivery
	ON doi.order_id = delivery.order_id
LEFT JOIN DWH_DimSellers AS ds
	ON ds.seller_id = doi.seller_id
WHERE 
	delivery.deadline = 'Late'
GROUP BY ds.seller_id
ORDER BY late_count DESC;
