library(dplyr)
library(lubridate)
library(ggplot2)

getColsNamesFromPopularity <- function(){
  cols <- colnames(popularity)
  cols <- cols[cols != "Date"]
  return(cols)
}

getRowFromPopularity <- function(date){
  row <- popularity[popularity$Date == date,]
  row <- as.numeric(row[row != date])
  return(row)
}

selectedValuesInDF <- function(){
  df <- data.frame(
    Name = cols,
    Values = getRowFromPopularity("July 2004")
  )
  df <- df[order(-df$Values),]
  return(df)
}

getColsOrdered <- function(){
  cols2<- df[,1]
  return(cols2)
}
cols2 <- getColsOrdered()
getRowFromOrderedDF <- function(){
  row2 <- df[,2]
  row2 <- as.numeric(row2)
  return(row2)
}

cols <- getColsNamesFromPopularity()
df <- selectedValuesInDF()
cols2 <- getColsOrdered()
values <- getRowFromOrderedDF()
valuesDisplay <- values[1:10]
otherValues <- values[11:length(values)]
otherValues <- sum(otherValues)

pie(c(valuesDisplay, otherValues), labels = c(cols2[1:10], "Others"), main = "Patata")

