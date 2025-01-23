# Include here your code for your first chosen imputation method
# install pacman
if(!require(pacman)) install.packages("pacman") ; require(pacman)

# require/install packages on this session

p_load(rio, # import/export data
       tidyverse, # tidy-data
       skimr, # summary data
       visdat, # visualizing missing data
       corrplot, # Correlation Plots 
       stargazer) # tables/output to TEX. 
        

## load data
df <- import("https://github.com/ignaciomsarmiento/datasets/blob/main/GEIH_sample1.Rds?raw=true")

db <- as_tibble(df) ## from dataframe to tibble


# total income in millions
db <- db  %>%
  mutate(y_salary_m =y_salary_m/1000000 )

db <- db  %>%
  mutate(ingtot = ifelse(is.na(y_salary_m) == TRUE, median(db$y_salary_m, na.rm = TRUE) , y_salary_m))
