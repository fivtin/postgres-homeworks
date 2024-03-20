-- SQL-команды для создания таблиц

CREATE DATABASE north;

CREATE TABLE customers (
	id char(5) PRIMARY KEY,
	company_name varchar(256) NOT NULL,
	contact_name varchar(256) NOT NULL
);

CREATE TABLE employees (
	id int PRIMARY KEY,
	first_name varchar(256) NOT NULL,
	last_name varchar(256) NOT NULL,
	title varchar(256) NOT NULL,
	birth_date date NOT NULL,
	notes text
);

CREATE TABLE orders (
    id int PRIMARY KEY,
	customer_id char(5) references customers(id) NOT NULL,
	employee_id int references employees(id) NOT NULL,
	order_date date NOT NULL,
	ship_city varchar(128) NOT NULL
);