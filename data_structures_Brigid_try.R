<<<<<<< HEAD
#https://www.meetup.com/rladies-dc/events/239287719/?rv=ea1

#https://github.com/christinabrady/advanced_R_study_group

#http://adv-r.had.co.nz/Data-structures.html


###############################################################################
### 						Data Structures 								###
### 1. What are the three properties of a vector, other than its contents? 	###
###         length, type, attributes
### 2. What are the four common types of atomic vectors? What are the two	###
### rare types?	
##          double,integer, logical, character  rare-complex,raw															###
### 3. What are attributes? How do you get them and set them?		
###
### 4. How is a list different from an atomic vector?
###         Atomic vectors have elements of all same type, lists' elements can by different types
##How is a matrix different from a data frame?	
###         In same way matrix elements all the same types, data.frame columns can be different types
### 5. Can you have a list that is a matrix? 
###           A list can contain a matrix and a list can have matrix dimensions
###  Can a data frame have a column that is a matrix?		###  yes



### MY QUESTIONS
## How are type and class different in R?

## I cannot see why the following matrix calcs work
x1 <- array(1:5, c(1, 1, 5))##5 blocks, 1column, 1 row
x2 <- array(1:5, c(1, 5, 1))##1 block, 5 columns, 1 row
x3 <- array(1:5, c(5, 1, 1))### 5 rows,1 column, 1 block

#### hmm wonder if you can do the following
#### matrix calculation
x2%*%matrix(1:5,ncol=1)###yes

x3%*%matrix(1:5, ncol=1)##???

x1%*%matrix(1:5, ncol=1)###?? coerced?

## I am not sure of the answer to this
##Can you have a data frame with 0 rows? What about 0 columns?
###############################################################################

##########################
## 		vectors			##
##########################

## three attributes of an vector, length, type, and attributes
## I didn't know a list was a vector--it is !!
## an atomic vector has elements that are all the same type, a list can
## have different elements.


diff(1) == 0  ### returns an empty logical, which cannot be used in an "if" statement

c() ## returns NULL

### I hadn't met the command diff before
diff(c(1,2,4,10))
diff(1:10,2)
x<-cumsum(cumsum(1:10))
x
diff(x)
diff(x,lag=2)### ok I see 
diff(c(1,2,4,10),lag=1, differences=2)### I don't understand this, look at later

### 4 types of atmomic vectors
### I would have answered numeric (real, integer) ,character, logical
### Hadley breaks it up to double, integer, character and logical

#Atomic vectors are flat, they don't retain grouping structure in next line.
c(1, c(2, c(3, 4)))

### the rare types?...I only know/guess complex(i=sqrt(-1)) and Hadley says there
### is another type called raw--does not explain


###COERCION this is really important!!!--
###All elements of an atomic vector must be the same type,
## so when you attempt to combine different types they will be coerced to the most
##flexible type. Types from least to most flexible are:
## logical, integer, double, and character. 

### will check by doing exercises





##########################
## 		lists			##
##########################

x <- list(list(1, 2), c(3, 4))
y <- c(list(1, 2), c(3, 4))
str(x)
str(y)

### lists are great for apply statements
dts <- data.frame(date_hash = seq(as.Date("2016-01-01"), as.Date("2017-01-01"), by = "week"))

### date_hash is a vector of dates
is.atomic(dts$date_hash)##TRUE


#### I had to install and use the lubridate package for month, and year to work
install.packages("lubridate")
require(lubridate)
dts$month <- month(dts$date_hash)
dts$year <- year(dts$date_hash)

monthly_dts <- do.call(rbind, lapply(split(dts, dts$year), function(yy){
	do.call(rbind, lapply(split(yy, yy$month), function(mm){
		head(mm[order(mm$date_hash, decreasing = FALSE), ], 1)	
		}))
	}))

### whoa, this was a little too much for me. I broke it up
### I understand the use of split, and lapply and do.call but
### I wasn't sure how the nesting worked here
monthly_dts1<-do.call(rbind, lapply(split(dts,dts$year), function(yy){dim(yy)}))
is.atomic(monthly_dts1)
## the above just works on all the data since only one level of dts$year
monthly_dts2<-	do.call(rbind, lapply(split(dts, dts$month), function(mm){
  head(mm[order(mm$date_hash, decreasing = FALSE), ], 1)	
}))
#### so let me see what happens with just one element of list
test<-split(dts,dts$month)[[2]]
head(test[order(test$date_hash, decreasing=F),],1)
#### so just taking first observation in each element of list
#### then it seems that monthly_dts2 gives you mostly what you want
#### but with the full nested call you get useful rownames
rownames(monthly_dts)

