#clear global environmnet
rm(list=ls())

#Load libraries
library(here)
library(janitor)
library(tidyverse)
library(ggplot2)
library(lubridate)

#Read in data from Bisley and Puente Roto Mameyes
BQ1 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca1-Bisley.csv"))
BQ2 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca2-Bisley.csv"))
BQ3 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca3-Bisley.csv"))
MPR <- read_csv(here::here("data", "stream-water-pr","RioMameyesPuenteRoto.csv"))      
                                   
#Grouping by chemical- K
#BQ1_chemicals -- columns for each chemical 
# or full join BQ1_k, BQ2_k, BQ3_k, MPR_k 

BQ1_k <- BQ1 %>% 
  group_by(sample_date, k) %>% 
  filter()

BQ1_k <- BQ1 %>% 
  select(sample_date, k)

BQ2_k <- BQ2 %>% 
  select(sample_date, k)

BQ3_k <- BQ3 %>% 
  select(sample_date, k)

MPR_k <- MPR %>% 
  select(sample_date, k)

streams_k <- full_join(BQ1_k, BQ2_k, BQ3_k, MPR_k)


#Another way
BQ1_chemicals <- BQ1 %>%
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

BQ2_chemicals <- BQ2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

BQ3_chemicals <- BQ2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

MPR_chemicals <- MPR %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

#streams <- full_join(BQ1_chemicals, BQ2_chemicals, BQ3_chemicals, MPR_chemicals) 

streams <- rbind(BQ1_chemicals, BQ2_chemicals, BQ3_chemicals, MPR_chemicals)


foo <- data.frame(a = 1:3, b = 4:6)
bar <- data.frame(a = 7:9, b = 10:12)
foo
bar
rbind(foo, bar)


lubridate::mdy(my_date)

#plot K


ggplot(data = streams, aes(x = sample_date, y = k)) +
         geom_line()

#figure out moving time


streams <- streams %>% mutate(sample_date = lubridate::mdy(sample_date))


foo <- data.frame(a = 1:3, b = 4:6)
bar <- data.frame(a = 7:9, b = 10:12)
foo
bar
rbind(foo, bar)



