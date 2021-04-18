# Customer Segmentation

The diagram below describes how this project was implemented.
![overview](./img/overview.png)

## 1) Import Dataset
The given Supermarket dataset contains 956K rows of sales transactions at sales-item level. Import the file into Google BigQuery.

## 2) Generate Customer Single View
From `transactions` table, aggregate data to the basket and customer level into `baskets` and `customers` tables respectively. The SQL scripts are listed below.  
* (./create-baskets.sql) (create `baskets` table)
* (./create-customer-single-view.sql) (create `customers` table)

## 3) K-Means Clustering using BigQuery ML

## 4) Clustering Result Analysis

## 5) Interpretation