###  Exercises
## 1,2 essentially answered above
### 3
c(1, FALSE)## coerced to numeric from logical
c("a", 1)## coerced to character
c(list(1), "a") ## coerced to two lists
c(TRUE, 1L)
typeof(c(TRUE,1L))### yes coerces to integer

###4. Why do you need to use unlist() to convert a list to an atomic vector? Why doesn’t as.vector() work?
###         A list is a type of vector
###5. Why is 1 == "1" true? Why is -1 < FALSE true? Why is "one" < 2 false?
###         In first case 1 is coerced to "1", in second case FALSE is coerced to
###         0 and in the third case 2 is coerced to "2" and character numbers
###         are considered to come before the alphabetic numbers

###6. Why is the default missing value, NA, a logical vector?
###         Because logical is least flexible so the NA will be coerced to the most
###         flexible type to agree correctly with the other elements



##########################
## 		attributes		##
##########################
# great for maps

attributes(weapons)
attributes(weaponsdf)


lotr_characters <- unique(names(weapons))
character_type_map <- c("hobbit", "hobbit", "elf", "dwarf", "human", "elf", "elf", "wizard", "human")
names(character_type_map) <- lotr_characters

weaponsdf$character_type <- character_type_map[weaponsdf$name]

### But I am intrigued by the ability to make up my own attributes!

x<-1:10
attr(x,"source")<-"http://adv-r.had.co.nz/Data-structures.html"
str(x)
attributes(x)
attributes(x)$source
attr(x,"source")  ### cool, useful


##########################
## 		factors			##
##########################

### important for creating visualizations, especially in ggplot2

z <- read.csv(text = "value\n12\n1\n.\n9")
### I was wondering why the . doesn't coerce everything to character but
### I guess the n keeps it an integer somehow..
typeof(z$value)
typeof(z) ### list??
sum(z[[1]],na.rm=TRUE) ### get error message  ‘sum’ not meaningful for factors
is.factor(z$value)## TRUE
levels(z$value)### [1] "."  "1"  "12" "9" 
as.double(as.character(z$value)) ### this is what I usually do
z <- read.csv(text = "value\n12\n1\n.\n9", na.strings=".") ## must remember this

### Exercises
### 1. 
print(structure(1:5, comment = "my attribute")) ## does not print comment
x<-1:5
attr(x,"comment")<-"my attribute"
print(x)
###### I don't know answer to this.
f1 <- c("a","a","b","b","b","c","c","c","c")
f1<-as.factor(f1)
levels(f1)
table(f1)
levels(f1) <- rev(levels(f1))
levels(f1)
## levels named c,b,a but c is aligned with value a,b with b, and a with value c
table(f1)
f2 <- rev(factor(f1))
f2  
## a is first level again but it is repeated 4 times
levels(f2)
table(f2)
f3 <- factor(f1, levels = rev(levels(f1)))
f3
table(f3)

#### I need to think and be careful about this!!

##########################
## 		matrices		##
##		arrays			##
##########################

c<-1:12
dim(c)<-c(3,4)
str(c)
is.matrix(c)### never made a matrix this way before

dim(c)<-c(2,3,2)
c
is.matrix(c)##FALSE
is.array(c)### TRUE
is.atomic(c)### TRUE
dimnames(c) <- list(c("one", "two"), c("a", "b", "c"), c("A", "B"))
c ### note the naming done inside to outside dimention
#### c[the rows, the columns, the blocks]
d<-1:12
dim(d)### Null
dim(c[1,1:3,1])##null
dim(matrix(1:3,nrow=1))## row vector
dim(matrix(1:12,nrow=3)[,4])##NULL?? I thought
### that would be a column vector
dim(matrix(1:12,nrow=12))### column matrix

l <- list(1:3, "a", TRUE, 1.0)
dim(l) <- c(2, 2)
l
## weird but I can see why it might be useful
l[1,1]

