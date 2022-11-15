#' @title scaling
#' @description This function scales all of its numeric variables. Specifically, I scale each observation the median number in the category.
#' @param df Dataframe(I use df as the abbreviation of data frame)
#' @param category Categorial variable (based on which I cauculate the median for each group)
#' @return the funtion returns the scaled dataset based on input \code{df} and \code{category}
#' @examples
#' scale_by_median(mtcars,mtcars$cyl)
#' @export
scale_by_median <- function(df,category)
{
  #put category enquo
  category <- rlang::enquo(category)

  #give a warning if df is not a dataset
  if(!is.data.frame(df)){
    stop('I am so sorry, but this function only works for data frame input!\n',
         'You have provided an object of class: ', class(df)[1])
  }

  #Cleaning the dataset following the previously mentioned 3 steps
  df %>%
    dplyr::group_by(!!category) %>%
    dplyr::mutate(dplyr::across(tidyselect::vars_select_helpers$where(is.numeric), ~ (.x-median(.x,na.rm=TRUE))/median(.x,na.rm=TRUE))) %>%
    tidyr::drop_na ()   -> scaled_data

  #returns cleaned dataset
  return(scaled_data)
}
