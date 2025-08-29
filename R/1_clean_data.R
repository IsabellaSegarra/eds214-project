#................Cleaning stream chemistry data................
#set up
#clear global environment
rm(list=ls())

#Load in data from "data" folder. 
library(here)  #Call data using "here" package. 
library(tidyverse) 
library(dplyr) # added for select function - install package
library(here) # added for here function - install package
library(janitor) #added for "clean names" function

#Source function
source(here("R", "rolling_mean_function.R"))

#Read in stream data 
bq1 <- read_csv(here::here("data", 
                           "stream-water-pr",
                           "QuebradaCuenca1-Bisley.csv")) %>% 
  clean_names() 

bq2 <- read_csv(here::here("data", 
                           "stream-water-pr",
                           "QuebradaCuenca2-Bisley.csv")) %>% 
  clean_names()


bq3 <- read_csv(here::here("data", 
                           "stream-water-pr",
                           "QuebradaCuenca3-Bisley.csv")) %>% 
  clean_names() 


mpr <- read_csv(here::here("data", 
                           "stream-water-pr",
                           "RioMameyesPuenteRoto.csv")) %>% 
  clean_names() 


# Filter data by only relevant chemicals/nutrients in the study. 

bq1_chemicals <- bq1 %>%
  select(sample_id,sample_date, k, no3_n, mg, ca, nh4_n)  

bq2_chemicals <- bq2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

bq3_chemicals <- bq3 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

mpr_chemicals <- mpr %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)


# Combine dataframes into dataset called "streams" 

streams <- rbind(bq1_chemicals, bq2_chemicals, bq3_chemicals, mpr_chemicals) 

# Filter stream data to reflect the study time frame from 1988 to 1994. 
streams %>% 
  filter((sample_date >= "1988-01-10" & sample_date < "1994-07-31"))

# Pivot dataset 
streams_longer <- streams %>%  
  pivot_longer(cols = c(k, mg, ca, nh4_n, no3_n), names_to = "chemical", 
               values_to = "chem_conc") 

#Apply function to create rolling average function
streams_longer$rolling_avg <- sapply(
  streams_longer$sample_date,
  rolling_mean,
  dates = streams_longer$sample_date,
  conc = streams_longer$chem_conc,
  win_size_wks = 9
)

write_csv(streams_longer, here("processed-data", "streams.csv"))

