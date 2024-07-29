-- List All Suppliers with Their Contact Information
SELECT * FROM supplier;

-- Get Total Orders for a Specific Supplier
SELECT s.name AS supplier_name, COUNT(o.id) AS total_orders
FROM orders o
JOIN supplier s ON o.supplier_id = s.id
WHERE s.id = 1
GROUP BY s.name;

-- List Medicines Expiring Soon
SELECT name AS medicine_name, expiry_date FROM medicine WHERE expiry_date <= CURRENT_DATE + INTERVAL '30 days';

-- SEE ALL ORDERS
SELECT * FROM orders;

-- Retrieve order details for a specific order
SELECT o.id as order_id, m.name as medicine_name, od.price, od.quantity, o.order_date, o.status, s.name as supplier_name, od.quantity * od.price AS TOTAL
FROM order_details od
JOIN orders o ON od.order_id = o.id
JOIN supplier s ON o.supplier_id = s.id
JOIN medicine m ON od.medicine_id = m.id
WHERE o.id = 2;

-- SEE ALL ORDERS OF LAST MONTH
SELECT * 
FROM orders 
WHERE order_date >= date_trunc('month', current_date) - INTERVAL '1 month' 
  AND order_date < date_trunc('month', current_date);

SELECT * 
FROM orders 
WHERE order_date >= date_trunc('month', '2024-07-01') - INTERVAL '1 month' 
  AND order_date < date_trunc('month', '2024-07-01') + INTERVAL '1 month';


-- Update order status from 'Pending' to 'Delivered'
UPDATE orders SET status = 'Delivered', delivery_date = '2024-12-12' WHERE id = 2;

-- Check Inventory stock
SELECT * FROM inventory ORDER BY medicine_id ASC;

-- CHECK LAST UPDATE TO INVENTORY
SELECT * FROM inventory ORDER BY last_updated DESC LIMIT 1;

-- CHECK DATE OF LAST UPDATE TO INVENTORY
SELECT MAX(last_updated) AS last_updated FROM inventory;

-- Find Medicines Running Low on Stock
SELECT m.name, i.quantity FROM medicine m JOIN inventory i ON m.id = i.medicine_id WHERE i.quantity < 20;

-- Get Total Quantity and Total Value of Inventory
SELECT m.name AS medicine_name, SUM(i.quantity) AS total_quantity, SUM(i.quantity * m.price) AS total_value
FROM inventory i
JOIN medicine m ON i.medicine_id = m.id
GROUP BY m.name;

-- Count total order per person
SELECT c.name ,COUNT(co.id) AS total_orders FROM customer_orders co JOIN customers c ON co.customer_id = c.id GROUP BY c.name;

-- Count orders of customer name 'Alice Johnson'
SELECT c.name ,COUNT(co.id) AS total_orders FROM customer_orders co JOIN customers c ON co.customer_id = c.id where c.name = 'Alice Johnson'
GROUP BY c.name;

-- Get 'Alice Johnson' order details
select cod.customer_order_id, cod.medicine_id, m.name, cod.price, cod.quantity from customers c
join customer_orders co on co.customer_id = c.id join customer_order_details cod on
cod.customer_order_id = co.id join medicine m on cod.medicine_id = m.id  
where c.name = 'Alice Johnson';
 
-- List all customers who have placed orders
SELECT DISTINCT c.name, c.email, c.address
FROM customers c
JOIN customer_orders co ON c.id = co.customer_id;

-- Find the total amount spent by each customer

SELECT c.name, SUM(cod.quantity * cod.price) AS total_spent
FROM customers c
JOIN customer_orders co ON c.id = co.customer_id
JOIN customer_order_details cod ON co.id = cod.customer_order_id
GROUP BY c.name
ORDER BY total_spent DESC;

-- Find the top 5 customers by total amount spent

SELECT c.name, SUM(cod.quantity * cod.price) AS total_spent
FROM customers c
JOIN customer_orders co ON c.id = co.customer_id
JOIN customer_order_details cod ON co.id = cod.customer_order_id
GROUP BY c.name
ORDER BY total_spent DESC
LIMIT 5;

-- List all orders with their total price and customer details
SELECT co.id AS order_id, c.name AS customer_name, c.email AS customer_email, c.address AS customer_address, 
       SUM(cod.quantity * cod.price) AS total_price, co.order_date
FROM customer_orders co
JOIN customers c ON co.customer_id = c.id
JOIN customer_order_details cod ON co.id = cod.customer_order_id
GROUP BY co.id, c.name, c.email, c.address, co.order_date
ORDER BY co.id ASC;

-- Calculate the total sales for a specific month
SELECT SUM(cod.quantity * cod.price) AS total_sale
FROM customer_order_details cod
JOIN customer_orders co ON cod.customer_order_id = co.id
WHERE date_trunc('month', co.order_date) = date_trunc('month', '2024-07-01'::date);

-- Retrieve All Prescriptions for a Specific Customer:

SELECT p.id AS prescription_id, p.prescription_date, c.name AS customer_name, c.email, c.address
FROM prescriptions p
JOIN customers c ON p.customer_id = c.id
WHERE c.id = 1;

-- Retrieve All Prescription Details for a Specific Prescription:

SELECT pd.id AS prescription_detail_id, m.name AS medicine_name, pd.quantity
FROM prescription_details pd
JOIN medicine m ON pd.medicine_id = m.id
WHERE pd.prescription_id = 1;

-- List All Customers with Their Prescriptions:

SELECT c.name AS customer_name, c.email, c.address, p.id AS prescription_id, p.prescription_date
FROM customers c
JOIN prescriptions p ON c.id = p.customer_id;

-- Get Medicines Prescribed to a Specific Customer:

SELECT c.name AS customer_name, m.name AS medicine_name, pd.quantity, p.prescription_date
FROM customers c
JOIN prescriptions p ON c.id = p.customer_id
JOIN prescription_details pd ON p.id = pd.prescription_id
JOIN medicine m ON pd.medicine_id = m.id
WHERE c.id = 1;

-- Find All Prescriptions with a Specific Medicine:

SELECT p.id AS prescription_id, p.prescription_date, c.name AS customer_name, m.name AS medicine_name, pd.quantity
FROM prescriptions p
JOIN customers c ON p.customer_id = c.id
JOIN prescription_details pd ON p.id = pd.prescription_id
JOIN medicine m ON pd.medicine_id = m.id
WHERE m.id = 1;

-- Check if a Customer has a Prescription for a Specific Medicine:

SELECT p.id AS prescription_id, p.prescription_date
FROM prescriptions p
JOIN prescription_details pd ON p.id = pd.prescription_id
WHERE p.customer_id = 1
  AND pd.medicine_id = 1;

--    Retrieve Orders Related to a Prescription

SELECT co.id AS order_id, co.order_date, co.customer_id, p.prescription_date
FROM customer_orders co
JOIN prescriptions p ON co.prescription_id = p.id
WHERE p.id = 1;

-- Retrieve Prescriptions for a Customer

SELECT p.id AS prescription_id, p.prescription_date
FROM prescriptions p
WHERE p.customer_id = 1;

-- Update Prescription for an Order

UPDATE customer_orders
SET prescription_id = 2
WHERE id = 1;

