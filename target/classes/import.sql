-- 5 Categories (Groups)
INSERT INTO categories (id, name) VALUES (1, 'Shirts & Tops');
INSERT INTO categories (id, name) VALUES (2, 'Pants & Jeans');
INSERT INTO categories (id, name) VALUES (3, 'Shoes & Footwear');
INSERT INTO categories (id, name) VALUES (4, 'Electronics & Gadgets');
INSERT INTO categories (id, name) VALUES (5, 'Home & Living');

-- 20 Products (4 per category)
-- Category 1: Shirts & Tops
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Cotton Crew Neck T-Shirt', 19.99, 25, 1);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Slim Fit Oxford Shirt', 39.99, 15, 1);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Casual Linen Button-Down', 34.50, 12, 1);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Graphic Hooded Sweatshirt', 49.99, 8, 1);

-- Category 2: Pants & Jeans
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Classic Blue Jeans', 45.00, 18, 2);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Slim Stretch Chino Pants', 38.50, 14, 2);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Athletic Cargo Joggers', 29.99, 20, 2);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Formal Dress Trousers', 55.00, 6, 2);

-- Category 3: Shoes & Footwear
INSERT INTO products (name, price, stockQty, category_id) VALUES ('White Canvas Sneakers', 35.00, 30, 3);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Leather Running Shoes', 75.00, 10, 3);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Classic Leather Loafers', 62.50, 4, 3);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Casual Slip-On Shoes', 28.00, 16, 3);

-- Category 4: Electronics & Gadgets
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Wireless Optical Mouse', 22.00, 40, 4);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Mechanical Gaming Keyboard', 89.99, 9, 4);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Noise-Canceling Headphones', 119.50, 3, 4);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('USB-C Fast Charger Hub', 15.00, 50, 4);

-- Category 5: Home & Living
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Ceramic Coffee Mug', 12.50, 22, 5);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Stainless Steel Water Bottle', 18.00, 35, 5);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('LED Desk Lamp', 29.99, 11, 5);
INSERT INTO products (name, price, stockQty, category_id) VALUES ('Minimalist Wall Clock', 24.50, 7, 5);