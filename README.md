# **Credit Risk Prediction**

Banks are often posed with a problem to whether or nor a client is credit worthy. Banks commonly employ data mining techniques to classify a customer into risk categories such as category A (highest rating) or category C (lowest rating).
<br />
A bank collects data from past credit assessments. The file "creditworthiness.csv" contains 2500 records. 1962 of these records have been assessed for credit worthyness. Each assessment lists 46 attributes of a customer. The last attribute (the 47-th attribute) is the result of the assessment. The columns in the CSV file are coded by numeric values. The meaning of these values is defined in the file "definitions.txt". For example, a value 3 in the 47-th column means that the customer credit worthiness is rated "C". Any value of attributes not listed in definitions.txt is "as is". This poses a "prediction" problem. A machine is to learn from the outcomes of past assessments and, once the machine has been trained, to assess any customer who has not yet been assessed. For example, the value 0 in column 47 indicates that this customer has not yet been assessed.

## **Task 1:**

#### **Question 1:**
Analyse the general properties of the dataset and obtain an insight into the difficulty of the prediction task. Create a statistical analysis of the attributes and their values, then list 5 of the most interesting (most valuable) attributes. Explain the reasons that make these attributes interesting.
<br />
Use the Self-Organizing Map method to obtain further insights of value into the properties of the dataset and to obtain an insight into the difficulty of the supervised learning problem (i.e. from the results that you obtained from the SOM, can it be expected that a prediction model will be able to achieve a 100% prediction accuracy?). Explain how these insights affect your choice and design of the supervised classification method. (i.e. from the results that you obtained, can it be expected that a prediction model will be able to achieve a 100% prediction accuracy?).

#### **Question 2:**
Deploy a suitable prediction model based on MLP to predict the credit worthiness of customers which have not yet been assessed. Your task is to:
1) Describe a valid strategy that maximises the accuracy of predicting the credit rating. Explain why your strategy can be expected to maximize the prediction capabilities.
2) Use your strategy to train MLP(s) then report your results. Give an interpretation of your results. What is the best classification accuracy (expressed in % of correctly classified data) that you can obtain for data that were not used during training (i.e. the test set)?
3) You will find that 100% accuracy cannot be obtained on the test data. Explain reasons to why a 100% accuracy could not be obtained on this test dataset. What would be needed to get the prediction accuracy closer to 100%?

## **Task 2:**
1) Write the code to split the dataset into 50% training set and 50% test set and only include the data with known ratings.
2) Using default settings, fit a decision tree to the training set predict the credit ratings of customers using all of the other variables in the dataset.
   - Report the resulting tree.
   - Based on this output, predict the credit rating of a hypothetical “median” customer, i.e., one with the attributes listed in "Table 1.png", showing the steps involved.
   - Produce the confusion matrix for predicting the credit rating from this tree on the test set, and also report the overall accuracy rate.
   - What is the numerical value of the gain in entropy corresponding to the first split at the top of the tree? (Use logarithms to base 2, and show the details of the calculation rather than just providing a final answer.)
   - Fit a random forest model to the training set to try to improve prediction. Report the R output.
   - Produce the confusion matrix for predicting the credit rating from the random forest on the test set, report the overall accuracy rate, and compare the prediction performance of the random forest with the standard tree methods.
3) Using default settings for svm() from the e1071 package, fit a support vector machine to predict the credit ratings of customers using all of the other variables in the dataset.
   - Predict the credit rating of a hypothetical “median” customer, i.e., one with the attributes listed in "Table 1.png". Report decision values as well, and discuss it.
   - Produce the confusion matrix for predicting the credit rating from this SVM on the test set, and also report the overall accuracy rate.
   - Automatically or manually tune the SVM to improve prediction over that found in 3b. Report the resulting SVM settings and the resulting confusion matrix for predicting the test set. Discuss your results.
4) Fit the Naive Bayes model to predict the credit ratings of customers using all of the other variables in the dataset.
   - Predict the credit rating of a hypothetical “median” customer, i.e., one with the attributes listed in "Table 1.png". Report predicted probabilities as well.
   - Reproduce the first 20 or so lines of the R output for the Naive Bayes fit, and use them to explain the steps involved in making this prediction.
   - Produce the confusion matrix for predicting the credit rating using Naive Bayes on the test set, and also report the overall accuracy rate.
5) Based on the confusion matrices reported in the preceding parts, which of the classifiers look to be the best? Which look to be the worst? Are there any categories that all classifiers seem to have trouble with?
6) Consider a simpler problem of predicting whether a customer gets a credit rating of A or not.
   - Fit a logistic regression model to predict whether a customer gets a credit rating of A using all of the other variables in the dataset, with no interactions.
   - Report the summary table of the logistic regression model fit.
   - Which predictors of credit rating appear to be significant at 5% significance level? How do you determine the predictors are significant at 5% significance level.
   - Fit an SVM model of your choice to the training set.
   - Produce an ROC chart comparing the logistic regression and the SVM results of predicting the test set. Comment on any differences in their performance.
