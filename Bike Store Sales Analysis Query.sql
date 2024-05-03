/* The following query displays order_id, customers, city, state, order_date, 
total_units, revenue, product_name, category_name, brand_name, store_name, sales_rep.

As the data is scattered around different table, Joins are used to connect it

Author: Rutuj Jagtap --------------------------------------------------------------*/

USE BikeStores;

SELECT orders.order_id, 
	CONCAT(customers.first_name,' ',customers.last_name) as customers, 
	customers.city, 
	customers.state, 
	orders.order_date,
	SUM(items.quantity) as total_units,
	SUM(items.quantity*items.list_price) as revenue,
	products.product_name,
	category.category_name,
	brands.brand_name,
	store.store_name,
	CONCAT(staff.first_name,' ',staff.last_name) as sales_rep

FROM sales.orders as orders
JOIN sales.customers as customers
ON orders.customer_id = customers.customer_id
JOIN sales.order_items as items
ON orders.order_id = items.order_id
JOIN production.products as products
ON products.product_id = items.product_id
JOIN production.categories as category
ON products.category_id = category.category_id
JOIN production.brands as brands
ON products.brand_id = brands.brand_id
JOIN sales.stores as store
ON store.store_id = orders.store_id
JOIN sales.staffs as staff
ON staff.staff_id = orders.staff_id

GROUP BY orders.order_id, 
	CONCAT(customers.first_name,' ',customers.last_name), 
	customers.city, 
	customers.state, 
	orders.order_date,
	products.product_name,
	category.category_name,
	brand_name,
	store.store_name,
	CONCAT(staff.first_name,' ',staff.last_name)

ORDER BY order_id ASC;
