

--  створення таблиць


create table suppliers (
    id_supplier serial primary key,
    company_name varchar(255) not null,
    phone varchar(50)
);

create table warehouses (
    id_warehouse serial primary key,
    location_name varchar(255) not null,
    address varchar(255)
);

create table clients (
    id_client serial primary key,
    first_name varchar(100),
    last_name varchar(100),
    phone varchar(50) unique
);

create table products (
    id_product serial primary key,
    name varchar(255) not null,
    sku varchar(100) unique,
    category varchar(100),
    purchase_price decimal(10, 2),
    retail_price decimal(10, 2),
    id_supplier int,
    foreign key (id_supplier) references suppliers(id_supplier)
);

create table stock (
    id_warehouse int,
    id_product int,
    quantity int default 0,
    primary key (id_warehouse, id_product),
    foreign key (id_warehouse) references warehouses(id_warehouse),
    foreign key (id_product) references products(id_product)
);

create table sales (
    id_sale serial primary key,
    sale_date timestamp default current_timestamp,
    id_client int,
    total_amount decimal(10, 2),
    foreign key (id_client) references clients(id_client)
);

create table sale_items (
    id_sale int,
    id_product int,
    quantity int not null,
    unit_price decimal(10, 2),
    primary key (id_sale, id_product),
    foreign key (id_sale) references sales(id_sale),
    foreign key (id_product) references products(id_product)
);


--  додавання даних


-- додаємо постачальників
insert into suppliers (company_name, phone) values 
('глобал тех', '+380501112233'),
('світ електроніки', '+380674445566'),
('айті дистрибуція', '+380937778899'),
('лоджик корп',  '+380445550011');

-- додаємо склади
insert into warehouses (location_name, address) values 
('головний склад', 'київ, вул. польова, 10'),
('пункт видачі центр', 'київ, вул. хрещатик, 1'),
('західний філіал', 'львів, вул. городоцька, 20'),
('південний термінал', 'одеса, вул. морська, 5');

-- додаємо клієнтів
insert into clients (first_name, last_name, phone) values 
('андрій', 'шевченко', '+380991234567'),
('оксана', 'марченко', '+380959876543'),
('дмитро', 'мельник', '+380631112233'),
('юлія', 'козак', '+380684443322');

-- додаємо товари
insert into products (name, sku, category, purchase_price, retail_price, id_supplier) values 
('ігровий монітор 27', 'mon-27-gam', 'монітори', 8000.00, 11500.00, 1),
('механічна клавіатура', 'kb-mech-rgb', 'аксесуари', 1500.00, 2800.00, 2),
('ноутбук pro 16', 'lp-pro-16', 'ноутбуки', 45000.00, 58000.00, 3),
('мишка бездротова', 'ms-wire-blk', 'аксесуари', 600.00, 1200.00, 4);

-- додаємо залишки
insert into stock (id_warehouse, id_product, quantity) values 
(1, 1, 50),
(1, 3, 10),
(2, 2, 25),
(3, 4, 100);

-- додаємо продажі
insert into sales (id_client, total_amount) values 
(1, 11500.00),
(2, 2800.00),
(3, 59200.00),
(4, 1200.00);

-- додаємо деталі продажів
insert into sale_items (id_sale, id_product, quantity, unit_price) values 
(1, 1, 1, 11500.00),
(2, 2, 1, 2800.00),
(3, 3, 1, 58000.00),
(3, 4, 1, 1200.00),
(4, 4, 1, 1200.00);
