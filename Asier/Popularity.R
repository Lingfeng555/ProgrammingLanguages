library(dplyr)
library(lubridate)
library(ggplot2)


# Function to get column names from the popularity data frame
getColsNamesFromPopularity <- function(){
  cols <- colnames(popularity)
  cols <- cols[cols != "Date"]
  return(cols)
}

# Function to get a specific row of the 'popularity' data frame based on the date given by the input
getRowFromPopularity <- function(date){
  row <- popularity[popularity$Date == date,]
  row <- as.numeric(row[row != date])
  return(row)
}

# Function to create a smaller data frame with the values in the exact date
selectedValuesInDF <- function(date){
  df <- data.frame(
    Name = getColsNamesFromPopularity(),
    Values = getRowFromPopularity(date)
  )
  df <- df[order(-df$Values),]
  return(df)
}
# Function to order the names of the programing languages in the new data frame
getColsOrdered <- function(df){
  cols2<- df[,1]
  return(cols2)
}
# Function to order the values of the programing languages in the new data frame
getRowFromOrderedDF <- function(df){
  row2 <- df[,2]
  row2 <- as.numeric(row2)
  return(row2)
}
# Main function to create the plot with all the function
createPopularityPie <- function(monthValue, year) {
  cols <- getColsNamesFromPopularity()
  df <- selectedValuesInDF(paste(month(monthValue, label = TRUE, abbr = FALSE, locale = "en"), year))
  cols2 <- getColsOrdered(df)
  values <- getRowFromOrderedDF(df)
  valuesDisplay <- values[1:10]
  otherValues <- values[11:length(values)]
  otherValues <- sum(otherValues)
  values <- c(valuesDisplay, otherValues)
  cols2 <- c(cols2[1:10], "Others")
  df <- data.frame(
    Name = cols2,
    Values = values
  )
  return(ggplot(df, aes(x = "", y = Values, fill = Name)) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar("y") +
    theme_void() +
    ggtitle("Popularity"))
}

