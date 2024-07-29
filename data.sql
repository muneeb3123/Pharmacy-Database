-- Insert into supplier table
INSERT INTO supplier (name, address, email) VALUES
('HealthCare Supplier', '123 Health St.', 'contact@healthcare.com'),
('MediSupplies', '456 Med St.', 'support@medisupplies.com');

-- Insert into medicine table
INSERT INTO medicine (name, type, dose_unit, dose_amount, price, expiry_date, supplier_id) VALUES
('Paracetamol', 'Tablet', 'mg', 500, 5.50, '2025-12-31', 1),
('Ibuprofen', 'Tablet', 'mg', 400, 8.75, '2024-11-30', 1),
('Amoxicillin', 'Capsule', 'mg', 250, 12.00, '2023-10-15', 2),
('Aspirin', 'Tablet', 'mg', 300, 7.25, '2025-05-20', 2);

-- Insert into orders table
INSERT INTO orders (order_date, status, delivery_date, supplier_id) VALUES
('2024-07-20', 'Delivered', '2024-07-22', 1),
('2024-07-21', 'Pending', NULL, 2);

-- Insert into order_item table
INSERT INTO order_details (order_id, medicine_id, quantity, price) VALUES
(1, 1, 50, 5.50),
(1, 2, 100, 8.75),
(2, 3, 75, 12.00),
(2, 4, 60, 7.25);

-- Insert inventory records based on order details where delivery_date is not NULL
INSERT INTO inventory (medicine_id, quantity, last_updated)
SELECT
    od.medicine_id,
    SUM(od.quantity) AS quantity,
    o.delivery_date
FROM
    order_details od
JOIN
    orders o ON od.order_id = o.id
WHERE
    o.delivery_date IS NOT NULL
GROUP BY
    od.medicine_id, o.delivery_date;

-- Insert data into customers table
INSERT INTO customers (name, email, address) VALUES
('Alice Johnson', 'alice.johnson@example.com', '123 Maple Street'),
('Bob Smith', 'bob.smith@example.com', '456 Oak Avenue'),
('Carol Williams', 'carol.williams@example.com', '789 Pine Road');

-- Insert into prescriptions table
INSERT INTO prescriptions (customer_id, prescription_date) VALUES
(1, '2024-07-29'),
(2, '2024-07-30');

-- Insert into prescription_details table
INSERT INTO prescription_details (prescription_id, medicine_id, quantity) VALUES
(1, 1, 10),  -- Prescription 1 includes 10 units of medicine 1 (Paracetamol)
(1, 2, 5),   -- Prescription 1 includes 5 units of medicine 2 (Ibuprofen)
(2, 3, 7),   -- Prescription 2 includes 7 units of medicine 3 (Amoxicillin)
(2, 4, 3);   -- Prescription 2 includes 3 units of medicine 4 (Aspirin)

-- Insert data into customer_orders table
INSERT INTO customer_orders (order_date, customer_id, prescription_id) VALUES
('2024-07-20', 1, 1), -- Alice Johnson's order
('2024-07-21', 2, 1), -- Bob Smith's order
('2024-07-22', 3), 2; -- Carol Williams's order

-- Insert Data into customer_order_details Table
INSERT INTO customer_order_details (quantity, price, medicine_id, customer_order_id) VALUES
(2, 5.50, 1, 1), -- 2 units of Paracetamol for order 1
(1, 8.75, 2, 1), -- 1 unit of Ibuprofen for order 1
(3, 12.00, 3, 2), -- 3 units of Amoxicillin for order 2
(4, 7.25, 4, 3); -- 4 units of Aspirin for order 3

-- Insert Data into employees Table
INSERT INTO employees (name, email, address, salary, role) VALUES
('Alice Brown', 'alice.brown@example.com', '321 Maple Street, Springfield', 50000.00, 'Admin'),
('Bob Green', 'bob.green@example.com', '654 Birch Lane, Springfield', 55000.00, 'Pharmacist'),
('Charlie White', 'charlie.white@example.com', '987 Cedar Street, Springfield', 60000.00, 'Cashier');




