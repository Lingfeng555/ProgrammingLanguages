library(dplyr)
library(lubridate)
library(ggplot2)

# Function to get the 'LanguageWantToWorkWith' column from the 'stackOverFlow' data frame
getColRequiredPL <- function(){
  col <- stackOverFlow$LanguageWantToWorkWith
  return(col)
}

# Function to create a vector of language counts based on the 'LanguageWantToWorkWith' column
createLanguagesVector <- function(col) {
  # Check for NA values and replace with an empty string
  col[is.na(col)] <- ""
  
  # Split the column using semicolon as a delimiter
  vec <- unlist(strsplit(col, ";"))
  UniqueVec <- unique(vec)
  
  counts <- numeric(length(UniqueVec))
  
  # Iterate over unique element names
  for (i in seq_along(UniqueVec)) {
    # Count occurrences and store in the 'counts' vector
    counts[i] <- sum(vec == UniqueVec[i])
  }
  
  # Return the named vector of counts
  names(counts) <- UniqueVec
  return(counts)
}
# Function to create a pie chart of the most required programming languages
createMostRequiredPie <- function(){
  colRequiredPL <- getColRequiredPL()
  counts <- createLanguagesVector(colRequiredPL)
  
  values <- as.numeric(counts)
  names <- names(counts)
  
  ordered_indices <- order(values, decreasing = TRUE)
  ordered_values <- values[ordered_indices]
  first_ordered_values <- ordered_values[1:12]
  otherRequiredValues <- sum(ordered_values[13:length(ordered_values)])
  ordered_names <- names[ordered_indices]
  ordered_names <- c(ordered_names[1:12], "Others")
  values <- c(first_ordered_values, otherRequiredValues)
  df_required <- data.frame(
    Name = ordered_names,
    Values = values
  )
  gg_pie <- ggplot(df_required, aes(x = "", y = Values, fill = Name)) +
    geom_bar(stat = "identity", width = 1) +
    coord_polar("y") +
    theme_void() +
    ggtitle("Most required")
}
