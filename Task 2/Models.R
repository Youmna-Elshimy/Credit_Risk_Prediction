#load the libraries
library(dplyr)

#load the dataset
data = read.csv("creditworthiness.csv")

##############################
#####QUESTION 1
#select all entries for which the credit rating is known and convert the attributes to factor
knownData <- subset(data, data[,46] > 0)
knownData <- knownData %>% mutate(across(where(is.numeric), as.factor))

#select all entries for which the credit rating is unknown and convert the attributes to factor
unknownData <- subset(data, data[,46] == 0)
unknownData <- unknownData %>% mutate(across(where(is.numeric), as.factor))

#set the seed to make your partition reproducible
set.seed(123)

#setting the size of the training index
train_ind <- sample(seq_len(nrow(knownData)), size = floor(0.5 * nrow(knownData)))

#create the test and training sets
train <- knownData[train_ind, ]
test <- knownData[-train_ind, ]



##############################
####QUESTION 2 PART A
#load the libraries
library(rpart)
library(rpart.plot)

#create a decision tree with rpart and print the result and its summary
tree <- rpart(credit.rating ~., data = train)
rpart.plot(tree)

#predict the train data using the decision tree model and print overall accuracy
predict_train <- table(train$credit.rating, predict(tree, train, type = "class"))
sum(diag(predict_train))/sum(predict_train)



##############################
####QUESTION 2 PART B
#load the libraries
library(dplyr)

#load the median customer dataset and convert the attributes to factor
median_customer = read.csv("median_creditworthiness.csv")
median_customer <- median_customer %>% mutate(across(where(is.numeric), as.factor))

#predicting the credit rating for the median customer
table(predict(tree, median_customer, type = "class"))



##############################
####QUESTION 2 PART C
#load the libraries
library(caret)

#predict on the test data
predict_test <- predict(tree, test, type = "class")

#print the confusion matrix and statistics (including overall accuracy)
confusionMatrix(predict_test, test$credit.rating)



##############################
####QUESTION 2 PART D
#printing the tree
print(tree)



##############################
####QUESTION 2 PART E
#load the libraries
library(randomForest)

#create a random forest model and fit it to the train set
rf_1 <- randomForest(credit.rating ~ ., data = train, ntree = 20, mtry = 30)

#predict the train data and print the overall accuracy
predict_rf_1 <- table(train$credit.rating, predict(rf_1, newdata = train, type = "class"))
sum(diag(predict_rf_1))/sum(predict_rf_1)


#create a random forest model and fit it to the train set
rf_2 <- randomForest(credit.rating ~ ., data = train, ntree = 40, mtry = 40)

#predict the train data and print the overall accuracy
predict_rf_2 <- table(train$credit.rating, predict(rf_2, newdata = train, type = "class"))
sum(diag(predict_rf_2))/sum(predict_rf_2)




##############################
####QUESTION 2 PART F
#load the libraries
library(caret)

#predict the test data using the 2nd rf model
predict_rf2_test <- predict(rf_2, newdata = test, type = "class")

#print the confusion matrix and statistics (including overall accuracy)
confusionMatrix(predict_rf2_test, test$credit.rating)



##############################
####QUESTION 3 PART A
#load the libraries 
library(e1071)

#creating the svm model
svm_model <- svm(credit.rating ~ ., data = train, probability = TRUE)

#predicting the credit rating for the median customer
predict(svm_model, newdata = median_customer, decision.values = TRUE, type = "class")



##############################
####QUESTION 3 PART B
#load the libraries
library(caret)

#predict on the test data
predict_svm_test <- predict(svm_model, test, type = "class")

#print the confusion matrix and statistics (including overall accuracy)
confusionMatrix(predict_svm_test, test$credit.rating)



##############################
####QUESTION 3 PART C
#automatic tuning
#defining the value of the gamma and cost
gamma_vals <- 3^seq(-3, 3)
cost_vals <- 3^seq(-3, 3)

#auto tuning
auto_tune <- tune.svm(credit.rating ~ ., data = train, kernel = "radial", 
                      gamma = gamma_vals, cost = cost_vals)

#printing summary of the model
summary(auto_tune)

#predicting on test set using the tuned svm model and printing accuracy and confusion matrix
svm.tuned <- auto_tune$best.model
predict_tuned_svm_test <- predict(svm.tuned, test, type = "class")
confusionMatrix(predict_tuned_svm_test, test$credit.rating)




##############################
####QUESTION 4 PART A
#load the libraries 
library(e1071)

#creating the naive bayes model
nb_model <- naiveBayes(credit.rating ~ ., data = train)

#predicting the credit rating for the median customer and showing probabilities
predict(nb_model, newdata = median_customer)
predict(nb_model, newdata = median_customer, type = "raw")



##############################
####QUESTION 4 PART B
#reproducing the first 20 or so lines
naiveBayes(credit.rating ~ ., data = train, laplace = 3)



##############################
####QUESTION 4 PART C
#load the libraries
library(caret)

#predict on the test data
predict_nb_test <- predict(nb_model, test, type = "class")

#print the confusion matrix and statistics (including overall accuracy)
confusionMatrix(predict_nb_test, test$credit.rating)



##############################
####QUESTION 6 PART A
#making a subset of the known data
simple_data <- data

#changing all values that are 2 or 3 to 0
simple_data$credit.rating[simple_data$credit.rating == 2] <- 0
simple_data$credit.rating[simple_data$credit.rating == 3] <- 0

#setting the size of the training index
train_ind_2 <- sample(seq_len(nrow(simple_data)), size = floor(0.5 * nrow(simple_data)))

#create the test and training sets
train_2 <- simple_data[train_ind_2, ]
test_2 <- simple_data[-train_ind_2, ]

#creating the logistic regression model
logistic_model <- glm(credit.rating ~ ., family = binomial("logit"), data = train_2)



##############################
####QUESTION 6 PART B
#creating a summary of the logistic regression model 
summary(logistic_model)



##############################
####QUESTION 6 PART D
#load the libraries 
library(e1071)

#creating the svm model
simple_data_svm_model <- svm(credit.rating ~ ., data = train_2, kernel = "radial", 
                             gamma = 0.03703704, cost = 3)



##############################
####QUESTION 6 PART E
#load the libraries
library(ROCR)

#predicting on the test set using the logistic and svm models
predict_simple_log <- predict(logistic_model, test_2, type = "response")
predict_simple_svm <- predict(simple_data_svm_model, test_2, type = "class")

#producing prediction objects for both models where the credit rating is 1
log_pred_obj <- prediction(predict_simple_log, test_2$credit.rating == "1")
svm_pred_obj <- prediction(predict_simple_svm, test_2$credit.rating == "1")

#calculating the performance metrics (true positive rate and false positive rate) of models
perf_log <- performance(log_pred_obj, "tpr", "fpr")
perf_svm <- performance(svm_pred_obj, "tpr", "fpr")

#plotting the ROC and adding a legend
plot(perf_log, col = 2)
plot(perf_svm, add = TRUE, col = 3)
title(main = "ROC Curve")
legend("bottomright", c("Logistic Regression", "SVM"), lty = 1, col = 2:3)

#printing the auc values of the models
performance(log_pred_obj, "auc")@y.values[[1]]
performance(svm_pred_obj, "auc")@y.values[[1]]
