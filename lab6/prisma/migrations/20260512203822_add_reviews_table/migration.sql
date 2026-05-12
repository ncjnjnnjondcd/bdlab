-- CreateTable
CREATE TABLE "categories" (
    "id_category" SERIAL NOT NULL,
    "category_name" VARCHAR(100) NOT NULL,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id_category")
);

-- CreateTable
CREATE TABLE "clients" (
    "id_client" SERIAL NOT NULL,
    "first_name" VARCHAR(100),
    "last_name" VARCHAR(100),
    "phone" VARCHAR(50),

    CONSTRAINT "clients_pkey" PRIMARY KEY ("id_client")
);

-- CreateTable
CREATE TABLE "products" (
    "id_product" SERIAL NOT NULL,
    "product_name" VARCHAR(200) NOT NULL,
    "sku" VARCHAR(100),
    "id_category" INTEGER,
    "purchase_price" DECIMAL(10,2),
    "retail_price" DECIMAL(10,2),
    "id_supplier" INTEGER,

    CONSTRAINT "products_pkey" PRIMARY KEY ("id_product")
);

-- CreateTable
CREATE TABLE "sale_items" (
    "id_sale" INTEGER NOT NULL,
    "id_product" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,
    "unit_price" DECIMAL(10,2),

    CONSTRAINT "sale_items_pkey" PRIMARY KEY ("id_sale","id_product")
);

-- CreateTable
CREATE TABLE "sales" (
    "id_sale" SERIAL NOT NULL,
    "sale_date" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "id_client" INTEGER,

    CONSTRAINT "sales_pkey" PRIMARY KEY ("id_sale")
);

-- CreateTable
CREATE TABLE "stock" (
    "id_warehouse" INTEGER NOT NULL,
    "id_product" INTEGER NOT NULL,
    "quantity" INTEGER DEFAULT 0,

    CONSTRAINT "stock_pkey" PRIMARY KEY ("id_warehouse","id_product")
);

-- CreateTable
CREATE TABLE "suppliers" (
    "id_supplier" SERIAL NOT NULL,
    "company_name" VARCHAR(255) NOT NULL,
    "phone" VARCHAR(50),

    CONSTRAINT "suppliers_pkey" PRIMARY KEY ("id_supplier")
);

-- CreateTable
CREATE TABLE "warehouses" (
    "id_warehouse" SERIAL NOT NULL,
    "location_name" VARCHAR(255) NOT NULL,
    "address" VARCHAR(255),

    CONSTRAINT "warehouses_pkey" PRIMARY KEY ("id_warehouse")
);

-- CreateTable
CREATE TABLE "reviews" (
    "id" SERIAL NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "reviews_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "categories_category_name_key" ON "categories"("category_name");

-- CreateIndex
CREATE UNIQUE INDEX "clients_phone_key" ON "clients"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "products_sku_key" ON "products"("sku");

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_id_category_fkey" FOREIGN KEY ("id_category") REFERENCES "categories"("id_category") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "products" ADD CONSTRAINT "products_id_supplier_fkey" FOREIGN KEY ("id_supplier") REFERENCES "suppliers"("id_supplier") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sale_items" ADD CONSTRAINT "sale_items_id_product_fkey" FOREIGN KEY ("id_product") REFERENCES "products"("id_product") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sale_items" ADD CONSTRAINT "sale_items_id_sale_fkey" FOREIGN KEY ("id_sale") REFERENCES "sales"("id_sale") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "sales" ADD CONSTRAINT "sales_id_client_fkey" FOREIGN KEY ("id_client") REFERENCES "clients"("id_client") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stock" ADD CONSTRAINT "stock_id_product_fkey" FOREIGN KEY ("id_product") REFERENCES "products"("id_product") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "stock" ADD CONSTRAINT "stock_id_warehouse_fkey" FOREIGN KEY ("id_warehouse") REFERENCES "warehouses"("id_warehouse") ON DELETE NO ACTION ON UPDATE NO ACTION;
