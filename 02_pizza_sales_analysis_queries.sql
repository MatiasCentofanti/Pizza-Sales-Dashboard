-- 1. Revenue total
SELECT ROUND(SUM(od.quantity * p.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id;

-- 2. Órdenes y pizzas vendidas
SELECT COUNT(DISTINCT order_id) AS total_orders,
       SUM(quantity)            AS total_pizzas_sold
FROM order_details;

-- 3. Ticket promedio
SELECT ROUND(SUM(od.quantity * p.price) / COUNT(DISTINCT od.order_id), 2) AS avg_order_value
FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id;

-- 4. Revenue por categoría
SELECT pt.category, ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC;

-- 5. Revenue por tamaño
SELECT p.size, ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size ORDER BY revenue DESC;

-- 6. Top 5 pizzas por revenue
SELECT TOP 5 pt.name, ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name ORDER BY revenue DESC;

-- 7. Bottom 5 pizzas por revenue
SELECT TOP 5 pt.name, ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name ORDER BY revenue ASC;

-- 8. Pizzas vendidas por día de la semana
SELECT DATENAME(WEEKDAY, o.[date]) AS dia, SUM(od.quantity) AS pizzas_vendidas
FROM order_details od JOIN orders o ON od.order_id = o.order_id
GROUP BY DATENAME(WEEKDAY, o.[date])
ORDER BY pizzas_vendidas DESC;

-- 9. Horas pico
SELECT TOP 5 DATEPART(HOUR, [time]) AS hora, COUNT(*) AS ordenes
FROM orders
GROUP BY DATEPART(HOUR, [time])
ORDER BY ordenes DESC;

-- 10. Tendencia mensual de revenue
SELECT FORMAT(o.[date], 'yyyy-MM') AS mes, ROUND(SUM(od.quantity * p.price), 2) AS revenue
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY FORMAT(o.[date], 'yyyy-MM')
ORDER BY mes;