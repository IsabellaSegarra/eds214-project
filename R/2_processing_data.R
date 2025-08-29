#................Processing stream chemistry data................
# In this R script I processed the data further by filtering, combining dataframes and applying the rolling mean function. 

#---set up---
  #clear global environment
rm(list=ls())

  #Load relevant libraries  
library(tidyverse) 
library(dplyr) 
library(kableExtra)

  #Source cleaned data
source(here("R", "1_clean_data.R"))

#---Further process data---

  #Source function
source(here("R", "rolling_mean_function.R"))

  # Filter data by only relevant chemicals/nutrients in the study (k, no3_n, mg, ca, nh4_n). 

bq1_chemicals <- bq1 %>%
  select(sample_id,sample_date, k, no3_n, mg, ca, nh4_n)  

bq2_chemicals <- bq2 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

bq3_chemicals <- bq3 %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)

mpr_chemicals <- mpr %>% 
  select(sample_id, sample_date, k, no3_n, mg, ca, nh4_n)


  # Combine data frames into a dataset called "streams". 
streams <- rbind(bq1_chemicals, bq2_chemicals, bq3_chemicals, mpr_chemicals) 

  # Filter stream data to reflect the study time frame from 1988 to 1994. 
streams <- streams %>% 
  filter((sample_date >= "1988-01-10" & sample_date < "1994-07-31"))

  # Pivot dataset from wider to longer. 
streams_longer <- streams %>%  
  pivot_longer(cols = c(k, mg, ca, nh4_n, no3_n), names_to = "chemical", 
               values_to = "chem_conc") 

#---Apply function to create rolling mean function---

rolling_avg <- #Store as new data frame called "rolling_avg"
  streams_longer %>% 
  group_by(sample_id, chemical) %>% #Group dataframe by sample_id and chemical
  mutate(rolling_avg = sapply(sample_date, rolling_mean, dates = sample_date, conc = chem_conc, win_size_wks = 9)) #create new column with the 

#Make KableExtra table
streams_data_table <- rolling_avg %>% 
kable(col.names = c("sample ID", "date", "chemical", "chemical concentration", 
                    "rolling average")) %>% 
  kable_styling(bootstrap_options = "striped", full_width = FALSE) %>%
kable_classic() %>%
  scroll_box(height = "300px", width = "700px")

  #View table
streams_data_table 


#---export datasets and tables---
  #export streams_longer dataset
write_csv(streams_longer, here("outputs", "streams.csv"))

  #export rolling_avg dataset
write_csv(rolling_avg, here("outputs", "rolling_avg.csv"))

  #export table 
write.table(streams_data_table, here("outputs", "streams.RDS"))

