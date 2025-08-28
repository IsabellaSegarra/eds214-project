#................Processing stream chemistry data................
  #set up
    #clear global environment
rm(list=ls())

    #Load libraries
library(here)
library(janitor)
library(tidyverse)
library(ggplot2)
library(lubridate)


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



#Read in data from Bisley and 
BQ1 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca1-Bisley.csv"))
BQ2 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca2-Bisley.csv"))
BQ3 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca3-Bisley.csv"))
MPR <- read_csv(here::here("data", "stream-water-pr","RioMameyesPuenteRoto.csv"))      


# Grouping by chemical 
BQ1_chemicals2 <- BQ1 %>%
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

BQ2_chemicals <- BQ2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

BQ3_chemicals <- BQ2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

MPR_chemicals <- MPR %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)


#create function for moving average

rolling_mean <- function(focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window?
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc)
  
  return(result)
}

#test function with BQ1_chemicals 

moving_average(focal_date = as.Date("1986-05-20"),
                             dates = BQ1_chemicals$sample_date,
                             conc = BQ1_chemicals$ca,
                             win_size_wks = 9)

#Apply function to all of BQ1 chemicals
BQ1_chemicals$rolling_avg <- sapply(
  BQ1_chemicals$sample_date,
  moving_average,
  dates = BQ1_chemicals$sample_date,
  conc = BQ1_chemicals$ca,
  win_size_wks = 9
)

ggplot(data = BQ1_chemicals, aes(x = ))

#Call function
source("R/rolling_mean_function.R")

#Apply function again

rolling_mean(focal_date = as.Date("1986-05-20"),
               dates = BQ1_chemicals$sample_date,
               conc = BQ1_chemicals$ca,
               win_size_wks = 9)



  


#Combine dataframes into new dataset 
streams <- rbind(BQ1_chemicals2, BQ2_chemicals, BQ3_chemicals, MPR_chemicals)

streams_long <- streams %>%  
  pivot_longer(cols = "sample_id", 
               names_to = 'sample_id', 
               values_to = 'tilapia_volume_kpounds') 

#--- end of tidy code---



#figure out moving time, 9 week moving time 

#take out week from year

streams_2 <- streams_2 %>% 
  mutate(week = lubridate::week(sample_date))

i<- streams_2$week
for (i) in ncol(k) {
  if(week <= 9) {
    else(summarise())
  }
}

if (condition) {
  # Code to execute if the condition is TRUE
} else {
  # Optional: Code to execute if the condition is FALSE

  
  function_name <- function(argument1, argument2, ...) {
    # Code before the loop (optional)
    
    for (variable in sequence) {
      # Code to be executed in each iteration
      # 'variable' takes on the value of each element in 'sequence'
    }
    
    # Code after the loop (optional)
    return(result) # Return a value if desired
  }









