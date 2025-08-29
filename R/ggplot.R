#.............Plot of Stream Water Chemistry After Hurricane Hugo.............
# This R script is 
#---Source data---
  #source cleaned data
source(here("R", "1_clean_data.R"))
  #source processed data
source(here("R", "2_processing_data.R"))

#Plot
stream_chemistry_plot <- ggplot(data = rolling_avg, aes(x = sample_date, y = rolling_avg)) + 
  
  geom_line(aes(color = sample_id)) +
  
  facet_wrap(~chemical, scales = "free_y", nrow = 5) +
  #add line for hurricane Hugo disturbance 
  geom_vline(xintercept = as.Date("1989-09-18"), linetype = "dashed", color = "black") + 
  
  labs( x = "Years", 
        y = "Concentration", 
        title = "Hurricane Effects on Stream Chemistry") +
  theme_minimal() 

stream_chemistry_plot

#save plot in figs folder 

stream_chemistry_plot <- ggsave(plot = stream_chemistry_plot, here::here("figs", "stream_chemistry.png"))

  

