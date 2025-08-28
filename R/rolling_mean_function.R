#' Rolling mean function
#'The purpose of this function is to calculate the rolling mean based on 9 week intervals. 
#'Function use: In order to use this function use source("R/rolling_mean_function.R")
#' @param focal_date 
#' @param dates From "sample_date" column. 
#' @param conc This is the chemical/nutrient.
#' @param win_size_wks This is the 9 week moving time period. 
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
  result <- mean(window_conc)
  
  return(result)
}
