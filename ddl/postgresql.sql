create table customer_customer_demo (
    customer_id varchar,
    customer_type_id varchar
);

alter table customer_customer_demo add constraint customer_id_customer_customer_demo unique (customer_id);

create table customer_demographics (
    customer_type_id varchar,
    customer_desc varchar
);

alter table customer_demographics add constraint customer_type_id unique (customer_type_id);


create table customers (
    customer_id varchar,
    company_name varchar,
    contact_title varchar,
    address varchar,
    city varchar,
    region varchar,
    postal_code varchar,
    country varchar,
    phone varchar,
    fax varchar
);

alter table customers add constraint customer_id_customer unique (customer_id);



create sequence orders_id_seq;

create table orders (
    order_id integer not null default nextval('orders_id_seq') primary key,
    customer_id varchar(100),
    employee_id integer,
    order_date timestamp without time zone,
    required_date timestamp without time zone,
    shipped_date timestamp without time zone,
    ship_via integer,
    freight integer,
    ship_name varchar(100),
    ship_address varchar(100),
    ship_city varchar(100),
    ship_region varchar(100),
    ship_postal_code varchar(100),
    ship_country varchar(100)
);

create sequence order_details_id_seq;

create table order_details (
    order_id integer not null default nextval('order_details_id_seq') primary key,
    product_id integer,
    unit_price integer,
    quantity integer,
    discount integer
);


create sequence shippers_id_seq;

create table shippers (
    shipper_id integer not null default nextval('shippers_id_seq') primary key,
    company_name varchar(100),
    phone varchar(100)
);

create sequence us_state_id_seq;

create table us_states (
    state_id integer not null default nextval('us_state_id_seq') primary key,
    state_name varchar(100),
    state_abbr varchar(100),
    state_region varchar(100)
);


