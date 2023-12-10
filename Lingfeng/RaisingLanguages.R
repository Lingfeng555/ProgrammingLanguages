#Libraries_______________________________________________________________________________________________

library(dplyr)
library(lubridate)
library(ggplot2)
library(RColorBrewer)

#Global variables____________________________________________________________________________________

#Order the raw dataframe for language and date
ordered_issues <- issues[order(issues$name, issues$year, issues$quarter, issues$count),]

#Process 2014 first quarter to 2014/03/01 and create a new column of it
dates <- ymd(paste(ordered_issues$year, "/", ordered_issues$quarter * 3, label = T, "/","01", sep = ""))

#Reorder by dates
ordered_issues <- cbind(ordered_issues, dates) 

#Functions_____________________________________________________________________________________________
getProgressiveSumVector <- function(vector){ #Get cumulative frequency
  result  <- c(vector[1])
  for(i in 2:length(vector)){
    n = result[i-1] + vector[i]
    result <- append(result, n)
  }
  return(result)
}
getLanguageDataFrame <- function(name){ #Get a ordered dataframe of a single language
  language <- data.frame(
    Dates = ordered_issues$dates[ordered_issues$name == name],
    Issues = getProgressiveSumVector(ordered_issues$count[ordered_issues$name == name])
  )
  return(language)
}
getGeomLine <- function(name, lineColor){ #Get a plot line component of a language
  language <- getLanguageDataFrame(name)
  return(geom_line(language, mapping=aes(Dates, Issues, color = name)))
}
plotCompareLanguage <- function(name1, name2){ #Get a plot that compare 2 languages 
  language1 <- getLanguageDataFrame(name1)
  language2 <- getLanguageDataFrame(name2)
  result <- ggplot() + getGeomLine(name1, "red") + getGeomLine(name2, "blue")
  return(result)
}
getTotalIssues <- function(language){
  l_dataframe <- getLanguageDataFrame(language)
  return(l_dataframe[length(l_dataframe$Issues),2])
}
getAllLanguagesPlot <- function(n){ #This is a plot for the most popular 20 languages
  result <- ggplot()
  languageNames <- unique(ordered_issues$name)
  #Filter the 20 most used languages
  l_issues_DataFrame <- data.frame(
    Names = languageNames,
    Total = unlist(lapply(languageNames, getTotalIssues))
  )
  l_issues_DataFrame <- l_issues_DataFrame[order(-l_issues_DataFrame$Total),]
  #_________________________________
  TotalColor <- grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]
  nColors <- length(languageNames)
  colorSample <- sample(TotalColor, nColors)
  for(i in 1:n){
    result <- result + getGeomLine(l_issues_DataFrame$Names[i], colorSample[i])
  }
  return(result)
}