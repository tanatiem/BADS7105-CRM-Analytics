# Customer Segmentation

The diagram below describes how this project was implemented.
![overview](./img/overview.png)

## 1) Import Dataset
The given Supermarket dataset contains 956K rows of sales transactions at sales-item level. Import the file into Google BigQuery.  
  
**Note:** the dataset received is just a part of Dunhumbly public dataset which is way more bigger. There seems to be historical data from only 2 stores from year 2006 to 2008.  

## 2) Generate Customer Single View
From `transactions` table, aggregate data to the basket and customer level into `baskets` and `customers` tables respectively. The SQL scripts are listed below.  
* [create-baskets.sql](./create-baskets.sql) (create `baskets` table)  
only baskets of members are included (`cust_code is not null`)  
* [create-customer-single-view.sql](./create-customer-single-view.sql) (create `customers` table)  
generate a lot features, but decided not to use them.

## 3) K-Means Clustering using BigQuery ML
By looking into the data, I found that the number of customers having only one transaction is one-third of all customer

## 4) Clustering Result Analysis

## 5) Interpretation


