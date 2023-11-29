issues <- read.csv(
    file = "Datasets/issues.csv",
    head = TRUE,
    sep = ",",
    dec = ".",
    na.strings = "NA",
    fill = TRUE
)
popularity <- read.csv(
  file = "Datasets/PopularityProgrammingLanguages2004to2023.csv",
  head = TRUE,
  sep = ",",
  dec = ".",
  na.strings = "NA",
  fill = TRUE
)
githubRepos <- read.csv(
  file = "Datasets/repos.csv",
  head = TRUE,
  sep = ",",
  dec = ".",
  na.strings = "NA",
  fill = TRUE
)
prs <- read.csv(
  file = "Datasets/prs.csv",
  head = TRUE,
  sep = ",",
  dec = ".",
  na.strings = "NA",
  fill = TRUE
)

isnothing = function(x) {
  is.null(x) | is.na(x) | is.nan(x)
}
setValue <- function(){
  indexedStackOverflow <- read.csv(
    file = "CleanDatasetPy/indexedStackOverflow.csv",
    head = TRUE,
    sep = ",",
    dec = ".",
    na.strings = "",
    fill = TRUE
  )
  compressedColumns <- read.csv(
    file = "CleanDatasetPy/compressedColumns.csv",
    head = TRUE,
    sep = ",",
    dec = ".",
    na.strings = "",
    fill = TRUE
  )
  stackOverFlowKetSet <- read.csv(
    file = "CleanDatasetPy/stackOverflowKeySet.csv",
    head = TRUE,
    sep = ",",
    dec = ".",
    na.strings = "",
    fill = TRUE
  )
  for(colum in compressedColumns$X0){
    str2 <- paste("Colum" , colum)
    print(str2)
    for(row in 0:length(indexedStackOverflow[[colum]])){
      if( !rlang::is_empty(indexedStackOverflow[row, colum])  ) {
        indexedStackOverflow[row, colum] <- stackOverFlowKetSet$X0[strtoi(indexedStackOverflow[row,colum]) + 1]          
      }
    }
  }
  return(indexedStackOverflow);
}
stackOverFlow <- setValue()
