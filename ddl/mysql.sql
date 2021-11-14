-- mutualfund_product.categories definition

CREATE TABLE `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `category_name` varchar(100) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `picture` text,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- mutualfund_product.suppliers definition

CREATE TABLE `suppliers` (
  `supplier_id` int NOT NULL AUTO_INCREMENT,
  `company_name` varchar(100) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_title` varchar(100) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `region` varchar(100) DEFAULT NULL,
  `postal_code` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `phone` varchar(100) DEFAULT NULL,
  `fax` varchar(100) DEFAULT NULL,
  `homepage` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


-- mutualfund_product.products definition

CREATE TABLE `products` (
  `product_id` int NOT NULL AUTO_INCREMENT,
  `product_name` varchar(100) DEFAULT NULL,
  `supplier_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `quantity_per_unit` varchar(100) DEFAULT NULL,
  `unit_price` int DEFAULT NULL,
  `units_in_stock` int DEFAULT NULL,
  `units_on_order` int DEFAULT NULL,
  `reorder_level` int DEFAULT NULL,
  `discontinued` int DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `products_FK` (`category_id`),
  KEY `products_FK_1` (`supplier_id`),
  KEY `products_supplier_id_IDX` (`supplier_id`) USING BTREE,
  KEY `products_category_id_IDX` (`category_id`) USING BTREE
  -- CONSTRAINT `products_categories_fk` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`),
  -- CONSTRAINT `products_supplier_fk` FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


ALTER TABLE products add FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

ALTER TABLE products add FOREIGN KEY (`supplier_id`) REFERENCES `suppliers` (`supplier_id`);


ALTER TABLE categories AUTO_INCREMENT = 1;

ALTER TABLE suppliers AUTO_INCREMENT = 1;

ALTER TABLE products AUTO_INCREMENT = 1;


INSERT INTO categories (category_name,description,picture) VALUES 
('sembako','rumah tangga',NULL)
,('obat','kesehatan',NULL)
,('elektronik','elektronik',NULL)
;INSERT INTO suppliers (company_name,contact_name,contact_title,address,city,region,postal_code,country,phone,fax,homepage) VALUES 
('sinar','tanu','sales','tangerang','tangerang','tangerang','','','','',NULL)
,('soho','kevin','sales','jakarta','jakarta','jakarta','',NULL,NULL,NULL,NULL)
;
INSERT INTO mutualfund_product.products (product_name,supplier_id,category_id,quantity_per_unit,unit_price,units_in_stock,units_on_order,reorder_level,discontinued) VALUES 
('sania',1,1,'1',40000,1,1,1,1)
,('vitamin',2,2,'20',10000,1,1,1,1)
,('obat batuk',2,2,'1',15000,1,1,1,1)
;