library(RSNNS)
#library(caret)

#Load dataset
fullDataSet <- read.csv("creditworthiness.csv")

#select all entries for which the credit rating is known
knownData <- subset(fullDataSet, fullDataSet[,46] > 0)

#select all entries for which the credit rating is unknown
unknownData <- subset(fullDataSet, fullDataSet[,46] == 0)

#set.seed(100)
#rPartMod <- train(credit.rating ~ ., data=knownData, method="rpart")
#rpartImp <- varImp(rPartMod)
#print(rpartImp)

#separate value from targets
trainValues <- knownData[,c("FI3O.credit.score",
                            "functionary",
                            "credit.refused.in.past.",
                            "re.balanced..paid.back..a.recently.overdrawn.current.acount",
                            "avrg..account.balance.12.months.ago",
                            "max..account.balance.6.months.ago",
                            "gender")]
trainTargets <- decodeClassLabels(knownData[,46])
unknownsValues <- unknownData[,1:45]

#split dataset into traing and test set
trainset <- splitForTrainingAndTest(trainValues, trainTargets, ratio=0.6)
trainset <- normTrainingAndTestSet(trainset)

model <- mlp(trainset$inputsTrain, trainset$targetsTrain, size=5, 
             learnFuncParams=c(0.001), 
             maxit=600, 
             inputsTest=trainset$inputsTest, 
             targetsTest=trainset$targetsTest)

print(model)

predictTestSet <- predict(model,trainset$inputsTest)

#creating confusion matrices and checking the accuracy of the predictions
confusionMatrix(trainset$targetsTrain,fitted.values(model))
sum_total_train <- sum(confusionMatrix(trainset$targetsTrain,fitted.values(model)))
sum_diag_train <- sum(diag(confusionMatrix(trainset$targetsTrain,fitted.values(model))))
sum_diag_train*100/sum_total_train

confusionMatrix(trainset$targetsTest,predictTestSet)
sum_total_test <- sum(confusionMatrix(trainset$targetsTest,predictTestSet))
sum_diag_test <- sum(diag(confusionMatrix(trainset$targetsTest,predictTestSet)))
sum_diag_test*100/sum_total_test

#plotting errors in the mop (refer to the lecture week 5)
#reveals the problem with the mop
plotIterativeError(model)
plotRegressionError(predictTestSet[,2], trainset$targetsTest[,2])
plotROC(fitted.values(model)[,2], trainset$targetsTrain[,2])
plotROC(predictTestSet[,2], trainset$targetsTest[,2])
