###############################################################################
### 						Data Structures 								###
### 1. What are the three properties of a vector, other than its contents? 	###
### 2. What are the four common types of atomic vectors? What are the two	###
### rare types?																###
### 3. What are attributes? How do you get them and set them?				###
### 4. How is a list different from an atomic vector? How is a matrix 		###
### different from a data frame?											###
### 5. Can you have a list that is a matrix? Can a data frame have a 		###
### column that is a matrix?												###
###############################################################################

##########################
## 		vectors			##
##########################

diff(1) == 0  ### returns an empty logical, which cannot be used in an "if" statement

c() ## returns NULL


##########################
## 		lists			##
##########################

### lists are great for apply statements
dts <- data.frame(date_hash = seq(as.Date("2016-01-01"), as.Date("2017-01-01"), by = "week")))
dts$month <- month(dts$date_hash)
dts$year <- year(dts$date_hash)

monthly_dts <- do.call(rbind, lapply(split(dts, dts$year), function(yy){
	do.call(rbind, lapply(split(yy, yy$month), function(mm){
		head(mm[order(mm$date_hash, decreasing = FALSE), ], 1)	
		}))
	}))


##########################
## 		attributes		##
##########################
# great for maps

weapons <- c("sam" = "sword",
            "frodo" = "sword",
            "frodo" = "Galadrial's light",
            "legolas" = "bow",
            "legolas" = "long knives",
            "gimli" = "axes",
            "aragorn" = "sword",
            "aragorn" = "bow", 
            "aragorn" = "knives",
            "aragorn" = "spears",
            "elladan" = "sword",
            "elrohir" = "sword",
            "gandalf" = "magic",
            "theoden" = "sword")

weaponsdf <- data.frame(name = names(weapons), weapons = weapons)

lotr_characters <- unique(names(weapons))
character_type_map <- c("hobbit", "hobbit", "elf", "dwarf", "human", "elf", "elf", "wizard", "human")
names(character_type_map) <- lotr_characters

weaponsdf$character_type <- character_type_map[weaponsdf$name]


##########################
## 		factors			##
##########################

### important for creating visualizations, especially in ggplot2




##########################
## 		matrices		##
##		arrays			##
##########################





##########################
## 		data frames		##
##########################







