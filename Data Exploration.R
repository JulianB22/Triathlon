#Explore outliers
scatter.smooth(x=OlympicMen$BIKE, y=OlympicMen$`TOTAL TIME`, col=OlympicMen$`PROG ID`,
               xlab= "Bike Time (seconds)", ylab = "Total Time (seconds)", main = "Olympic Distance (Male)")
scatter.smooth(x=OlympicMen$RUN, y=OlympicMen$`TOTAL TIME`, col=OlympicMen$`PROG ID`,
               xlab= "Run Time (seconds)", ylab = "Total Time (seconds)", main = "Olympic Distance (Male)")
scatter.smooth(x=OlympicMen$SWIM, y=OlympicMen$`TOTAL TIME`, col=OlympicMen$`PROG ID`,
               xlab= "Swim Time (seconds)", ylab = "Total Time (seconds)", main = "Olympic Distance (Men)")

# Remove outliers
OlympicMen <- OlympicMen %>% filter(`PROG ID` !="270576", `PROG ID` !="7900",
                                    `PROG ID` !="258903",
                                    `PROG ID` !="4541" & `ATHLETE ID` != "5657",
                                    `PROG ID` !="307209" & `ATHLETE ID` != "55504",
                                    `PROG ID` !="7809" & `ATHLETE ID` != "11060")

# Segment distribution
boxplot(SprintMen$SwimPercentage, SprintWomen$SwimPercentage, OlympicMen$SwimPercentage, OlympicWomen$SwimPercentage,
        SprintMen$BikePercentage, SprintWomen$BikePercentage, OlympicMen$BikePercentage, OlympicWomen$BikePercentage, 
        SprintMen$RunPercentage, SprintWomen$RunPercentage, OlympicMen$RunPercentage,OlympicWomen$RunPercentage,
        xlab= "Performance Groups", ylab = "Distribution", main = "Segment Distribution")

#Add average course time variable
OlympicMen$CourseAverageBike <- ave(OlympicMen$Bike, OlympicMen$LOCATION, FUN = mean)
OlympicMen$CourseAverageRun <- ave(OlympicMen$Run, OlympicMen$LOCATION, FUN = mean)

OlympicWomen$CourseAverageBike <- ave(OlympicWomen$Bike, OlympicWomen$LOCATION, FUN = mean)
OlympicWomen$CourseAverageRun <- ave(OlympicWomen$Run, OlympicWomen$LOCATION, FUN = mean)

SprintMen$CourseAverageBike <- ave(SprintMen$Bike, SprintMen$LOCATION, FUN = mean)
SprintMen$CourseAverageRun <- ave(SprintMen$Run, SprintMen$LOCATION, FUN = mean)

SprintWomen$CourseAverageBike <- ave(SprintWomen$Bike, SprintWomen$LOCATION, FUN = mean)
SprintWomen$CourseAverageRun <- ave(SprintWomen$Run, SprintWomen$LOCATION, FUN = mean)

#Visualise correlations
pairs.panels(StandardEM[Times], method = "spearman", hist.col = "grey", col = "blue", main = "Olympic Distance (Male)")
pairs.panels(StandardEW[Times], method = "spearman", hist.col = "grey", col = "blue", main = "StandardEW")
pairs.panels(SprintEM[Times], method = "spearman", hist.col = "grey", col = "blue", main = "SprintEM")
pairs.panels(SprintEW[Times], method = "spearman", hist.col = "grey", col = "blue", main = "SprintEW")
