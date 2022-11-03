assignment_1
================
2022-10-31

# Assignment 1 by Mengyang Guo

### Setup

Here, I load the necessary package

``` r
suppressPackageStartupMessages(library(datateachr)) 
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(broom))
suppressPackageStartupMessages(library(palmerpenguins))
suppressPackageStartupMessages(library(testthat))
suppressPackageStartupMessages(library(digest))
```

### Exercise 1: Make a Function

In this exercise, I make a function to scale the dataset by median value
in each category. I would like to make this function because I repeated
this process for many, many times for the data analysis in STAT 545A. So
I’m consider making a function for this action. Below are some features
of the function:

- The input is df (the dataset) and category (based on which I calculate
  the median for each category).

- Before start, the function checks whether the input is a data frame or
  not. Next, it cleans the data in the following 3 steps

- First, it calculates the median value for each category (e.g.,
  gender).

- Second, it scales all the numeric variables in the dataset by each
  variable’s median number in each category. For example, the weight of
  a female student is 65kg. Given the cauculated median female student
  weight of 60kg, I calculate the student’s scaled weight to be
  (65-60)/60, which is 0.083. This means that she is 8.3% overweight
  relative to the median female weight.

- Third, I drop all the missing values.

- The output of this function is the cleaned dataset.

See the code below:

``` r
scale_by_median <- function(df,category)
{
#put category enquo
category <- enquo(category)

#give a warning if df is not a dataset 
if(!is.data.frame(df)){
    stop('I am so sorry, but this function only works for data frame input!\n',
         'You have provided an object of class: ', class(df)[1])
}

#Cleaning the dataset following the previously mentioned 3 steps
df %>%
  group_by(!!category) %>%
 mutate(across(where(is.numeric), ~ (.x-median(.x,na.rm=TRUE))/median(.x,na.rm=TRUE)))%>%
  drop_na () -> scaled_data

#returns cleaned dataset
  return(scaled_data)
}
```

### Exercise 2: Document the function

