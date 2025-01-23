# Include here your code for your first chosen imputation method
db <- db  %>%
  mutate(ingtot = ifelse(is.na(ingtot) == TRUE, median(db$ingtot, na.rm = TRUE) , ingtot))
