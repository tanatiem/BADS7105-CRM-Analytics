# Customer Segmentation

The diagram below show how this project was implemented.
![overview](./img/overview.png)

## 1) Import Dataset
The given dataset of Supermarket contains 956K rows of sales items. Import the file into Google BigQuery.

## 2) Generate Customer Single View
From `transactions` table, aggregate data to the basket view and customer view into `baskets` and `customers` tables respectively. The SQL scripts are listed below.  
* [Create Baskets table](./create-baskets.sql)
* [Create Customer Single View table](./create-customer-single-view.sql)

## 3) K-Means Clustering using BigQuery ML

## 4) Clustering Result Analysis

## 5) Interpretation


