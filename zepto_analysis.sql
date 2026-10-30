-- ============================================================
-- ZEPTO E-COMMERCE INVENTORY ANALYSIS
-- Data Exploration, Cleaning & Business Analysis
-- Tool: MySQL Workbench
-- Author: Suhas
-- ============================================================

USE zepto_db;

-- ============================================================
-- SECTION 1: DATA EXPLORATION
-- ============================================================

-- Total number of records
SELECT COUNT(*) AS total_records
FROM zepto;

-- Total number of columns
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'zepto_db'
  AND TABLE_NAME   = 'zepto';

-- Preview first 10 rows
SELECT *
FROM zepto
LIMIT 10;

-- Check for NULL values across all key columns
SELECT *
FROM zepto
WHERE name                   IS NULL
   OR category               IS NULL
   OR mrp                    IS NULL
   OR discountPercent        IS NULL
   OR discountedSellingPrice IS NULL
   OR weightInGms            IS NULL
   OR availableQuantity      IS NULL
   OR outOfStock             IS NULL
   OR quantity               IS NULL;

-- All distinct product categories
SELECT DISTINCT category
FROM zepto
ORDER BY category;

-- Products in stock vs out of stock
SELECT
    outOfStock,
    COUNT(sku_id) AS product_count
FROM zepto
GROUP BY outOfStock;

-- Products that appear with multiple SKUs
SELECT
    name,
    COUNT(sku_id) AS num_skus
FROM zepto
GROUP BY name
HAVING COUNT(sku_id) > 1
ORDER BY num_skus DESC;


-- ============================================================
-- SECTION 2: DATA CLEANING
-- ============================================================

-- Identify products with zero price (data quality issue)
SELECT *
FROM zepto
WHERE mrp = 0
   OR discountedSellingPrice = 0;

-- Remove zero-price records
DELETE FROM zepto
WHERE sku_id > 0
  AND mrp = 0;

-- Convert prices from paise to rupees (₹)
UPDATE zepto
SET
    mrp                   = mrp / 100.0,
    discountedSellingPrice = discountedSellingPrice / 100.0
WHERE sku_id > 0;

-- Verify cleaned data
SELECT * FROM zepto LIMIT 10;


-- ============================================================
-- SECTION 3: BUSINESS ANALYSIS
-- ============================================================

-- Q1. Top 10 Best-Value Products by Discount Percentage
--     Helps identify which products offer the deepest discounts
SELECT DISTINCT
    name,
    mrp,
    discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;


-- Q2. Premium Products (MRP > ₹300) That Are Out of Stock
--     Highlights high-demand, high-value items that need restocking
SELECT DISTINCT
    name,
    mrp
FROM zepto
WHERE outOfStock = TRUE
  AND mrp > 300
ORDER BY mrp DESC;


-- Q3. Estimated Revenue by Category
--     Revenue = discounted price × available quantity
SELECT
    category,
    SUM(discountedSellingPrice * availableQuantity) AS estimated_revenue
FROM zepto
GROUP BY category
ORDER BY estimated_revenue DESC;


-- Q4. Premium Products with Low Discount (MRP > ₹500, Discount < 10%)
--     Identifies products with little price relief for the customer
SELECT DISTINCT
    name,
    mrp,
    discountPercent
FROM zepto
WHERE mrp > 500
  AND discountPercent < 10
ORDER BY mrp DESC, discountPercent DESC;


-- Q5. Top 5 Categories by Average Discount Percentage
--     Useful for understanding promotional strategies per category
SELECT
    category,
    ROUND(AVG(discountPercent), 2) AS avg_discount_pct
FROM zepto
GROUP BY category
ORDER BY avg_discount_pct DESC
LIMIT 5;


-- Q6. Price per Gram for Products ≥ 100g (Best-Value Ranking)
--     Helps compare actual value across products by weight
SELECT DISTINCT
    name,
    weightInGms,
    discountedSellingPrice,
    ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms >= 100
ORDER BY price_per_gram ASC;


-- Q7. Weight-Based Product Segmentation (Low / Medium / Bulk)
--     Segments inventory by package size for logistics insights
SELECT DISTINCT
    name,
    weightInGms,
    CASE
        WHEN weightInGms < 1000 THEN 'Low'
        WHEN weightInGms < 5000 THEN 'Medium'
        ELSE 'Bulk'
    END AS weight_category
FROM zepto
ORDER BY weightInGms;


-- Q8. Total Inventory Weight per Category
--     Useful for warehouse and logistics planning
SELECT
    category,
    SUM(weightInGms * availableQuantity) AS total_inventory_weight_gms
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight_gms DESC;
