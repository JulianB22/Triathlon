#Plug standard or sprint data into preparation
Results <- bind_rows(Standard, Sprint)

#Remove athlete names, nationality, start number columns
Results2 = subset(Results2, select = -c(NATIONALITY, `ATHLETE FIRST`, `ATHLETE LAST`, `START NUMBER`) )
#Remove DNF, LAP, DNS and DSQ (nulls) rows
Results3 <- Results2 %>% filter(POSITION !="DNF", POSITION !="LAP", 
                                POSITION !="DNS", POSITION !="DSQ",
                                RUN !="00:00:00", SWIM !="00:00:00",
                                BIKE !="00:00:00", T2 !="00:00:00",
                                T1 !="00:00:00", PROGRAM == "Elite Men" | PROGRAM == "Elite Women")

#Convert to seconds
Results3$Swim <- period_to_seconds(hms(Results3$SWIM))
Results3$T1 <- period_to_seconds(hms(Results3$T1))
Results3$Bike <- period_to_seconds(hms(Results3$BIKE))
Results3$T2 <- period_to_seconds(hms(Results3$T2))
Results3$Run <- period_to_seconds(hms(Results3$RUN))
Results3$TotalTime <- period_to_seconds(hms(Results3$`TOTAL TIME`))

#Add average race time
Results3$SwimAvg <- ave(Results3$SWIM, Results3$`PROG ID`, FUN = mean)
Results3$BikeAvg <- ave(Results3$BIKE, Results3$`PROG ID`, FUN = mean)
Results3$RunAvg <- ave(Results3$RUN, Results3$`PROG ID`, FUN = mean)
Results3$TotalAvg <- ave(Results3$`TOTAL TIME`, Results3$`PROG ID`, FUN = mean)

#Add position coefficient
Results3 <- Results3 %>%
  group_by(`PROG ID`) %>%
  mutate(TotalProg = n()) %>%
  ungroup()

Results3 <- Results3 %>%
  group_by(`PROG ID`) %>%
  mutate(SwimRank = order(order(`PROG ID`, SWIM, decreasing=TRUE)))
Results3$SwimRank <- with(Results3, SwimRank/TotalProg)

Results3 <- Results3 %>%
  group_by(`PROG ID`) %>%
  mutate(T1Rank = order(order(`PROG ID`, T1, decreasing=TRUE)))
Results3$T1Rank <- with(Results3, T1Rank/TotalProg)

Results3 <- Results3 %>%
  group_by(`PROG ID`) %>%
  mutate(BikeRank = order(order(`PROG ID`, BIKE, decreasing=TRUE)))
Results3$BikeRank <- with(Results3, BikeRank/TotalProg)

Results3 <- Results3 %>%
  group_by(`PROG ID`) %>%
  mutate(T2Rank = order(order(`PROG ID`, T2, decreasing=TRUE)))
Results3$T2Rank <- with(Results3, T2Rank/TotalProg)

Results3 <- Results3 %>%
  group_by(`PROG ID`) %>%
  mutate(RunRank = order(order(`PROG ID`, RUN, decreasing=TRUE)))
Results3$RunRank <- with(Results3, RunRank/TotalProg)

Results3 <- Results3 %>%
  group_by(`PROG ID`) %>%
  mutate(TotalRank = order(order(`PROG ID`, `TOTAL TIME`, decreasing=TRUE)))
Results3$TotalRank <- with(Results3, TotalRank/TotalProg)

#Add segment percentage
Results3$SwimPercentage <- with(Results3, SWIM/`TOTAL TIME`)
Results3$BikePercentage <- with(Results3, BIKE/`TOTAL TIME`)
Results3$RunPercentage <- with(Results3, RUN/`TOTAL TIME`)

#Split by gender and distance
SprintMen <- Results3 %>% filter(PROGRAM == "Elite Men", TotalTime< 5500)
SprintWomen <- Results3 %>% filter(PROGRAM == "Elite Women", TotalTime< 5500)
OlympicMen <- Results3 %>% filter(PROGRAM == "Elite Men", TotalTime> 5500)
OlympicWomen <- Results3 %>% filter(PROGRAM == "Elite Women", TotalTime> 5500)
