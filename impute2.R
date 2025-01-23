```{r}
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

# transform categorical to factor
db$maxEducLevel<- factor(db$maxEducLevel)

dummy_maxEducLevel <- as.data.frame(model.matrix(~ maxEducLevel - 1, data = db)) 
#db<- db  %>% cbind(dummy_maxEducLevel) 
db <- cbind(db, dummy_maxEducLevel)

db %>% select(maxEducLevel,maxEducLevel1, maxEducLevel2,maxEducLevel3 ,maxEducLevel4 ,maxEducLevel5 ,maxEducLevel6, maxEducLevel7 ) %>% head() 


linear_imput_model <- lm(y_salary_m ~ ingtot + sex   + maxEducLevel3 + maxEducLevel4 + maxEducLevel5 + maxEducLevel6 + maxEducLevel7 , data = db)
summary(linear_imput_model)

db$predicted_y <- predict(linear_imput_model, newdata = db)

db %>% select(y_salary_m, predicted_y, y_salary_m  ) %>% head() 

db<-  db %>%  mutate(y_salary_m = ifelse(is.na(y_salary_m) == TRUE, predicted_y , y_salary_m))

db %>% select(y_salary_m, predicted_y, y_salary_m  ) %>% head() 

## drop recently created variables
db<-  db %>% select(- maxEducLevel1, - maxEducLevel2, - maxEducLevel3, - maxEducLevel4, - maxEducLevel5, - maxEducLevel6, - maxEducLevel7,-predicted_y )
```# Include your code here for you second imputation method