### Exercises
### 1. What does dim() return when applied to a vector
###     NULL
### 2. If is.matrix(x) is TRUE, what will is.array(x) return?
      a<-matrix(1:12, ncol=3)
      is.matrix(a)## TRUE
      is.array(a)## TRUE matrix is 2 dim array
      
#### 3. what makes following objects different from 1:5
      
      x1 <- array(1:5, c(1, 1, 5))##5 blocks, 1column, 1 row
      x2 <- array(1:5, c(1, 5, 1))##1 block, 5 columns, 1 row
      x3 <- array(1:5, c(5, 1, 1))### 5 rows,1 column, 1 block
      
      #### hmm wonder if you can do the following
      #### matrix calculation
      x2%*%matrix(1:5,ncol=1)###yes
      
      x3%*%matrix(1:5, ncol=1)##???
      
      x1%*%matrix(1:5, ncol=1)###?? coerced?
      
 

##########################
## 		data frames		##
##########################
      df <- data.frame(
        x = 1:3,
        y = c("a", "b", "c"),
        stringsAsFactors = FALSE)
      str(df)
 ## the next surprised me but makes sense
 ##  since a df is a list and lists can
 ##  contain lists   
      df <- data.frame(x = 1:3)
      df$y <- list(1:2, 1:3, 1:4)
      df  
      
      
      dfl <- data.frame(x = 1:3, y = I(list(1:2, 1:3, 1:4)))
      str(dfl)      
### I() AsIs
      dfl[2,"y"]
      dim(dfl[2,"y"])## NULL

### Exercises
####  1.attributes of matrix
      attributes(dfl)
### names, colnames row.names, class, dim, length
      
### What does as.matrix() do when applied to a data frame with columns of different types?
### It coerces to all columns to type of the column with most flexible type
### Can you have a data frame with 0 rows? What about 0 columns?
      
      a<-data.frame(matrix(1:3, nrow=0))
      a<-data.frame(matrix(NA, nrow=0))## no
      a<-matrix(NA, ncol=0)
      a<-matrix(NULL, ncol=0)
      a<-1:3
      dim(a)<-c(1,0)
###  I cannot see how to do it    




=======
#https://www.meetup.com/rladies-dc/events/239287719/?rv=ea1

#https://github.com/christinabrady/advanced_R_study_group

#http://adv-r.had.co.nz/Data-structures.html


###############################################################################
### 						Data Structures 								###
### 1. What are the three properties of a vector, other than its contents? 	###
###         length, type, attributes
### 2. What are the four common types of atomic vectors? What are the two	###
### rare types?	
##          double,integer, logical, character  rare-complex,raw															###
### 3. What are attributes? How do you get them and set them?		
###
### 4. How is a list different from an atomic vector?
###         Atomic vectors have elements of all same type, lists' elements can by different types
##How is a matrix different from a data frame?	
###         In same way matrix elements all the same types, data.frame columns can be different types
### 5. Can you have a list that is a matrix? 
###           A list can contain a matrix and a list can have matrix dimensions
###  Can a data frame have a column that is a matrix?		###  yes



### MY QUESTIONS
## How are type and class different in R?

## I cannot see why the following matrix calcs work
x1 <- array(1:5, c(1, 1, 5))##5 blocks, 1column, 1 row
x2 <- array(1:5, c(1, 5, 1))##1 block, 5 columns, 1 row
x3 <- array(1:5, c(5, 1, 1))### 5 rows,1 column, 1 block

#### hmm wonder if you can do the following
#### matrix calculation
x2%*%matrix(1:5,ncol=1)###yes

x3%*%matrix(1:5, ncol=1)##???

x1%*%matrix(1:5, ncol=1)###?? coerced?

## I am not sure of the answer to this
##Can you have a data frame with 0 rows? What about 0 columns?
###############################################################################

##########################
## 		vectors			##
##########################

## three attributes of an vector, length, type, and attributes
## I didn't know a list was a vector--it is !!
## an atomic vector has elements that are all the same type, a list can
## have different elements.


diff(1) == 0  ### returns an empty logical, which cannot be used in an "if" statement

c() ## returns NULL

### I hadn't met the command diff before
diff(c(1,2,4,10))
diff(1:10,2)
x<-cumsum(cumsum(1:10))
x
diff(x)
diff(x,lag=2)### ok I see 
diff(c(1,2,4,10),lag=1, differences=2)### I don't understand this, look at later

