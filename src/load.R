## Ryan Elmore
## 13 Jun 2016

library(readr)
library(lubridate)
library(dplyr)

df <- read_csv("data/311_service_data_2015.csv")

saveRDS(df, file = "data/311_service_data_2015.rds")

df_jan <- df %>% 
  filter(`Case Created Date` < ymd("2015-02-01")) 
saveRDS(df_jan, file = "data/jan_data.rds")

set.seed(10830)
df_sample <- sample_frac(df, size = .1)
saveRDS(df_sample, file = "data/311_service_data_2015_sample.rds")

df_sample <- readRDS(file = "data/311_service_data_2015_sample.rds")