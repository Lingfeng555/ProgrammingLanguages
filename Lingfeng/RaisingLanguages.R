library(dplyr)
library(lubridate)
library(ggplot2)
library(RColorBrewer)
ordered_issues <- issues[order(issues$name, issues$year, issues$quarter, issues$count),]
dates <- ymd(paste(ordered_issues$year, "/",month(ordered_issues$quarter * 3, label = T), "/","01"))
ordered_issues <- cbind(ordered_issues, dates)
getProgressiveSumVector <- function(vector){
  result  <- c(vector[1])
  for(i in 2:length(vector)){
    n = result[i-1] + vector[i]
    result <- append(result, n)
  }
  return(result)
}

getLanguageDataFrame <- function(name){
  language <- data.frame(
    Dates = ordered_issues$dates[ordered_issues$name == name],
    Issues = getProgressiveSumVector(ordered_issues$count[ordered_issues$name == name])
  )
  return(language)
}

getGeomLine <- function(name, lineColor){
  language <- getLanguageDataFrame(name)
  return(geom_line(language, mapping=aes(Dates, Issues, color = name)))
}

plotCompareLanguage <- function(name1, name2){
  language1 <- getLanguageDataFrame(name1)
  language2 <- getLanguageDataFrame(name2)
  result <- ggplot() + getGeomLine(name1, "red") + getGeomLine(name2, "blue")
  return(result)
}


getAllLanguagesPlot <- function(){
  result <- ggplot()
  languageNames <- unique(ordered_issues$name)
  #Filter the 20 most used languages
  #_________________________________
  TotalColor <- grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]
  nColors <- length(languageNames)
  colorSample <- sample(TotalColor, nColors)
  for(i in 1:length(languageNames)){
    result <- result + getGeomLine(languageNames[i], colorSample[i])
  }
  return(result)
} 






