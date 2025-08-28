#' Rolling mean function
#'The purpose of this function is to calculate the rolling mean based on 9 week intervals. 
#'Function use: In order to use this function use source("R/rolling_mean_function.R")
#' @param focal_date 
#' @param dates 
#' @param conc 
#' @param win_size_wks 
#'
#' @returns
#' @export
#'
#' @examples
rolling_mean <- function(focal_date, dates, conc, win_size_wks) {
  # Which dates are in the window of 9 weeks? 
  is_in_window <- (dates > focal_date - (win_size_wks / 2) * 7) &
    (dates < focal_date + (win_size_wks / 2) * 7)
  # Find the associated concentrations
  window_conc <- conc[is_in_window]
  # Calculate the mean
  result <- mean(window_conc)
  
  return(result)
}
