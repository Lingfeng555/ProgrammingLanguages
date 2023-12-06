employed <- unlist(strsplit(stackOverFlow$DevType[grepl("Employed, full-time", stackOverFlow$Employment)], split=", "))
employed <- table(employed)
employed <- data.frame(devType = names(employed), Count = as.numeric(employed))

top10_devType <- head(employed[order(employed$Count, decreasing = TRUE), ], 5)
other_devType <- data.frame(devType = "Other", Count = sum(employed$Count) - sum(top10_devType$Count))
result <- rbind(top10_devType, other_devType)

barplot((result$Count / sum(result$Count)) * 100, names.arg = result$devType,
        main = paste("Top 10 employed dev types"), xlab = "Dev Type", ylab = "Percentage")
