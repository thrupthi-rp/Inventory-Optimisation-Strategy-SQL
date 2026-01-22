-- 1. Calculate how full each warehouse is
SELECT 
    w.warehouseCode, 
    w.warehouseName, 
    SUM(p.quantityInStock) AS total_inventory
FROM warehouses w
JOIN products p ON w.warehouseCode = p.warehouseCode
GROUP BY w.warehouseCode, w.warehouseName
ORDER BY total_inventory ASC;

-- Objective 2: Find products with high inventory but LOW sales
SELECT 
    p.productName, 
    p.warehouseCode, 
    p.quantityInStock, 
    SUM(od.quantityOrdered) AS total_sales
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productCode, p.productName, p.warehouseCode, p.quantityInStock
ORDER BY (p.quantityInStock - SUM(od.quantityOrdered)) DESC
LIMIT 10;

-- Objective 3: Find products that have NO sales history
SELECT 
    p.productName, 
    p.warehouseCode, 
    p.quantityInStock, 
    p.buyPrice
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;
