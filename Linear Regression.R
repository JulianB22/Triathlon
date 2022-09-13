# Correlation and simple linear regression
cor(Bike.tr$Bike, Bike.tr$TotalTime, method = "pearson")
plot(Bike.tr$Bike, Bike.tr$TotalTime, main="Scatterplot",
     xlab = "Bike", ylab = "TotalTime")

# Linear Regression
model1 <- lm(Bike ~ TotalTime, data = Bike.tr)
Bike.pr0 <- predict.lm(model1, Bike.te, se.fit=TRUE)

# Scatter plot with regression line
plot(Bike.tr$Bike, Bike.tr$TotalTime, main = "Simple Linear Regression Model",
     xlab = "Bike", ylab = "TotalTime")
abline(model1, col="red")

# Model summary
summary(model1)

# Test lowest correlation of numerical variables for significance???
cor.test(Bike.tr$Bike, Bike.tr$TotalTime, method = "pearson")

# RMSE
error <- Bike.te$Bike - Bike.pr0$fit
rmse(error)

# Multiple linear regression
model2 <- lm(Bike ~ ., data = Bike.tr)  # exclude medv
summary(model2)
hist(model2$residuals, main = "Model residuals", col = "grey")
rug(model2$residuals, side = 3)
plot(model2$residuals ~ model2$fitted.values, xlab = "fitted values", ylab = "residuals")
qqnorm(model2$residuals, xlab = "Theoretical Quantiles: model2 residuals" )
qqline(model2$residuals, col = 2) ## red color

# calculate variance inflation factor
vif(model2)
sqrt(vif(model2)) > 2  # if > 2 vif too high

# Test prediction of model2
Bike.te2 <- Bike.te[c("Swim", "Bike", "CourseAverageBike", "TotalTime")]
Bike.pr1 <- predict.lm(model2, Bike.te2, se.fit=TRUE)

# Plot actual versus predicted values
boxplot(Bike.te$Bike, Bike.pr1$fit,
        xlab="Actual vs Predicted", col = "Bisque")
plot(Bike.te$Bike, Bike.pr1$fit, main="Scatterplot",
     xlab="medv_t actual", ylab="medv_t predict")
cor(Bike.te$Bike, Bike.pr1$fit)

# RMSE
error <- Bike.te$Bike - Bike.pr1$fit
rmse(error)
# MAE
mae(error)
# R-squared
resid.mod1 <- lm(Bike.te$Bike ~ Bike.pr1$fit)
summary(resid.mod1)
