#Read in data from streams
BQ1 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca1-Bisley.csv"))
BQ2 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca2-Bisley.csv"))
BQ3 <- read_csv(here::here("data", "stream-water-pr","QuebradaCuenca3-Bisley.csv"))
MPR <- read_csv(here::here("data", "stream-water-pr","RioMameyesPuenteRoto.csv"))      

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
