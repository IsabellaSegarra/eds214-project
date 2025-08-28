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



#Read in data from streams
BQ1 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca1-Bisley.csv"))
BQ2 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca2-Bisley.csv"))
BQ3 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca3-Bisley.csv"))
MPR <- read_csv(here::here("data", "stream-water-pr","RioMameyesPuenteRoto.csv"))      


# Grouping by chemical 
BQ1_chemicals <- BQ1 %>%
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

BQ2_chemicals <- BQ2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

BQ3_chemicals <- BQ2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

MPR_chemicals <- MPR %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

#-------
#Group by chemical in each stream 
  #BQ1 stream 
BQ1_k <- BQ1 %>% 
  select(sample_date, k)

BQ1_ca <- BQ1 %>% 
  select(sample_date, ca)

BQ1_mg <- BQ1 %>% 
  select(sample_date, mg)

BQ1_no3n <- BQ1 %>% 
  select(sample_date,no3_n)

BQ1_nh4_n <- BQ1 %>% 
  select(sample_date, nh4_n)

#Apply function for 
rolling_mean(focal_date = as.Date("1986-05-20"),
               dates = BQ1_k$sample_date,
               conc = BQ1_k$k,
               win_size_wks = 9)

BQ1_k$rolling_avg <- sapply(
  BQ1_k$sample_date,
  rolling_mean,
  dates = BQ1_k$sample_date,
  conc = BQ1_k$k,
  win_size_wks = 9
)

# plot just Bq1_k 

ggplot(data = BQ1_k, aes(x = sample_date, y = rolling_avg))+
  geom_line()

#-------------------------------

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

#Apply function to all of BQ1 chemicals and add new column 
  #Ca
BQ1_chemicals$rolling_avg_ca <- sapply(
  BQ1_chemicals$sample_date,
  rolling_mean,
  dates = BQ1_chemicals$sample_date,
  conc = BQ1_chemicals$ca,
  win_size_wks = 9
)
  #Mg
BQ1_chemicals$rolling_avg_mg <- sapply(
  BQ1_chemicals$sample_date,
  rolling_mean,
  dates = BQ1_chemicals$sample_date,
  conc = BQ1_chemicals$mg,
  win_size_wks = 9
)

  #k
BQ1_chemicals$rolling_avg_k <- sapply(
  BQ1_chemicals$sample_date,
  rolling_mean,
  dates = BQ1_chemicals$sample_date,
  conc = BQ1_chemicals$k,
  win_size_wks = 9
)

  #no3_n
BQ1_chemicals$rolling_avg_no3_n <- sapply(
  BQ1_chemicals$sample_date,
  rolling_mean,
  dates = BQ1_chemicals$sample_date,
  conc = BQ1_chemicals$no3_n,
  win_size_wks = 9
)

  #nh4_n
BQ1_chemicals$rolling_avg_nh4_n <- sapply(
  BQ1_chemicals$sample_date,
  rolling_mean,
  dates = BQ1_chemicals$sample_date,
  conc = BQ1_chemicals$nh4_n,
  win_size_wks = 9
)

BQ1_rolling <- BQ1_chemicals %>% 
  select(sample_date, rolling_avg_ca, rolling_avg_mg, rolling_avg_k, rolling_avg_no3_n, rolling_avg_nh4_n)


#Plot 

#Call function
source("R/moving_averages_function.R")

#Apply function again

moving_average(focal_date = as.Date("1986-05-20"),
               dates = BQ1_chemicals$sample_date,
               conc = BQ1_chemicals$ca,
               win_size_wks = 9)


BQ2_chemicals$rolling_avg <- sapply(
  BQ2_chemicals$sample_date,
  rolling_mean,
  dates = BQ2_chemicals$sample_date,
  conc = BQ2_chemicals$ca,
  win_size_wks = 9
)




#Combine dataframes into new dataset ###
streams <- rbind(BQ1_chemicals, BQ2_chemicals, BQ3_chemicals, MPR_chemicals)

streams_longer <- streams %>%  
  pivot_longer(names_from = ,
              values_from = )

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









