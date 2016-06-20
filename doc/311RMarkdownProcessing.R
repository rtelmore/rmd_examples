## ----packages, include = FALSE-------------------------------------------
library(lubridate)
library(dplyr)
library(knitr)

## ----knit-opts, echo = FALSE---------------------------------------------
opts_chunk$set(warning = FALSE,
               message = FALSE,
               comment = NA)

## ----cvs-to-rds, eval = FALSE, echo = TRUE-------------------------------
## library(readr)
## library(lubridate)
## library(dplyr)
## df <- read_csv("data/311_service_data_2015.csv")
## df$`Case Created Date` <- mdy(df$`Case Created Date`)
## set.seed(10830)
## df_sample <- sample_frac(df, size = .1)
## saveRDS(df_sample, file = "data/311_service_data_2015_sample.rds")

## ----cache = TRUE, echo = FALSE------------------------------------------
#This file is located on github
dfsamp <- readRDS(gzcon(url("https://github.com/rtelmore/rmd_examples/raw/master/data/311_service_data_2015_sample.rds")))

## ----eval = FALSE--------------------------------------------------------
## # This file is located on github
## dfsamp <- readRDS(gzcon(url("https://github.com/rtelmore/rmd_examples/raw/master/data/311_service_data_2015_sample.rds")))

## ----warning=FALSE-------------------------------------------------------
str(dfsamp)

## ----warning=FALSE-------------------------------------------------------
names(dfsamp) <- make.names(names(dfsamp)) #replaces spaces with .
names(dfsamp)

## ----warning=FALSE-------------------------------------------------------
select(dfsamp, starts_with("Case.C"))[1, ]

## ------------------------------------------------------------------------
#First convert to the POSIXlt format
dfsamp <- mutate(dfsamp,
                 Case.Created = mdy_hms(Case.Created.dttm),
                 Case.Closed = mdy_hms(Case.Closed.dttm),
                 Hour = hour(Case.Created),
                 Month = month(ymd(Case.Created.Date)),
                 DaysToClose = difftime(Case.Closed, 
                                        Case.Created,
                                        units = "days"))

dfsamp$Hour[1]

## ----warning=FALSE-------------------------------------------------------
dfsamp$Month[1]

## ------------------------------------------------------------------------
# dfsamp$DaysToClose <- difftime(dfsamp$Case.Closed, dfsamp$Case.Created, units = "days")
dfsamp$Case.Created[1]
dfsamp$Case.Closed[1]
dfsamp$DaysToClose[1]

## ------------------------------------------------------------------------
df <- select(dfsamp, Case.Summary, Case.Status, Case.Source,
             First.Call.Resolution, Agency, Type, Council.District, 
             Police.District, Month, Case.Closed, 
             Case.Created, Hour, DaysToClose)

## ------------------------------------------------------------------------
PDInc <- group_by(na.omit(df), Police.District) %>%
  summarize(NumIncidents = n())
# PDInc <- data.frame(table(df$Police.District))
# names(PDInc) = c("District","NumIncidents")
PDInc

## ------------------------------------------------------------------------
PDLL <- data.frame(District = 1:7,
                   Latitude = c(39.781078, 39.771207, 39.686980, 39.678371, 
                                 39.781208, 39.741227, 39.849596),
                   Longitude = c(-105.002776, -104.922977, -104.960041, 
                                  -105.019803, -104.848442, -104.978642, 
                                  -104.673364),
                   NumIncidents = PDInc$NumIncidents)
PDLL

