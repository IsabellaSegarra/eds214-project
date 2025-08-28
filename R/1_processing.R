#................Processing stream chemistry data................
#set up
    #clear global environment
rm(list=ls())

    #Load libraries
library(here)
library(janitor)
library(tidyverse)


#Read stream data 

BQ1 <- read_csv(here::here("data", 
                           "stream-water-pr",
                           "QuebradaCuenca1-Bisley.csv")) 

BQ2 <- read_csv(here::here("data", 
                           "stream-water-pr",
                           "QuebradaCuenca2-Bisley.csv"))

BQ3 <- read_csv(here::here("data", 
                           "stream-water-pr",
                           "QuebradaCuenca3-Bisley.csv"))

MPR <- read_csv(here::here("data", 
                           "stream-water-pr",
                           "RioMameyesPuenteRoto.csv")) 

#....Clean data....
BQ1 %>% 
  janitor::clean_names() 

