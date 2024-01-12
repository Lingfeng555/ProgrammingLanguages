#Libraries_______________________________________________________________________________________
library(dplyr)
library(ggplot2)
library(stringr)

#Functions_______________________________________________________________________________________
#To filter data, in ordor to adjust currency exchange that can influence the real mean value because of economics efects, them It is neccessary to select only stable currencys
getTarget <- function(){ #This is considering the exchange of currencies 1 euro = 1 dollar
  res <- (stackOverFlow$Employment == 'Employed, full-time' & 
    (  (stackOverFlow$Currency=='USD\tUnited States dollar' 
        & stackOverFlow$Country =='United States of America') | stackOverFlow$Currency=="EUR European Euro")& 
    !is.na(stackOverFlow$CompTotal) & 
    !is.na(stackOverFlow$YearsCodePro) &
    !is.na(stackOverFlow$LanguageHaveWorkedWith))
  return(res)
}

#This function build the based dataframe after all data cleaning process
builtBasedDataFrame <- function(){
  fullTimeSalaries <- stackOverFlow$CompTotal[getTarget()]
  yearsFullTimeExperience <- stackOverFlow$YearsCodePro[getTarget()]
  yearsFullTimeExperience <- replace(yearsFullTimeExperience, yearsFullTimeExperience == "Less than 1 year", "0") #Considere it as 0 years at working experience
  yearsFullTimeExperience <- replace(yearsFullTimeExperience, yearsFullTimeExperience == "More than 50 years", "50") #Considere it as 50 years as max
  yearsFullTimeExperience <- strtoi(yearsFullTimeExperience, base=0L)
  workingLanguages <- stackOverFlow$LanguageHaveWorkedWith[getTarget()]
  allLanguages <- unique(unlist(str_split(workingLanguages, ";")))
  
  language_exp_salarie <- data.frame(
    Experience = yearsFullTimeExperience,
    Languages = workingLanguages,
    Salaries = fullTimeSalaries
  )
  
  language_exp_salarie <- language_exp_salarie[order(language_exp_salarie$Experience, language_exp_salarie$Salaries),] #There is few outlies so we have so manage them
  upperBound <- quantile(language_exp_salarie$Salaries, 0.975) #Value extracted based on the biggest difference, probably the respondent has confused putting zeros
  lowerBound <- quantile(language_exp_salarie$Salaries, 0.008) #Based on USA min salaries
  index_outliers <- which(language_exp_salarie$Salaries<lowerBound | language_exp_salarie$Salaries>upperBound)
  language_exp_salarie <- filter(language_exp_salarie, !row_number() %in% index_outliers)
  return(language_exp_salarie)
}

#This function get mean salarie of each language
getSalarieByExperience <- function(){
  result <- c()
  for (i in unique(language_exp_salarie$Experience)) {
    result <- rbind(result, mean(language_exp_salarie$Salaries[language_exp_salarie$Experience==i]) )
  }
  return(result)
}

#Get a vector of names of all languages
getLanguages <- function(){
  workingLanguages <- stackOverFlow$LanguageHaveWorkedWith[getTarget()]
  allLanguages <- unique(unlist(str_split(workingLanguages, ";")))
  return(allLanguages)
}

#Get a dataframe that contains each language with their mean salarie and mean exp
getLangExpSal <- function(BaseDataFrame){
  allLanguages <- getLanguages()
  meanExperience <- c()
  meanSalarie <- c()
  for (i in allLanguages) {
    if(i=="Bash/Shell (all shells)"){
      i <- "Bash"
    }else if(i=="Visual Basic (.Net)"){
      i <- "Visual"
    }
    meanExperience <- rbind(meanExperience, mean(BaseDataFrame$Experience[str_detect(language_exp_salarie$Languages, i)]))
    meanSalarie <- rbind(meanSalarie, mean(BaseDataFrame$Salaries[str_detect(language_exp_salarie$Languages, i)]))
  }
  
  languageDataFrame <- data.frame(
    Language = allLanguages,
    MeanExp = meanExperience,
    MeanSal = meanSalarie
  )
  
  return(languageDataFrame)
}

#Results______________________________________________________________________________________
language_exp_salarie <- builtBasedDataFrame()
salariePerExp <- data.frame(
  Experience = unique(language_exp_salarie$Experience),
  Salarie = getSalarieByExperience()
)
langMean <- getLangExpSal(language_exp_salarie)


plot_Salary <- ggplot() + geom_line(salariePerExp, mapping = aes(x=Experience, y=Salarie)) #line plot of the salarie
plot_Lang <- ggplot() + geom_text(data=langMean, mapping = aes(x=MeanExp, y=MeanSal, label = Language)) #Dot plot of languages
plot_Mixt <- ggplot() + geom_line(salariePerExp, mapping = aes(x=Experience, y=Salarie)) + geom_text(data=langMean, mapping = aes(x=MeanExp, y=MeanSal, label = Language)) #Mixed plot

