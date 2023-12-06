library(stringr)
library(ggplot2)

# Getting the primary language of each respondent out of all it's used languages
stackOverFlow$FirstLanguage <- str_extract(stackOverFlow$LanguageHaveWorkedWith, "[^;]+")

# Extract all unique first languages
languages <- unique(stackOverFlow$FirstLanguage)

# This function returns a dataframe with the 3 most used IDE and the sum of the others for a language
get_lang_ide <- function(lang) {
  # Handle special characters "c++"
  lang_ide <- stackOverFlow$NEWCollabToolsHaveWorkedWith[grepl(lang, stackOverFlow$FirstLanguage, fixed = TRUE)]
  lang_ide <- strsplit(lang_ide, split = ";")
  data_ide <- table(unlist(lang_ide))
  data_ide <- data.frame(IDE = names(data_ide), Count = as.numeric(data_ide))
  
  # Select top 3 IDEs and create an "Other" category that contains all the other IDEs
  if (nrow(data_ide) > 0) {
    # If the language has 3 or more IDEs it created the "other" category
    if (nrow(data_ide) > 3) {
      top3_ide <- head(data_ide[order(data_ide$Count, decreasing = TRUE), ], 3)
      other_ide <- data.frame(IDE = "Other", Count = sum(data_ide$Count) - sum(top3_ide$Count))
      
      # Combine top 3 IDEs and "Other" category
      result <- rbind(top3_ide, other_ide)
    # Else it just returns all the used IDEs
    } else {
      result <- data_ide
    }
  # If the language doesn't have any IDE assign it returns NULL
  } else {
    result <- NULL
  }
  return(result)
}

popular_ide <- list()

# Loop through languages to store results in popular_ide
for (lang in languages) {
  data_ide <- get_lang_ide(lang)
  popular_ide[[lang]] <- data_ide
}

ide_plot_list <- list()

# Plotting a bar chart for each language and storing the plots on plot_list
for (lang in languages) {
  if (length(popular_ide[[lang]]) > 0) {
    plot <- ggplot(popular_ide[[lang]], aes(x = reorder(IDE, -Count), y = Count)) +
      geom_bar(stat = "identity", position = "dodge", fill = "#FF8C69") +
      labs(title = paste("Top 3 IDEs for", lang),
           x = "IDE",
           y = "Number of Users") +
      scale_fill_brewer(palette = "Set1") +
      theme_minimal()
    
    ide_plot_list[[lang]] <- plot
  }
}

ide_plot_list[["R"]]
