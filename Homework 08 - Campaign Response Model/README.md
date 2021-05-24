# Campaign Response Model
[![](https://img.shields.io/badge/-Classification-blue)](#) [![](https://img.shields.io/badge/-RFM-blue)](#) [![](https://img.shields.io/badge/-Python-blue)](#) [![](https://img.shields.io/badge/-Logistic--Regression-blue)](#) [![](https://img.shields.io/badge/-XGBoost-blue)](#) [![](https://img.shields.io/badge/-Google--Colab-blue)](#) 

## Dataset 📊  
A Retail-like dataset consisting of CUSTOMER_ID, TRANS_DATE, TRANS_AMOUNT which is on customer's basket level.  

**Notebooks:** [Campaign Response Model](./hw08_campaign_response_model.ipynb)  
**Google Colab:** [![Open In Collab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/tanatiem/BADS7105-CRM-Analytics/blob/main/Homework%2008%20-%20Campaign%20Response%20Model/hw08-campaign-response-model.ipynb)  

## What I did
More feature engineering, such as
* Tenure, Length of stay
* Time to event
* Monetary, Frequency, Ticket Size, Time to event for the past 6, 12, 18, 24 months
* Velocity of spending for the short period over longer period, e.g, 12 over 24 months

## Cohort Analysis
![cohort](./cohort-analysis.png)


## Result
![result](./result.png)


## Feature Importance
![feature importance](./feature-importance.png)

## SHAP Tree Explainer
![shap](./shap.png)

## Future Improvements
* Proper model evaluation by using train, validation, and test split including cross validation.  
an expert suggests that this seems overfitting to the test-set
* SHAP Tree Explainer interpretation
* Proper Feature Selection
* Hyperparamter tuning, maybe Optuna
