# Voice of Customers
[![](https://img.shields.io/badge/-NLP-blue)](#) [![](https://img.shields.io/badge/-Topic--Modeling-blue)](#) [![](https://img.shields.io/badge/-Python-blue)](#) [![](https://img.shields.io/badge/-Google--Colab-blue)](#)   

## Dataset 📊  
Customer reviews of 3 restaurants from Wongnai - only 21 instances.  

**Notebooks:** [Voice of Customers](./hw11-voice-of-customers.ipynb)  
**Google Colab:** [![Open In Collab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/tanatiem/BADS7105-CRM-Analytics/blob/main/Homework%2011%20-%20Voice%20of%20Customers/hw11-voice-of-customers.ipynb)  

## Text Preprocessing
* Correct typos
* Remove special characters and numbers
* Combine Headline + Review content
* Sentence and Word tokenization (using `pythainlp` and `sefr_cut` packages)
* Remove stop words and some cherry-picked words

## Topic Modeling
Choose number of topics = 4  

## Result
Topics and top 12 words.  
![topic-term](./topic-term.png)  

Number of reviews for each pair of restaurant and topic.  
![restaurant-topic](./restaurant-topic.png)  

Topic Modeling using graph visualization.  
![topic-modeling-visualization](./topic-modeling-visualization.png)  
