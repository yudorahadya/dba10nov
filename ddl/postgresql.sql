CREATE TABLE customer_customer_demo (
	customer_id varchar NULL,
	customer_type_id varchar NULL,
	CONSTRAINT customer_id_customer_customer_demo UNIQUE (customer_id),
	CONSTRAINT customer_customer_demo_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	CONSTRAINT customer_customer_demographic_fk FOREIGN KEY (customer_type_id) REFERENCES customer_demographics(customer_type_id)
);

CREATE TABLE customer_demographics (
	customer_type_id varchar NULL,
	customer_desc varchar NULL,
	CONSTRAINT customer_type_id UNIQUE (customer_type_id)
);


CREATE TABLE customers (
	customer_id varchar NULL,
	company_name varchar NULL,
	contact_title varchar NULL,
	address varchar NULL,
	city varchar NULL,
	region varchar NULL,
	postal_code varchar NULL,
	country varchar NULL,
	phone varchar NULL,
	fax varchar NULL,
	CONSTRAINT customer_id_customer UNIQUE (customer_id)
);

CREATE TABLE orders (
	order_id serial NOT NULL,
	customer_id varchar(100) NULL,
	employee_id int4 NULL,
	order_date timestamp NULL,
	required_date timestamp NULL,
	shipped_date timestamp NULL,
	ship_via int4 NULL,
	freight int4 NULL,
	ship_name varchar(100) NULL,
	ship_address varchar(100) NULL,
	ship_city varchar(100) NULL,
	ship_region varchar(100) NULL,
	ship_postal_code varchar(100) NULL,
	ship_country varchar(100) NULL,
	CONSTRAINT orders_pkey PRIMARY KEY (order_id),
	CONSTRAINT orders_customer_id_fk FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
	CONSTRAINT orders_fk FOREIGN KEY (ship_via) REFERENCES shippers(shipper_id)
);


CREATE TABLE order_details (
	order_id serial NOT NULL,
	product_id int4 NULL,
	unit_price int4 NULL,
	quantity int4 NULL,
	discount int4 NULL,
	CONSTRAINT order_details_pkey PRIMARY KEY (order_id),
	CONSTRAINT order_details_fk FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


CREATE TABLE shippers (
	shipper_id serial NOT NULL,
	company_name varchar(100) NULL,
	phone varchar(100) NULL,
	CONSTRAINT shippers_pkey PRIMARY KEY (shipper_id)
);

CREATE TABLE us_states (
	state_id serial NOT NULL,
	state_name varchar(100) NULL,
	state_abbr varchar(100) NULL,
	state_region varchar(100) NULL,
	CONSTRAINT us_states_pkey PRIMARY KEY (state_id)
);

INSERT INTO public.stg_categories (category_id,category_name,description,picture) VALUES 
(1,'sembako','rumah tangga',NULL)
,(2,'obat','obat','')
,(3,'elektronik','elektronik',NULL)
;INSERT INTO public.stg_employee_territories (employee_id,territory_id) VALUES 
(1,'1.0')
;INSERT INTO public.stg_employees (employee_id,last_name,first_name,title,title_of_courtesy,birth_date,hire_date,address,city,region,postal_code,country,home_phone,"extension",photo,notes,reports_to,photo_path) VALUES 
(1,'ansori','isa','teknisi airflow','Mr.','1990-01-01 00:00:00.000','2020-01-01 00:00:00.000','bosnia','bosnia','1.0','26253','ID','08123344555','0','','',0,'')
;INSERT INTO public.stg_products (product_id,product_name,supplier_id,category_id,quantity_per_unit,unit_price,units_in_stock,units_on_order,reorder_level,discontinued) VALUES 
(1,'pepsodent',1,1,'1',15000,1000,1,1,2)
,(2,'obat batuk ibu dan anak',2,2,'1',20000,1000,1,1,4)
,(3,'ac 1/2 pk',3,3,'1',5000000,1,1,1,5)
;INSERT INTO public.stg_region (region_id,region_description) VALUES 
(1,'sumatera')
;INSERT INTO public.stg_suppliers (supplier_id,company_name,contact_name,contact_title,address,city,postal_code,country,phone,fax,homepage) VALUES 
(1,'unilever','budi','sales','jakarta','jakarta','',NULL,NULL,NULL,NULL)
,(2,'dexa','rudi','sales','tangerang','tangerang',NULL,NULL,NULL,NULL,NULL)
,(3,'samsung','kim','sales','jakarta','jakarta',NULL,NULL,NULL,NULL,NULL)
;INSERT INTO public.stg_territories (territory_id,territory_description,region_id) VALUES 
('1.0','payakumbuh',1)
;
