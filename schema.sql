-- ============================================================
-- ZEPTO E-COMMERCE INVENTORY ANALYSIS
-- Database Schema & Setup
-- Tool: MySQL Workbench
-- Author: Suhas
-- ============================================================

-- Step 1: Create the database
CREATE DATABASE IF NOT EXISTS zepto_db;
USE zepto_db;

-- Step 2: After importing the CSV, add a primary key
ALTER TABLE zepto
ADD COLUMN sku_id INT AUTO_INCREMENT PRIMARY KEY FIRST;

-- Step 3: Fix column name encoding issue from CSV import
ALTER TABLE zepto
RENAME COLUMN `ï»¿Category` TO Category;

-- Step 4: Correct data types for all columns
ALTER TABLE zepto
MODIFY Category              VARCHAR(255),
MODIFY name                  VARCHAR(255),
MODIFY mrp                   DECIMAL(8,2),
MODIFY discountPercent       DECIMAL(5,2),
MODIFY discountedSellingPrice DECIMAL(8,2),
MODIFY availableQuantity     INT,
MODIFY weightInGms           INT,
MODIFY quantity              INT,
MODIFY outOfStock            VARCHAR(5);

-- Step 5: Normalize the outOfStock column (TRUE/FALSE → 1/0)
UPDATE zepto
SET outOfStock = CASE
    WHEN UPPER(outOfStock) = 'TRUE'  THEN '1'
    WHEN UPPER(outOfStock) = 'FALSE' THEN '0'
    ELSE outOfStock
END
WHERE sku_id > 0;

-- Verify schema
DESCRIBE zepto;
SHOW TABLES;
