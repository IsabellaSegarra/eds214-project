BQ1_chemicals <- BQ1 %>%
  select(sample_date, k, no3_n, mg, ca, nh4_n)

BQ2_chemicals <- BQ2 %>% 
  select(sample_date, k, no3_n, mg, ca, nh4_n)

BQ3_chemicals <- BQ2 %>% 
  select(sample_date, k, no3_n, mg, ca, nh4_n)

MPR_chemicals <- MPR %>% 
  select(sample_date, k, no3_n, mg, ca, nh4_n) 