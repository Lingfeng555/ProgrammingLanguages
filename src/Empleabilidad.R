employed <- unlist(strsplit(stackOverFlow$DevType[grepl("Employed, full-time", stackOverFlow$Employment)], split=", "))
employed <- table(employed)
employed

plot(employed)