In this exercise, I will document my function using [roxygen2
tags](https://roxygen2.r-lib.org/articles/rd-formatting.html)

``` r
#'@title A function to scale each observation
#'@description This function scales all of its numeric variables. Specifically, I scale each observation the median number in the category.
#'@param df Dataframe(I use df as the abbreviation of data frame)
#'@param category Categorial variable (based on which I cauculate the median for each group)
#'@return the funtion returns the scaled dataset based on input \code{df} and \code{category}

scale_by_median <- function(df,category)
{
#put category enquo
category <- enquo(category)

#give a warning if df is not a dataset 
if(!is.data.frame(df)){
    stop('I am so sorry, but this function only works for data frame input!\n',
         'You have provided an object of class: ', class(df)[1])
}

#Cleaning the dataset following the previously mentioned 3 steps
df %>%
  group_by(!!category) %>%
 mutate(across(where(is.numeric), ~ (.x-median(.x,na.rm=TRUE))/median(.x,na.rm=TRUE)))%>%
  drop_na () -> scaled_data

#returns cleaned dataset
  return(scaled_data)
}
```

### Exercise 3: Include Examples

In the first example, I scale the penguins dataset. I only use the first
five columns to illustrate (because it makes sense to scale these
numeric variables, rather than some other numeric ones). The output data
looks good to me. All the numeric variables are scaled.

``` r
penguins[1:5]->penguins_subsample

# I scale each observation by the median number in its species.

scale_by_median(penguins_subsample,species)
```

    ## # A tibble: 342 × 5
    ## # Groups:   species [3]
    ##    species island    bill_length_mm bill_depth_mm flipper_length_mm
    ##    <fct>   <fct>              <dbl>         <dbl>             <dbl>
    ##  1 Adelie  Torgersen        0.00773        0.0163           -0.0474
    ##  2 Adelie  Torgersen        0.0180        -0.0543           -0.0211
    ##  3 Adelie  Torgersen        0.0387        -0.0217            0.0263
    ##  4 Adelie  Torgersen       -0.0541         0.0489            0.0158
    ##  5 Adelie  Torgersen        0.0129         0.120             0     
    ##  6 Adelie  Torgersen        0.00258       -0.0326           -0.0474
    ##  7 Adelie  Torgersen        0.0103         0.0652            0.0263
    ##  8 Adelie  Torgersen       -0.121         -0.0163            0.0158
    ##  9 Adelie  Torgersen        0.0825         0.0978            0     
    ## 10 Adelie  Torgersen       -0.0258        -0.0707           -0.0211
    ## # … with 332 more rows

In the second example, I scale the cancer dataset. I only use the 2-6
columns to illustrate (because the first column is the numeric cancer ID
and it doesn’t make sense to scale the cancer ID). The output data looks
good to me. All the numeric variables are scaled.

``` r
datateachr::cancer_sample[2:6]->cancer_subsample


# I scale each observation by the median number in its diagnosis.

scale_by_median(cancer_subsample,diagnosis)
```

    ## # A tibble: 569 × 5
    ## # Groups:   diagnosis [2]
    ##    diagnosis radius_mean texture_mean perimeter_mean area_mean
    ##    <chr>           <dbl>        <dbl>          <dbl>     <dbl>
    ##  1 M              0.0384     -0.516           0.0753    0.0740
    ##  2 M              0.187      -0.172           0.164     0.423 
    ##  3 M              0.137      -0.00979         0.138     0.291 
    ##  4 M             -0.341      -0.0503         -0.321    -0.586 
    ##  5 M              0.171      -0.332           0.183     0.392 
    ##  6 M             -0.281      -0.268          -0.277    -0.488 
    ##  7 M              0.0534     -0.0690          0.0473    0.116 
    ##  8 M             -0.209      -0.0294         -0.210    -0.380 
    ##  9 M             -0.250       0.0168         -0.234    -0.442 
    ## 10 M             -0.281       0.120          -0.265    -0.489 
    ## # … with 559 more rows

In the third example, ***I intentionally show error!*** I show that this
dataset stop working if the input is not a data frame. It successfully
alters me that “*I am so sorry, but this function only works for data
frame input!, You have provided an object of class: character*”

``` r
# I will first define a string variable
string_variable<-"adfs"

# I use it as input
scale_by_median(string_variable,diagnosis)
```

    ## Error in scale_by_median(string_variable, diagnosis): I am so sorry, but this function only works for data frame input!
    ## You have provided an object of class: character

``` r
## I succefully find error!
```

***I intentionally showed this error!***

### 

### Exercise 4: Test the Function

I will test three things using the cancer data:

- I test whether the calculated values on row ten is accurate.

- I test whether the total number of rows is correct

- I test whether I have successfully dropped all the missing values

  I will first calculate the values on row ten and the total number of
  rows

``` r
# I run the code without using functions to cauculate the row ten numbers

cancer_subsample %>%
  group_by(diagnosis) %>%
 mutate(across(where(is.numeric), ~ (.x-median(.x,na.rm=TRUE))/median(.x,na.rm=TRUE)))%>%
  drop_na () -> scaled
  digest(unname(as.matrix(scaled)[10,]))
```

    ## [1] "24948aec6fc35f41a44b2fb6d2d8b61c"

``` r
# I run the code to get the total number of rows 
  
nrow(scaled)
```

    ## [1] 569

The following output suggest that the row 10 should be
“24948aec6fc35f41a44b2fb6d2d8b61c” and I should have 569 rows.

**I formally test it below:**

``` r
test_that("Testing my function", {
    expect_equal(digest(unname(as.matrix(scale_by_median(cancer_subsample,diagnosis))[10,])),  "24948aec6fc35f41a44b2fb6d2d8b61c")
    expect_equal(nrow(scale_by_median(cancer_subsample,diagnosis)),  569)
    expect_false(any(is.na(scale_by_median(cancer_subsample,diagnosis))))
})
```

    ## Test passed 🎉

**The test was passed!**
