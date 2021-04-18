# Customer Segmentation

The diagram below describes how this project was implemented.
![overview](./img/overview.png)

## 1) Import Dataset
The given Supermarket dataset contains 956K rows of sales transactions at sales-item level. Import the file into Google BigQuery.  
  
**Note:** the dataset received is just a part of Dunhumbly public dataset which is way more bigger. There seems to be historical data from only 2 stores from year 2006 to 2008.  

## 2) Generate Customer Single View
From `transactions` table, aggregate data to the basket and customer level into `baskets` and `customers` tables respectively. The SQL scripts are listed below.  
* Create `baskets` table using [create-baskets.sql](./create-baskets.sql)  
only baskets of members are included (`transactions.cust_code is not null`)  
* Create `customers` table using [create-customer-single-view.sql](./create-customer-single-view.sql)  
generated a lot features, but decided not to use them.  
  
**Note:** the `age` of basket (in days) was calculated based on the last transaction date of the dataset. If we use the current date (in 2021) to calculate, the difference of all transactions would be rather smaller than using the backdate.  

## 3) K-Means Clustering using BigQuery ML
By looking into the data, I found that the number of customers having only one transaction is 2,025, one-third of all customers. The rest of 4,075 customers have at least 2 transactions.  
Some of generated features are only applicable to multiple transactions, for example, you need at least 2 transactions for time-to-event (duration betwen txn-1 to txn-2). Also, with only one transaction, many features have the same values, e.g., duration from first & last purchase, average ticket size & average montly spend.  
  

### Single-Purchase Customer Clustering
* Create KMean model using [bq-ml-kmeans-single-purchase-customers.sql](./bq-ml-kmeans-single-purchase-customers.sql)  
**Features**
* `days_since_last_purch` : duration in days from the last transaction. This represents *Recency* in RFM analysis
* `total_spend` : sum of all spend. This represents *Monetary* in RFM analysis


## 4) Clustering Result Analysis

## 5) Interpretation


