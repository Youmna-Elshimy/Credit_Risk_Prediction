credit.full <- read.csv("creditworthiness.csv")

#select all entries for which the credit rating is known
knownData <- subset(credit.full, credit.full[,46] > 0)

#select all entries for which the credit rating is unknown
unknownData <- subset(credit.full, credit.full[,46] == 0)

#set the seed for the random number generator. By using the same seed this
#will allow us to make the results reproducible
set.seed(7)

# define the size of the training dataset
sample.size <- nrow(knownData)

#the first column contains the sample ID and the last column the class label.
#We remove the ID since it is not informative and we must remove the class label
#since the SOM must be trained unsupervised.
credit.set_full <- as.matrix(credit.full)
credit.set <- as.matrix(knownData)

credit.set2 <- as.matrix(knownData[,c("FI3O.credit.score",
                                      "credit.refused.in.past.",
                                      "years.employed",
                                      "savings.on.other.accounts",
                                      "self.employed.")])

#Lets train the SOM
library(kohonen)

# lets use a fix size for the SOM grid. For demonstration purposes we'll keep
# the grid rather small
grid.size <- 20

# create the grid
som.grid <- somgrid(xdim = grid.size, ydim = grid.size, topo = 'hexagonal', neighbourhood.fct = 'bubble', toroidal = T)

#remember how the SOM looks like without any training (in its initial condition)
#som.model_0 <- som(data.matrix(credit.set), grid = som.grid, rlen = 0, alpha = c(0.9, 0.01), radius = c(grid.size/2,1), dist.fcts = "sumofsquares", keep.data = TRUE, normalizeDataLayers = FALSE)

#summary(som.model_0)

# Generate plots after training.
#plot(som.model_0, type = 'counts', keepMargins = F)
#plot(som.model_0, type = 'mapping', pchs=20, keepMargins = F, main = '')

#train the SOM...depending on sample.size this may take a while
som.model_full <- som(data.matrix(credit.set_full), grid = som.grid, rlen = 1000, alpha = c(0.9, 0.01))

summary(som.model_full)

plot(som.model_full, type = "changes")

plot(som.model_full, type = 'counts', keepMargins = F)


som_model <- som(data.matrix(credit.set), grid = som.grid, rlen=1000, alpha=c(0.9,0.01))

summary(som_model)

plot(som_model, type = "changes")

plot(som_model, type = 'counts', keepMargins = F)


som_model2 <- som(data.matrix(credit.set2), grid = som.grid, rlen=1000, alpha=c(0.9,0.01))

summary(som_model2)

plot(som_model2, type = "changes")

plot(som_model2, type = 'counts', keepMargins = F)
