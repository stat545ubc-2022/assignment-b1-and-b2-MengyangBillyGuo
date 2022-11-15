
<!-- README.md is generated from README.Rmd. Please edit that file -->

# scaling function

<!-- badges: start -->
<!-- badges: end -->

The goal of scale_by_median is to scales all the numeric variables in
the dataset by each variable’s median number in each category. It
achieves three goals: 1) check if the input is a dataset 2) scales all
the numeric variables in the dataset by each variable’s median number in
each category, 3) delete missing values.

## Installation

You can install the development version of scale_by_median from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("stat545ubc-2022/assignment-b1-and-b2-MengyangBillyGuo")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
## Load the package
library(scaling)

## I use mtcars as example.

## The following code shows the distance and horse power numbers fully scaled by median number for each cylinder category. 
scale_by_median(mtcars,mtcars$cyl)[3:4]
#> # A tibble: 14 × 2
#>       disp      hp
#>      <dbl>   <dbl>
#>  1 -0.0453  0     
#>  2 -0.0453  0     
#>  3  0       0.0220
#>  4  0.358  -0.319 
#>  5  0.304   0.0440
#>  6 -0.271  -0.275 
#>  7 -0.299  -0.429 
#>  8 -0.342  -0.286 
#>  9  0.112   0.0659
#> 10 -0.269  -0.275 
#> 11  0.114   0     
#> 12 -0.119   0.242 
#> 13 -0.135   0.591 
#> 14  0.120   0.198

## Zeros means they are the median numbers.
```
