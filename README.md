# 🛒 Zepto Inventory SQL Analysis

A complete end-to-end SQL data analysis project on Zepto's e-commerce product inventory dataset. This project covers database setup, data cleaning, exploratory data analysis (EDA), and business-oriented analytical queries — all written in **MySQL Workbench**.

---

## 📌 Project Overview

Zepto is a fast-growing quick-commerce platform in India. This project analyses their product catalog to extract meaningful business insights around pricing, discounting, inventory management, and category-level performance.

| Detail | Info |
|---|---|
| **Database** | MySQL |
| **Tool** | MySQL Workbench |
| **Dataset** | Zepto Product Inventory (`zepto.csv`) |
| **Total Records** | ~3,700+ product SKUs |
| **Skills Used** | DDL, DML, Aggregations, Window Functions, CASE logic, Subqueries |

---

## 📂 Repository Structure

```
zepto-sql-analysis/
│
├── schema.sql           # Database creation, table setup & data type corrections
├── zepto_analysis.sql   # Data exploration, cleaning & all business queries
├── zepto.csv            # Raw dataset (source data)
└── README.md            # Project documentation
```

---

## 🗂️ Dataset Description

The `zepto.csv` file contains product-level inventory data for Zepto's online store.

| Column | Description |
|---|---|
| `sku_id` | Auto-generated unique product identifier (added) |
| `Category` | Product category (e.g., Dairy, Snacks, Beverages) |
| `name` | Product name |
| `mrp` | Maximum Retail Price (₹) |
| `discountPercent` | Discount offered (%) |
| `discountedSellingPrice` | Final price after discount (₹) |
| `availableQuantity` | Units currently in stock |
| `weightInGms` | Product weight in grams |
| `outOfStock` | Stock availability flag (0 = In Stock, 1 = Out of Stock) |
| `quantity` | Package quantity |

---

## 🔧 Setup Instructions

### 1. Import Dataset
- Open **MySQL Workbench**
- Create a new schema and import `zepto.csv` using the **Table Data Import Wizard**

### 2. Run Schema Setup
Execute `schema.sql` to:
- Add a primary key (`sku_id`)
- Fix column name encoding issues from the CSV import
- Set correct data types for all columns
- Normalize the `outOfStock` column to boolean integers

### 3. Run Analysis
Execute `zepto_analysis.sql` to run all exploration, cleaning, and business analysis queries.

---

## 🔍 Analysis Sections

### 📊 Section 1 — Data Exploration

- Total record and column counts
- NULL value detection across all columns
- Distinct product categories
- In-stock vs out-of-stock distribution
- Products with multiple SKU variants

### 🧹 Section 2 — Data Cleaning

- Identified and removed zero-price records (data quality issue)
- Converted prices from **paise → ₹** (rupees) for accurate analysis

### 💡 Section 3 — Business Analysis

| # | Question | Technique |
|---|---|---|
| Q1 | Top 10 best-value products by discount % | `ORDER BY`, `DISTINCT` |
| Q2 | High-MRP (>₹300) out-of-stock products | `WHERE`, `BOOLEAN` filter |
| Q3 | Estimated revenue per category | `SUM`, `GROUP BY` |
| Q4 | Premium products (>₹500) with low discount (<10%) | Compound `WHERE` |
| Q5 | Top 5 categories by average discount | `AVG`, `ROUND`, `LIMIT` |
| Q6 | Price-per-gram ranking for products ≥100g | Derived column, `ORDER BY` |
| Q7 | Weight-based product segmentation (Low/Medium/Bulk) | `CASE WHEN` |
| Q8 | Total inventory weight per category | `SUM`, aggregation |

---

## 💡 Key Business Insights

- 📦 **Dairy & Staples** dominate the inventory by total weight, pointing to high-volume storage requirements.
- 💸 Several **premium products (MRP > ₹300)** are out of stock, representing lost revenue opportunities.
- 🏷️ Certain categories consistently offer **above-average discounts**, suggesting ongoing promotional strategy.
- 📉 Products with **MRP > ₹500 but discount < 10%** are potential candidates for promotional campaigns to boost conversions.
- ⚖️ Price-per-gram analysis reveals significant value variation across similar product types — useful for recommendation engines.

---

## 🛠️ Skills Demonstrated

- **DDL** – `CREATE`, `ALTER`, `RENAME COLUMN`, `MODIFY`
- **DML** – `INSERT`, `UPDATE`, `DELETE`
- **DQL** – `SELECT`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, `LIMIT`
- **Functions** – `COUNT`, `SUM`, `AVG`, `ROUND`, `DISTINCT`, `UPPER`
- **Logic** – `CASE WHEN`, compound conditions
- **Schema Design** – Data type correction, normalization
- **Data Cleaning** – Handling encoding bugs, unit conversion, removing dirty data

---

## 👤 Author

**Suhas**  
Aspiring Data Analyst | MySQL • Python • Excel  
📧 Connect on [LinkedIn](https://www.linkedin.com)  
🐙 [GitHub Profile](https://github.com/suhas12-debug)

---

## 📄 License

This project is open-source and available under the [MIT License](LICENSE).
