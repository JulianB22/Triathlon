# training a model on the data
set.seed(12345)
m.rpart <- rpart(`Bike` ~ ., data = Bike.tr)

# information about the tree
m.rpart
summary(m.rpart)

# decision tree diagram
rpart.plot(m.rpart, digits = 3)
rpart.plot(m.rpart, digits = 3, fallen.leaves = TRUE, type = 3, extra = 101)
fancyRpartPlot(m.rpart)

# evaluate model performance

# predictions for the testing dataset
p1.rpart <- predict(m.rpart, Bike.te)

# predicted values vs. actual values
summary(p1.rpart)
summary(Bike.te$Bike)

boxplot(Bike.te$Bike, p1.rpart, names = c("Actual", "Predicted"), main = "Bike")
plot(Bike.te$Bike, p1.rpart, main = "Actual vs Predicted", xlab = "Actual", ylab = "Predicted")

# compare the correlation between actual and predicted
cor.test(Bike.te$Bike, p1.rpart, method = "spearman", exact = FALSE)

# RMSE between actual and predicted
RMSE(Bike.te$Bike, p1.rpart)
# RMSE between actual and mean of actual
RMSE(mean(Bike.tr$Bike), Bike.te$Bike)

# prune regression tree
m.rpart_prune <- prune(m.rpart, cp = 0.05)
m.rpart_prune
summary(m.rpart_prune)
fancyRpartPlot(m.rpart_prune)

# generate predictions for the testing dataset
p2.rpart <- predict(m.rpart_prune, Bike.te)
boxplot(Bike.te$Bike, p2.rpart, names = c("Actual", "Predicted"), main = "Bike")
plot(Bike.te$Bike, p2.rpart, main = "Actual vs Predicted", xlab = "Actual", ylab = "Predicted")

#Errors values
cor.test(Bike.te$Bike, p2.rpart, method = "spearman", exact = FALSE)
MAE(Bike.te$Bike, p2.rpart)
RMSE(Bike.te$Bike, p2.rpart)
