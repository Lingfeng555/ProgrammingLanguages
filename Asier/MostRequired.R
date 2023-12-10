library(dplyr)
library(lubridate)
library(ggplot2)

getColRequiredPL <- function(){
  col <- stackOverFlow$LanguageWantToWorkWith
  return(col)
}

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

colRequiredPL <- getColRequiredPL()
counts <- createLanguagesVector(colRequiredPL)

values <- as.numeric(counts)
names <- names(counts)

ordered_indices <- order(values, decreasing = TRUE)
ordered_values <- values[ordered_indices]
first_ordered_values <- ordered_values[1:12]
otherRequiredValues <- sum(ordered_values[13:length(ordered_values)])
ordered_names <- names[ordered_indices]

pie(c(first_ordered_values, otherRequiredValues), labels = c(ordered_names[1:12], "Others"), main = "Chorizo")

