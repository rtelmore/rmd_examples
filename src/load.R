## Ryan Elmore
## 13 Jun 2016

library(readr)
library(lubridate)
library(dplyr)

df <- read_csv("data/311_service_data_2015.csv")

df$`Case Created Date` <- mdy(df$`Case Created Date`)

df_jan <- df %>% 
  filter(`Case Created Date` < ymd("2015-02-01")) 
saveRDS(df_jan, file = "data/jan_data.rds")

