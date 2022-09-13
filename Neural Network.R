# run neural network algorithm
n <- names(Bike.tr)
f <- as.formula(paste("Bike ~", paste(n[!n %in% "Bike"], collapse = " + ")))
f

# initial model
nn0 <- neuralnet(f, data = Bike.tr)
plot(nn0)

# obtain model results
Bike.res0 <- compute(nn0, Bike.te[-2])  # independent variables only
Bike.pred0 <- Bike.res0$net.result

# relationship between predicted and actual values
plot(Bike.te$Bike, Bike.pred0, main = "Olympic Distance (Male)", xlab = "Actual", ylab = "Predicted")
cor(Bike.te$Bike, Bike.pred0)

# errors
error <- Bike.te$Bike - Bike.pred0
rmse(error)
mae(error)
# R-squared
Bike.lm0 <- lm(Bike.te$Bike ~ Bike.pred0)
abline(Bike.lm0, col="red")
summary(Bike.lm0)

#increase hidden layers - may take a long time
nn2 <- neuralnet(f, data = Bike.tr, hidden=c(3,2))
# visualize the network topology
plot(nn2)

# model results
Bike.res2 <- compute(nn2, Bike.te[-2])  # independent variables only
Bike.pred2 <- Bike.res2$net.result

# relationship between predicted and actual values
plot(Bike.te$Bike, Bike.pred2, main = "nn2", xlab = "True", ylab = "Predicted")
cor(Bike.te$Bike, Bike.pred2)

# errors
error <- Bike.te$Bike - Bike.pred2
rmse(error)
mae(error)
# R-squared
Bike.lm2 <- lm(Bike.te$Bike ~ Bike.pred2)
abline(Bike.lm2, col="red")
summary(Bike.lm2)

# garson for nn0 model
garson(nn0, main = "nn2")
