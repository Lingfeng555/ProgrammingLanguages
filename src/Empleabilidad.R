library(ggplot2)


get_employed_devtype <- function() {
  employed <- unlist(strsplit(stackOverFlow$DevType[grepl("Employed, full-time", stackOverFlow$Employment)], split=", "))
  employed <- table(employed)
  employed <- data.frame(Type = names(employed), Count = as.numeric(employed))
  return(employed)
}

get_employed_edLevel <- function() {
  employed <- unlist(stackOverFlow$EdLevel[grepl("Employed, full-time", stackOverFlow$Employment)])
  employed <- table(employed)
  employed <- data.frame(Type = names(employed), Count = as.numeric(employed))
  return(employed)
}

get_top <- function(df, n) {
  top <- head(df[order(df$Count, decreasing = TRUE), ], n)
  return(top)
}

# ---- DEV TYPES ----
employed_devTypes <- get_employed_devtype()
employed_devTypes <- employed_devTypes[!(employed_devTypes$Type %in% c("Developer", "Other")), ]
employed_devTypes <- get_top(employed_devTypes, 15)

employed_devTypes$Percentage <- (employed_devTypes$Count / sum(employed_devTypes$Count)) * 100

devType_employment_plot <- ggplot(employed_devTypes, aes(x = reorder(Type, Percentage), y = Percentage)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.7) +
  coord_flip() +
  labs(title = "Top 15 employed dev types",
       x = "Dev Type",
       y = "Percentage") +
  theme(axis.text.y = element_text(angle = 30, hjust = 1))


# ---- ED LEVEL ----
employed_edLevel <- get_employed_edLevel()
employed_edLevel <- get_top(employed_edLevel, 8)

employed_edLevel$Percentage <- (employed_edLevel$Count / sum(employed_edLevel$Count)) * 100

edLevel_employment_plot <- ggplot(employed_edLevel, aes(x = reorder(Type, Percentage), y = Percentage)) +
  geom_bar(stat = "identity", fill = "skyblue", width = 0.7) +
  coord_flip() +
  labs(title = "Top 8 employed by education level",
       x = "Education Level",
       y = "Percentage") +
  theme(axis.text.y = element_text(angle = 30, hjust = 1))

