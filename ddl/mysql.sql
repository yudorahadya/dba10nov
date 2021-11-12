create table categories (
    category_id integer(100) not null auto_increment,
    category_name varchar(100),
    description varchar(100),
    picture text,
    primary key (category_id)
);

create table products (
    product_id integer(100) not null auto_increment,
    product_name varchar(100),
    supplier_id integer(100),
    category_id integer(100),
    quantity_per_unit varchar(100),
    unit_price integer(100),
    units_in_stock integer(100),
    units_on_order integer(100),
    reorder_level integer(100),
    discontinued integer(100),
    primary key (product_id)
);

create table suppliers (
    supplier_id integer(100) not null auto_increment,
    company_name varchar(100),
    contact_name varchar(100),
    contact_title varchar(100),
    address varchar(100),
    city varchar(100),
    region varchar(100),
    postal_code varchar(100),
    country varchar(100),
    phone varchar(100),
    fax varchar(100),
    homepage varchar(100),
    primary key (supplier_id)
);