### 4 types of atmomic vectors
### I would have answered numeric (real, integer) ,character, logical
### Hadley breaks it up to double, integer, character and logical

#Atomic vectors are flat, they don't retain grouping structure in next line.
c(1, c(2, c(3, 4)))

### the rare types?...I only know/guess complex(i=sqrt(-1)) and Hadley says there
### is another type called raw--does not explain


###COERCION this is really important!!!--
###All elements of an atomic vector must be the same type,
## so when you attempt to combine different types they will be coerced to the most
##flexible type. Types from least to most flexible are:
## logical, integer, double, and character. 

### will check by doing exercises





##########################
## 		lists			##
##########################

x <- list(list(1, 2), c(3, 4))
y <- c(list(1, 2), c(3, 4))
str(x)
str(y)

### lists are great for apply statements
dts <- data.frame(date_hash = seq(as.Date("2016-01-01"), as.Date("2017-01-01"), by = "week"))

### date_hash is a vector of dates
is.atomic(dts$date_hash)##TRUE


#### I had to install and use the lubridate package for month, and year to work
install.packages("lubridate")
require(lubridate)
dts$month <- month(dts$date_hash)
dts$year <- year(dts$date_hash)

monthly_dts <- do.call(rbind, lapply(split(dts, dts$year), function(yy){
	do.call(rbind, lapply(split(yy, yy$month), function(mm){
		head(mm[order(mm$date_hash, decreasing = FALSE), ], 1)	
		}))
	}))

### whoa, this was a little too much for me. I broke it up
### I understand the use of split, and lapply and do.call but
### I wasn't sure how the nesting worked here
monthly_dts1<-do.call(rbind, lapply(split(dts,dts$year), function(yy){dim(yy)}))
is.atomic(monthly_dts1)
## the above just works on all the data since only one level of dts$year
monthly_dts2<-	do.call(rbind, lapply(split(dts, dts$month), function(mm){
  head(mm[order(mm$date_hash, decreasing = FALSE), ], 1)	
}))
#### so let me see what happens with just one element of list
test<-split(dts,dts$month)[[2]]
head(test[order(test$date_hash, decreasing=F),],1)
#### so just taking first observation in each element of list
#### then it seems that monthly_dts2 gives you mostly what you want
#### but with the full nested call you get useful rownames
rownames(monthly_dts)

###  Exercises
## 1,2 essentially answered above
### 3
c(1, FALSE)## coerced to numeric from logical
c("a", 1)## coerced to character
c(list(1), "a") ## coerced to two lists
c(TRUE, 1L)
typeof(c(TRUE,1L))### yes coerces to integer

###4. Why do you need to use unlist() to convert a list to an atomic vector? Why doesn’t as.vector() work?
###         A list is a type of vector
###5. Why is 1 == "1" true? Why is -1 < FALSE true? Why is "one" < 2 false?
###         In first case 1 is coerced to "1", in second case FALSE is coerced to
###         0 and in the third case 2 is coerced to "2" and character numbers
###         are considered to come before the alphabetic numbers

###6. Why is the default missing value, NA, a logical vector?
###         Because logical is least flexible so the NA will be coerced to the most
###         flexible type to agree correctly with the other elements



##########################
## 		attributes		##
##########################
# great for maps

attributes(weapons)
attributes(weaponsdf)


lotr_characters <- unique(names(weapons))
character_type_map <- c("hobbit", "hobbit", "elf", "dwarf", "human", "elf", "elf", "wizard", "human")
names(character_type_map) <- lotr_characters

weaponsdf$character_type <- character_type_map[weaponsdf$name]

### But I am intrigued by the ability to make up my own attributes!

x<-1:10
attr(x,"source")<-"http://adv-r.had.co.nz/Data-structures.html"
str(x)
attributes(x)
attributes(x)$source
attr(x,"source")  ### cool, useful


##########################
## 		factors			##
##########################

### important for creating visualizations, especially in ggplot2

