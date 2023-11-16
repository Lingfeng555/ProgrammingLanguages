stackOverFlow <- read.csv(
    file = "Datasets/survey_results_public.csv",
    head = TRUE,
    sep = ",",
    quote = "\"'",
    dec = ".",
    na.strings = "NA",
    fill = TRUE
)
view(stackOverFlow)