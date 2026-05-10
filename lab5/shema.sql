-- видаляю всі таблиці для нормалізації
DROP TABLE IF EXISTS sale_items CASCADE;
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS stock CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS warehouses CASCADE;
DROP TABLE IF EXISTS clients CASCADE;
DROP TABLE IF EXISTS suppliers CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

-- =============================================
-- 1. СТВОРЕННЯ ТАБЛИЦЬ ОНОВЛЕНО
-- =============================================

--  Постачальники
CREATE TABLE suppliers (
    id_supplier SERIAL PRIMARY KEY,
    company_name VARCHAR(100) NOT NULL,
    phone VARCHAR(50)
);

--  Категорії (Нормалізація для 3НФ)
CREATE TABLE categories (
    id_category SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

--  Склади
CREATE TABLE warehouses (
    id_warehouse SERIAL PRIMARY KEY,
    location_name VARCHAR(200) NOT NULL,
    address VARCHAR(200)
);

--  Клієнти
CREATE TABLE clients (
    id_client SERIAL PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    phone VARCHAR(50) UNIQUE
);

--  Товари
CREATE TABLE products (
    id_product SERIAL PRIMARY KEY,
    product_name VARCHAR(200) NOT NULL,
    sku VARCHAR(100) UNIQUE,
    id_category INT REFERENCES categories(id_category),
    purchase_price DECIMAL(10, 2),
    retail_price DECIMAL(10, 2),
    id_supplier INT REFERENCES suppliers(id_supplier)
);

--  Залишки на складах (2НФ - композитний ключ)
CREATE TABLE stock (
    id_warehouse INT REFERENCES warehouses(id_warehouse),
    id_product INT REFERENCES products(id_product),
    quantity INT DEFAULT 0,
    PRIMARY KEY (id_warehouse, id_product)
);

--  Продажі
CREATE TABLE sales (
    id_sale SERIAL PRIMARY KEY,
    sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_client INT REFERENCES clients(id_client)
);

--  Деталі продажу
CREATE TABLE sale_items (
    id_sale INT REFERENCES sales(id_sale),
    id_product INT REFERENCES products(id_product),
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2),
    PRIMARY KEY (id_sale, id_product)
);


-- =============================================
-- 2. НАПОВНЕННЯ ДАНИМИ
-- =============================================

-- Постачальники
INSERT INTO suppliers (company_name, phone) VALUES 
('ТОВ Електро-Світ', '+380441112233'),
('Global Trade IT', '+380674445566');

-- Категорії
INSERT INTO categories (category_name) VALUES 
('Ноутбуки'), 
('Периферія'), 
('Аксесуари');

-- Склади
INSERT INTO warehouses (location_name, address) VALUES 
('Центральний склад', 'м. Київ, вул. Велика, 10'),
('Склад Захід', 'м. Львів, вул. Промислова, 5');

-- Клієнти
INSERT INTO clients (first_name, last_name, phone) VALUES 
('Олександр', 'Пилов', '+380509998877'),
('Марія', 'Кохан', '+380631234567'),
('Іван', 'Кавун', '+380970001122');

-- Товари
INSERT INTO products (product_name, sku, id_category, purchase_price, retail_price, id_supplier) VALUES 
('MacBook Air M2', 'MBA-M2-2024', 1, 35000.00, 42000.00, 2),
('Logitech MX Master 3', 'LOGI-MX3', 2, 2500.00, 3800.00, 1),
('USB-C Hub 7-in-1', 'HUB-71', 3, 800.00, 1500.00, 1);

-- Залишки
INSERT INTO stock (id_warehouse, id_product, quantity) VALUES 
(1, 1, 15), -- 15 макбуків на центр. складі
(1, 2, 50), -- 50 мишок на центр. складі
(2, 3, 100); -- 100 хабів у Львові

-- Продажі
INSERT INTO sales (id_client) VALUES (1), (2);

-- Елементи продажу
INSERT INTO sale_items (id_sale, id_product, quantity, unit_price) VALUES 
(1, 1, 1, 42000.00), -- Клієнт 1 купив 1 макбук
(1, 2, 1, 3800.00),  -- Клієнт 1 купив 1 мишку
(2, 3, 2, 1500.00);  -- Клієнт 2 купив 2 хаби








