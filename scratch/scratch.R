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
  win_size_wks = 10
)




#Combine dataframes into new dataset ###
streams <- rbind(sample_id,BQ1_chemicals, BQ2_chemicals, BQ3_chemicals, MPR_chemicals)

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

---
    
{
      #3. Apply function by each stream data frame. 
      
      #---BQ1---
      #Ca
      BQ1_chemicals$bq1_ca <- sapply(
        BQ1_chemicals$sample_date,
        rolling_mean,
        dates = BQ1_chemicals$sample_date,
        conc = BQ1_chemicals$ca,
        win_size_wks = 9
      )
      #Mg
      BQ1_chemicals$bq1_mg <- sapply(
        BQ1_chemicals$sample_date,
        rolling_mean,
        dates = BQ1_chemicals$sample_date,
        conc = BQ1_chemicals$mg,
        win_size_wks = 9
      )
      #k
      BQ1_chemicals$bq1_k <- sapply(
        BQ1_chemicals$sample_date,
        rolling_mean,
        dates = BQ1_chemicals$sample_date,
        conc = BQ1_chemicals$k,
        win_size_wks = 9
      )
      #no3_n
      BQ1_chemicals$bq1_no3_n <- sapply(
        BQ1_chemicals$sample_date,
        rolling_mean,
        dates = BQ1_chemicals$sample_date,
        conc = BQ1_chemicals$no3_n,
        win_size_wks = 9
      )
      
      #nh4_n
      BQ1_chemicals$bq1_nh4_n <- sapply(
        BQ1_chemicals$sample_date,
        rolling_mean,
        dates = BQ1_chemicals$sample_date,
        conc = BQ1_chemicals$nh4_n,
        win_size_wks = 9
      )
      #---BQ2---
      
      #Ca
      BQ2_chemicals$bq2_ca <- sapply(
        BQ2_chemicals$sample_date,
        rolling_mean,
        dates = BQ2_chemicals$sample_date,
        conc = BQ2_chemicals$ca,
        win_size_wks = 9
      )
      #Mg
      BQ2_chemicals$bq2_mg <- sapply(
        BQ2_chemicals$sample_date,
        rolling_mean,
        dates = BQ2_chemicals$sample_date,
        conc = BQ2_chemicals$mg,
        win_size_wks = 9
      )
      #k
      BQ2_chemicals$bq2_k <- sapply(
        BQ2_chemicals$sample_date,
        rolling_mean,
        dates = BQ2_chemicals$sample_date,
        conc = BQ2_chemicals$k,
        win_size_wks = 9
      )
      #no3_n
      BQ2_chemicals$bq2_no3_n <- sapply(
        BQ2_chemicals$sample_date,
        rolling_mean,
        dates = BQ2_chemicals$sample_date,
        conc = BQ2_chemicals$no3_n,
        win_size_wks = 9
      )
      
      #nh4_n
      BQ2_chemicals$bq2_nh4_n <- sapply(
        BQ2_chemicals$sample_date,
        rolling_mean,
        dates = BQ2_chemicals$sample_date,
        conc = BQ2_chemicals$nh4_n,
        win_size_wks = 9
      )
      
      #---BQ3---
      #Ca
      BQ3_chemicals$bq3_ca <- sapply(
        BQ3_chemicals$sample_date,
        rolling_mean,
        dates = BQ3_chemicals$sample_date,
        conc = BQ3_chemicals$ca,
        win_size_wks = 9
      )
      #Mg
      BQ3_chemicals$bq3_mg <- sapply(
        BQ3_chemicals$sample_date,
        rolling_mean,
        dates = BQ3_chemicals$sample_date,
        conc = BQ3_chemicals$mg,
        win_size_wks = 9
      )
      #k
      BQ3_chemicals$bq3_k <- sapply(
        BQ3_chemicals$sample_date,
        rolling_mean,
        dates = BQ3_chemicals$sample_date,
        conc = BQ3_chemicals$k,
        win_size_wks = 9
      )
      #no3_n
      BQ3_chemicals$bq3_no3_n <- sapply(
        BQ3_chemicals$sample_date,
        rolling_mean,
        dates = BQ3_chemicals$sample_date,
        conc = BQ3_chemicals$no3_n,
        win_size_wks = 9
      )
      
      #nh4_n
      BQ3_chemicals$bq3_nh4_n <- sapply(
        BQ3_chemicals$sample_date,
        rolling_mean,
        dates = BQ3_chemicals$sample_date,
        conc = BQ3_chemicals$nh4_n,
        win_size_wks = 9
      )
      #---MPR---
      #Ca
      MPR_chemicals$mpr_ca <- sapply(
        MPR_chemicals$sample_date,
        rolling_mean,
        dates = MPR_chemicals$sample_date,
        conc = MPR_chemicals$ca,
        win_size_wks = 9
      )
      #Mg
      MPR_chemicals$mpr_mg <- sapply(
        MPR_chemicals$sample_date,
        rolling_mean,
        dates = MPR_chemicals$sample_date,
        conc = MPR_chemicals$mg,
        win_size_wks = 9
      )
      #k
      MPR_chemicals$mpr_k <- sapply(
        MPR_chemicals$sample_date,
        rolling_mean,
        dates = MPR_chemicals$sample_date,
        conc = MPR_chemicals$k,
        win_size_wks = 9
      )
      #no3_n
      MPR_chemicals$mpr_no3_n <- sapply(
        MPR_chemicals$sample_date,
        rolling_mean,
        dates = MPR_chemicals$sample_date,
        conc = MPR_chemicals$no3_n,
        win_size_wks = 9
      )
      
      #nh4_n
      MPR_chemicals$mpr_nh4_n <- sapply(
        MPR_chemicals$sample_date,
        rolling_mean,
        dates = MPR_chemicals$sample_date,
        conc = MPR_chemicals$nh4_n,
        win_size_wks = 9
      )
      
      #4. Put rolling average data into new data frames
      #---BQ1---
      BQ1_rolling <- BQ1_chemicals %>% 
        select(sample_date, bq1_ca, bq1_mg, bq1_k, bq1_no3_n, bq1_nh4_n)
      
      #---BQ2--
      BQ2_rolling <- BQ2_chemicals %>% 
        select(sample_date, bq2_ca, bq2_mg, bq2_k, bq2_no3_n, bq2_nh4_n)
      
      #---BQ3#---
      BQ3_rolling <- BQ3_chemicals %>% 
        select(sample_date, bq3_ca, bq3_mg, bq3_k, bq3_no3_n, bq3_nh4_n)
      #---MPR---
      MPR_rolling <- MPR_chemicals %>% 
        select(sample_date, mpr_ca, mpr_mg, mpr_k, mpr_no3_n, mpr_nh4_n)
      
      #5. Combine rolling data frames into one frame. This data frame will have columns sample date and columns for each stream's chemical. 
      
      streams_join <- full_join(BQ1_rolling,BQ2_rolling) 
      streams_join2 <- full_join(BQ3_rolling, MPR_rolling)
      stream_chemistry <- full_join(streams_join, streams_join2)
      
      
      
      #6. Plot data
      
      #6a. Plot the Potassium(k) data from all streams. 
      
      ggplot(data = stream_chemistry, aes(x = sample_date, y = bq1_ca))+
        geom_line()
      
      ggplot(data = stream_chemistry, aes( x = sample_date, y = col=variable)) + 
        geom_point() + 
        stat_smooth() +
        facet_wrap(~variable)
      
      #6b. Plot the No3_n data from all streams. 
      #6c. Plot the Mg data from all streams.
      #6d. Plot the Ca data from all streams.
      #6e. Plot the Nh4_n data from all streams. 
    }
  







