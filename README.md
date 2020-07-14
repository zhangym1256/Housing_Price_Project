# Housing_Price_Project

This project uses machine learning tools to predict house prices using data published by [Kaggle](https://www.kaggle.com/c/house-prices-advanced-regression-techniques/overview). 
The goal of the project is to understand what are the most important factors that determine the value of a house, therefore to assist home sellers in increasing their home values and help home buyers gauge whether or not the house is overpriced. 

Project scope encompassed exploratory data analysis, data cleaning, feature engineering, regularized linear regression and tree-based model (gradient boosting) training, hyperparameters tuning and model ensembling using Python

If you have trouble loading any files, you can follow this [link](https://nbviewer.jupyter.org/github/zhangym1256/Housing_Price_Project/tree/master/) to access the repository.

[**EDA.ipynb**](https://github.com/zhangym1256/Housing_Price_Project/blob/master/EDA.ipynb)

This notebook contains exploratory data analysis on the 81 features from the training data set. In this notebook, we examined the the missingness, distribution, and outliers of each feature, as well as the correlation to the target variable house price.
Due to the skewness of the target variable house price, a log transformation was done on the house price and all the following analyses were done using the LogSalePrice. 
We also created some custom features by combing some related features. 

For each categorical feature, we displayed the frequency count and plotted the mean LogSalePrice against each category. 

For each numeric feature, we plotted the LogSalePrice v.s. the numeric feature to check whether a linear relation occurs between the house price and the feature, and if there is any outliers. 

Using this notebook, we could select features that are correlated to the target variable before fitting any model. 


[**ETL and Machine Learning.ipynb**](https://nbviewer.jupyter.org/github/zhangym1256/Housing_Price_Project/blob/master/ETL%20and%20Machine%20Learning.ipynb)

The first part of this notebook contains ETL pipeline which extracts the data from training and testing data set, removes outliers, and imputes missing values. 

Some preprocessing was needed before fitting into any machine learning models. For linear models, we first dummified categorical features and mapped ordinal features to numeric features based on our EDA results. Then we verified that we had low/no multicollinearity issue between the selected features by checking the VIF. 

We used Lasso model for feature selections, and cross validation to locate the optimal hyperparameter. Train Test split was done on the training data set to make sure we did not overfit or underfit. Then we made a prediction on the testing dataset based on the training model. 
Similarly, we fitted our second linear model using ElasticNet, which is a hybrid of Lasso and Ridge. 

We also trained a gradient boosting model, which is a tree-based model. During the preprocessing, we used labelencoder to transform categorical and ordinal features. 
Using the feature importance scores outputed by this model, we selected the most important features and used them to refit our model. 
To improve the accuracy of our model, we used grid search to optimize the hyperparameters used in this tree model. 

Finally we ensembled 3 different models using a linear combination in an effort to reduce the variance resulting from any models. Using this ensembled model, we were placed the top 20% in the Kaggle competition. 
