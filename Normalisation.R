# Root Mean Squared Error function
rmse <- function(error)
{sqrt(mean(error^2))}

# Mean Absolute Error function
mae <- function(error)
{mean(abs(error))}

# Load Data
TriResults <- OlympicMale
TriResults <- subset(TriResults, select = c(Swim, Bike, Run, TotalTime, CourseAverageBike, CourseAverageRun))
missmap(TriResults, col = c("black", "grey"), legend = FALSE)

# Soft max normalisation
boxplot(TriResults)
TriResults.nm <- as.data.frame(apply(TriResults, MARGIN = 2, FUN = function(x) (SoftMax(x,lambda = 2, mean(x), sd(x)))))
boxplot (TriResults.nm, main = "Soft Max, lambda = 2")

# Create train and test data sets
set.seed(12345)
TriResults_ <- TriResults.nm[order(runif(3130)), ]

# Split data set
TriResults.tr <- TriResults_[1:2190, ]     # 70%
TriResults.te <- TriResults_[2191:3130, ]   # 30%

#Bike
Bike <- subset(TriResults_, select = c(Swim, Bike, CourseAverageBike, TotalTime) )
Bike.tr <- subset(TriResults.tr, select = c(Swim, Bike, CourseAverageBike, TotalTime) )
Bike.te <- subset(TriResults.te, select = c(Swim, Bike, CourseAverageBike, TotalTime) )

# Check the distribution of target variable
boxplot(Bike$Bike, Bike.tr$Bike, Bike.te$Bike, 
        names = c("Bike all", "Bike train", "Bike test"))
