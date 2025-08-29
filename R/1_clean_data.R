#................Cleaning stream chemistry data................
# This R script is for importing and cleaning the data. 

#---Set up---
  #clear global environment
rm(list=ls())

  #Load in relevant libraries. 
library(here)  #Call data using "here" package. 
library(tidyverse) #Read data frames 
library(dplyr) # added for select function - install package
library(here) # added for here function - install package
library(janitor) #added for "clean names" function

#---Read in data---
  #Read in stream data and clean names
bq1 <- read_csv(here::here("data", 
                           "stream-water-pr",
                           "QuebradaCuenca1-Bisley.csv")) %>% 
  clean_names() #this transforms the column names into lower-snake-case

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

#---export cleaned datasets into the outputs folder---
write_csv(bq1, here("outputs", "bq1_clean.csv"))
write_csv(bq2, here("outputs", "bq2_clean.csv"))
write_csv(bq3, here("outputs", "bq3_clean.csv"))
write_csv(mpr, here("outputs", "mpr_clean.csv"))


