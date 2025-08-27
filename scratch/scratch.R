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


# Grouping by chemical 
BQ1_chemicals <- BQ1 %>%
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

BQ2_chemicals <- BQ2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

BQ3_chemicals <- BQ2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

MPR_chemicals <- MPR %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)


#create function for moving average

moving_average <- function(focal_date, dates, conc, win_size_wks) {
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






#Combine dataframes into new dataset 
streams <- rbind(BQ1_chemicals, BQ2_chemicals, BQ3_chemicals, MPR_chemicals)

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









