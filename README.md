# Blink_it-Grocery-Data-Analysis
SQL-based analysis of Blinkit grocery sales data. Covers cleaning, metrics extraction, outlet-wise breakdowns, and performance insights using PostgreSQL/MySQL.

 # 🛒 Blinkit Grocery Data Analysis – SQL Project

This SQL project presents an end-to-end analysis of Blinkit grocery data. It includes data cleaning, aggregations, and insightful queries to assess performance by item type, outlet size, location, and customer ratings.

---

## 📊 Dataset Overview

The dataset contains grocery transaction records from Blinkit, including:

- **Item Fat Content**  
- **Item Type**  
- **Outlet Establishment Year**  
- **Outlet Details (Type, Location, Size)**  
- **Item Visibility & Weight**  
- **Sales (Item_Outlet_Sales)**  
- **Customer Rating**

---

## ⚙️ Tech Stack

- **SQL (PostgreSQL/MySQL compatible)**
- **Spreadsheet/CSV as input**
- SQL features used: `CASE`, `GROUP BY`, `COALESCE`, `AVG`, `SUM`, `COUNT`, `CAST`, `OVER`

---

## 📂 Files Included

| File | Description |
|------|-------------|
| `Blinkit_Grocery_Data_Analyasis (SQL PROJECT).sql` | Main SQL script with table creation, data cleaning, and analysis queries |
| `sampleblinkit.csv` | Raw dataset in CSV format |

---


```sql
CREATE TABLE blinkit_grocery_data (
    Item_Fat_Content           varchar(255),
    Item_Identifier            varchar(255),
    Item_Type                  varchar(255),
    Outlet_Establishment_Year int,
    Outlet_Identifier          varchar(255),
    Outlet_Location_Type       varchar(255),
    Outlet_Size                varchar(255),
    Outlet_Type                varchar(255),
    Item_Visibility            float,
    Item_Weight                float,
    Item_Outlet_Sales          float,
    Rating                     float
);
