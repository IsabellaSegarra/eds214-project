#' Rolling mean function
#'The purpose of this function is to calculate the rolling mean based on 9 week intervals. 
#'Function use: In order to use this function use source("R/rolling_mean_function.R")
#' @param focal_date The date where you are determining the averages. 
#' @param dates The dates of the study. 
#' @param conc The nutrients (K, Mg, Ca, NH4-N, NO3-N).
#' @param win_size_wks Schaefer et al. 2000 plotted the data in 9 week moving time. This is the window size in weeks that we are pulling the data from. 
#'
#' @returns
#' @export
#'
#' @examples

rolling_mean <- function(focal_date, dates, conc, win_size_wks) {
  
  # Which dates are in the window of 9 weeks? 
  #turn dates into vector
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) & #divide 9 weeks by 2 and multiply by 7 to turn into days 
    
    (dates < focal_date + (win_size_wks / 2) * 7)
  
  # Find the associated concentrations
  
  window_conc <- conc[is_in_window]
  
  # Calculate the mean
  result <- mean(window_conc, na.rm = TRUE) #remove NA's from dataset 
  
  return(result)
}