z <- read.csv(text = "value\n12\n1\n.\n9")
### I was wondering why the . doesn't coerce everything to character but
### I guess the n keeps it an integer somehow..
typeof(z$value)
typeof(z) ### list??
sum(z[[1]],na.rm=TRUE) ### get error message  ‘sum’ not meaningful for factors
is.factor(z$value)## TRUE
levels(z$value)### [1] "."  "1"  "12" "9" 
as.double(as.character(z$value)) ### this is what I usually do
z <- read.csv(text = "value\n12\n1\n.\n9", na.strings=".") ## must remember this

### Exercises
### 1. 
print(structure(1:5, comment = "my attribute")) ## does not print comment
x<-1:5
attr(x,"comment")<-"my attribute"
print(x)
###### I don't know answer to this.
f1 <- c("a","a","b","b","b","c","c","c","c")
f1<-as.factor(f1)
levels(f1)
table(f1)
levels(f1) <- rev(levels(f1))
levels(f1)
## levels named c,b,a but c is aligned with value a,b with b, and a with value c
table(f1)
f2 <- rev(factor(f1))
f2  
## a is first level again but it is repeated 4 times
levels(f2)
table(f2)
f3 <- factor(f1, levels = rev(levels(f1)))
f3
table(f3)

#### I need to think and be careful about this!!

##########################
## 		matrices		##
##		arrays			##
##########################

c<-1:12
dim(c)<-c(3,4)
str(c)
is.matrix(c)### never made a matrix this way before

dim(c)<-c(2,3,2)
c
is.matrix(c)##FALSE
is.array(c)### TRUE
is.atomic(c)### TRUE
dimnames(c) <- list(c("one", "two"), c("a", "b", "c"), c("A", "B"))
c ### note the naming done inside to outside dimention
#### c[the rows, the columns, the blocks]
d<-1:12
dim(d)### Null
dim(c[1,1:3,1])##null
dim(matrix(1:3,nrow=1))## row vector
dim(matrix(1:12,nrow=3)[,4])##NULL?? I thought
### that would be a column vector
dim(matrix(1:12,nrow=12))### column matrix

l <- list(1:3, "a", TRUE, 1.0)
dim(l) <- c(2, 2)
l
## weird but I can see why it might be useful
l[1,1]

### Exercises
### 1. What does dim() return when applied to a vector
###     NULL
### 2. If is.matrix(x) is TRUE, what will is.array(x) return?
      a<-matrix(1:12, ncol=3)
      is.matrix(a)## TRUE
      is.array(a)## TRUE matrix is 2 dim array
      
#### 3. what makes following objects different from 1:5
      
      x1 <- array(1:5, c(1, 1, 5))##5 blocks, 1column, 1 row
      x2 <- array(1:5, c(1, 5, 1))##1 block, 5 columns, 1 row
      x3 <- array(1:5, c(5, 1, 1))### 5 rows,1 column, 1 block
      
      #### hmm wonder if you can do the following
      #### matrix calculation
      x2%*%matrix(1:5,ncol=1)###yes
      
      x3%*%matrix(1:5, ncol=1)##???
      
      x1%*%matrix(1:5, ncol=1)###?? coerced?
      
 

##########################
## 		data frames		##
##########################
      df <- data.frame(
        x = 1:3,
        y = c("a", "b", "c"),
        stringsAsFactors = FALSE)
      str(df)
 ## the next surprised me but makes sense
 ##  since a df is a list and lists can
 ##  contain lists   
      df <- data.frame(x = 1:3)
      df$y <- list(1:2, 1:3, 1:4)
      df  
      
      
      dfl <- data.frame(x = 1:3, y = I(list(1:2, 1:3, 1:4)))
      str(dfl)      
### I() AsIs
      dfl[2,"y"]
      dim(dfl[2,"y"])## NULL

### Exercises
####  1.attributes of matrix
      attributes(dfl)
### names, colnames row.names, class, dim, length
      
### What does as.matrix() do when applied to a data frame with columns of different types?
### It coerces to all columns to type of the column with most flexible type
### Can you have a data frame with 0 rows? What about 0 columns?
      
      a<-data.frame(matrix(1:3, nrow=0))
      a<-data.frame(matrix(NA, nrow=0))## no
      a<-matrix(NA, ncol=0)
      a<-matrix(NULL, ncol=0)
      a<-1:3
      dim(a)<-c(1,0)
###  I cannot see how to do it    




>>>>>>> 49b4be3255db1dc21d3ff631e620486590684adb
