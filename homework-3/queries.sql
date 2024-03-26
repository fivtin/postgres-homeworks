-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
select
    c.company_name as customer,
    concat(e.first_name, ' ', e.last_name) as employee
from customers as c
    inner join orders as o on o.customer_id = c.customer_id
    inner join employees as e on o.employee_id = e.employee_id
    inner join shippers as s on o.ship_via = s.shipper_id
where
    c.city = 'London' and c.city = e.city
    and s.company_name = 'United Package';


-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
select
    p.product_name,
    p.units_in_stock,
    s.contact_name,
    s.phone
from products as p
left join suppliers as s on p.supplier_id = s.supplier_id
where
    p.units_in_stock < 25
    and p.discontinued != 1
    and p.category_id in (
        select c.category_id
        from categories as c
        where c.category_name in ('Condiments', 'Dairy Products')
    )
order by p.units_in_stock;


-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
select
    c.company_name
from customers as c
where c.customer_id not in (
    select distinct customer_id from orders as o
);


-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
select
    p.product_name
from products as p
where product_id in (
    select od.product_id
    from order_details as od
    where od.quantity = 10
);