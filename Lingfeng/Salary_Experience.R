library(dplyr)
library(ggplot2)
library(stringr)

getTarget <- function(){ #This is considering the exchange of currencies 1 euro = 1 dollar
  res <- (stackOverFlow$Employment == 'Employed, full-time' & 
    (  (stackOverFlow$Currency=='USD\tUnited States dollar' 
        & stackOverFlow$Country =='United States of America') | stackOverFlow$Currency=="EUR European Euro")& 
    !is.na(stackOverFlow$CompTotal) & 
    !is.na(stackOverFlow$YearsCodePro) &
    !is.na(stackOverFlow$LanguageHaveWorkedWith))
  return(res)
  
}

builtBasedDataFrame <- function(){
  fullTimeSalaries <- stackOverFlow$CompTotal[getTarget()]
  yearsFullTimeExperience <- stackOverFlow$YearsCodePro[getTarget()]
  yearsFullTimeExperience <- replace(yearsFullTimeExperience, yearsFullTimeExperience == "Less than 1 year", "0")
  yearsFullTimeExperience <- replace(yearsFullTimeExperience, yearsFullTimeExperience == "More than 50 years", "50")
  yearsFullTimeExperience <- strtoi(yearsFullTimeExperience, base=0L)
  workingLanguages <- stackOverFlow$LanguageHaveWorkedWith[getTarget()]
  allLanguages <- unique(unlist(str_split(workingLanguages, ";")))
  
  language_exp_salarie <- data.frame(
    Experience = yearsFullTimeExperience,
    Languages = workingLanguages,
    Salaries = fullTimeSalaries
  )
  
  language_exp_salarie <- language_exp_salarie[order(language_exp_salarie$Experience, language_exp_salarie$Salaries),] #There is few outlies
  upperBound <- quantile(language_exp_salarie$Salaries, 0.975) #Value extrated based on the biggest difference
  lowerBound <- quantile(language_exp_salarie$Salaries, 0.008) #Based on USA min salarie
  index_outliers <- which(language_exp_salarie$Salaries<lowerBound | language_exp_salarie$Salaries>upperBound)
  language_exp_salarie <- filter(language_exp_salarie, !row_number() %in% index_outliers)
  return(language_exp_salarie)
}

getSalarieByExperience <- function(){
  result <- c()
  for (i in unique(language_exp_salarie$Experience)) {
    result <- rbind(result, mean(language_exp_salarie$Salaries[language_exp_salarie$Experience==i]) )
  }
  return(result)
}

language_exp_salarie <- builtBasedDataFrame()
salariePerExp <- data.frame(
  Experience = unique(language_exp_salarie$Experience),
  Salarie = getSalarieByExperience()
)
ggplot() + geom_line(salariePerExp, mapping = aes(x=salariePerExp$Experience, y=salariePerExp$Salarie))
