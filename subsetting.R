###############################################################################
###                 						Subsetting       								            ###
### 1. What is the result of subsetting a vector with positive integers,    ###
###    negative integers, a logical vector, or a character vector? 	        ###
### 2. What’s the difference between [, [[, and $ when applied to a list? 	###
### 3. When should you use drop = FALSE?                            				###
### 4. If x is a matrix, what does x[] <- 0 do?                             ###
###    How is it different to x <- 0? 		                                  ###
### 5. How can you use a named vector to relabel categorical variables? 		###
###############################################################################

##########################
## 		data types   			##
##########################

### Exercises ###

## 1. Fix each of the following common data frame subsetting errors:

    mtcars[mtcars$cyl = 4, ]
    mtcars[-1:4, ]
    mtcars[mtcars$cyl <= 5]
    mtcars[mtcars$cyl == 4 | 6, ]

## 2. Why does x <- 1:5; x[NA] yield five missing values? (Hint: why is it different from x[NA_real_]?)

## 3. What does upper.tri() return? How does subsetting a matrix with it work? Do we need any additional subsetting rules to describe its behaviour?

    x <- outer(1:5, 1:5, FUN = "*")
    x[upper.tri(x)]

## 4. Why does mtcars[1:20] return an error? How does it differ from the similar mtcars[1:20, ]?

## 5. Implement your own function that extracts the diagonal entries from a matrix (it should behave like diag(x) where x is a matrix).

## 6. What does df[is.na(df)] <- 0 do? How does it work?

## Questions ###



##########################
## subsetting operators ##
##########################

### Exercises ###
## Given a linear model, e.g., mod <- lm(mpg ~ wt, data = mtcars),
## extract the residual degrees of freedom. Extract the R squared from the model summary (summary(mod))

## Questions ###

##########################
## subsetting and       ##
## assignment           ##
##########################



##########################
##     applications     ##
##########################

### Exercises ###
## 1. How would you randomly permute the columns of a data frame?
## (This is an important technique in random forests.)
## Can you simultaneously permute the rows and columns in one step?


## 2. How would you select a random sample of m rows from a data frame?
## What if the sample had to be contiguous (i.e., with an initial row, a final row, and every row in between)?

## 3. How could you put the columns in a data frame in alphabetical order?
