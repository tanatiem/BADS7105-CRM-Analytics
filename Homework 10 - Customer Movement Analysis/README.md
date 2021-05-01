# Customer Movement Analysis
For each reporting month, customers are grouped into 4 categories defined by the defition below  

| Status | Current | Previous | Before |
| --- | --- | --- | --- |
| Repeat | ✅ | ✅ | |
| Reactivated | ✅ | ❌ | ✅ |
| New | ✅ | ❌ | ❌ |
| Churn | ❌ | ✅ | |
  
**Current:** made purchases this month (M)  
**Previous:** made purchases last month (M-1)  
**Before:** made purchase before last month (< M-1)  

## Dataset 📊  
Supermarket, the same data as used in Customer Segmentation homework.

## Data Preparation
Since the data was already imported from the previous work, using the SQL script to prepare the report.  
**SQL:**[customer-movement-prep.sql](./customer-movement-prep.sql)  

## Result
The visualization can be made right after executing the SQL using *Google Data Studio*.
![customer-movement](./customer-movement.png)