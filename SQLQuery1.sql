-- total sales of each product category
SELECT dbo.Products.product_category_name , ROUND(SUM(dbo.OrderItems.price),2) As Total_sales
FROM ((dbo.OrderItems 
Inner join dbo.Orders  ON dbo.OrderItems.order_id = dbo.Orders.order_id)
Inner Join dbo.Products  ON dbo.OrderItems.product_id  = dbo.Products.product_id)
Group by dbo.Products.product_category_name;

-- retrieving customers who made purchase in the last month relative to dates in purchase timestamp regardless shipped or not
SELECT customer_unique_id
FROM (dbo.Customers 
INNER JOIN dbo.Orders ON dbo.Customers.customer_id  = dbo.Orders.customer_id)
WHERE dbo.Orders.order_purchase_timestamp >= DATEADD(month, DATEDIFF(month, 0, (SELECT MAX(dbo.Orders.order_purchase_timestamp) FROM dbo.Orders)) , 0)


-- retrieving customers who made purchase in previous last month relative to dates in purchase timestamp regardless shipped or not
SELECT customer_unique_id
FROM (dbo.Customers 
INNER JOIN dbo.Orders ON dbo.Customers.customer_id  = dbo.Orders.customer_id)
WHERE dbo.Orders.order_purchase_timestamp > DATEADD(month, DATEDIFF(month, 0, (SELECT MAX(dbo.Orders.order_purchase_timestamp) FROM dbo.Orders)) - 1, 0)
  AND dbo.Orders.order_purchase_timestamp < DATEADD(month, DATEDIFF(month, 0, (SELECT MAX(dbo.Orders.order_purchase_timestamp) FROM dbo.Orders)), 0);



 

  -- retrieving customers who made purchase in previous last month relative to dates in purchase timestamp and shipped 
SELECT customer_unique_id
FROM (dbo.Customers 
INNER JOIN dbo.Orders ON dbo.Customers.customer_id  = dbo.Orders.customer_id)
WHERE dbo.Orders.order_purchase_timestamp >= DATEADD(month, DATEDIFF(month, 0, (SELECT MAX(dbo.Orders.order_purchase_timestamp) FROM dbo.Orders)) - 1, 0)
  AND dbo.Orders.order_purchase_timestamp < DATEADD(month, DATEDIFF(month, 0, (SELECT MAX(dbo.Orders.order_purchase_timestamp) FROM dbo.Orders)), 0) AND order_status = 'shipped';


  -- calculation of average order vale 
  SELECT  round(SUM(price)/COUNT(dbo.Orders.order_id),2) As order_avg_value
  FROM (dbo.Orders 
  INNER JOIN dbo.OrderItems ON dbo.Orders.order_id = dbo.OrderItems.order_id);
  
