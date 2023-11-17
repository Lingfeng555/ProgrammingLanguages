issues <- read.csv(
    file = "Datasets/issues.csv",
    head = TRUE,
    sep = ",",
    quote = "\"'",
    dec = ".",
    na.strings = "NA",
    fill = TRUE
)
stackOverFlow <- read.csv(
  file = "Datasets/survey_results_public.csv",
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

