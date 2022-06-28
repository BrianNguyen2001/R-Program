############################## Data types ##############################

# Logical type
data_types_1 <- TRUE
typeof(data_types_1)

# Numeric Double type
data_types_2 <- 23.5
typeof(data_types_2)

# Numeric Integer type
data_types_3 <- 2L
typeof(data_types_3)

# Character type
data_types_4 <- c('a' , 'good', 'TRUE', '23.4')
typeof(data_types_4)

############################## Objects ############################## 

# Create vector with more than one element
vector_1 = c('abc', TRUE, 12.5, 63)
vector_2 = 5:13
vector_3 = 6.6:12.6
vector_4 = 3.8:11.4
vector_5 = seq(5, 10, by = 0.2)


check = c(FALSE, 1)
check

# Check if vector
is.vector(vector_1)
is.vector(vector_2)
is.vector(vector_3)
is.vector(vector_4)
is.vector(vector_5)

# Add two vector
vec=c(1,2,3)
vic=c(11,12,13)
add_vector = vec + vic
add_vector

# Vector recycling
vetor_recycling_1 = c(3,8,4,5,0,11)
vetor_recycling_2 = c(4,11)
add_result = vetor_recycling_1+vetor_recycling_2
sub_result = vetor_recycling_1-vetor_recycling_2

# To add or minus two vector having different dim, the shorter one will 
# duplicate elements to fix the length of longer vector
cat('Add two vector having diff length:', add_result)

cat('Sub two vector having diff length:', sub_result)

# Vector Element Sorting
random_vector = c(3,8,4,5,0,11, -9, 304) 
sorted_vector = sort(random_vector)
sorted_vector_reseverse = sort(random_vector, decreasing = TRUE)

cat('Vector after sorting:', sorted_vector) # from small to big

cat('Vector after reseverse sorting:', sorted_vector_reseverse) # from big to small

############################## Vector Attributes ############################## 
vector_6 = c(6:10)

# Check attributes, names, and dimensions
attributes(vector_6)
names(vector_6)
dim(vector_6)

# Set name for elements
name.vector_6 = c('a','b','c','d','e')
# Give elements of deck a name
names(vector_6) = name.vector_6
vector_6

############################## Vector indexing & Slicing ##############################

# Indexing:
vector_6[3] # Get the index 3th in the list
vector_6[-3] # Get all of the index but expect the 3th index in the list
vector_6[c(1,3,4)] # Get the specifically index which user choose.
vector_6['a'] # Get the index have name "a" in the list

# Slicing:
vector_6[2:4] # Get index from 2nd to 4th in list
vector_6[-(2:4)] # Ignore index from 2nd to 4th in list
vector_6[vector_6>=8] # Print out the indexes that meet the input conditions

############################## Dimension of vector ##############################

# dim(vector)<-c(n,m): turn a vector into a two-dimensional object (a matrix with n rows and m columns)
# matrix(data,byrow=T,.) to order the elements row by row

dimesion_vector = seq(10,100, by= 10)
dim(dimesion_vector) # => NULL
dim(dimesion_vector) = c(5,2)

dimesion_vector

# Create a vertical matrix (axis = 1)
matrix(dimesion_vector, nrow = 2)
# Create a horizontal matrix (axis = 0)
matrix(dimesion_vector, nrow = 2, byrow = T)

############################## Create a list ##############################

# A list is an R-object which can contain many different types of elements inside it
# To create a list, use list()

# Create a list.
list_1 = list(2,0,2,2,20.22)
list_1

list_2 = list(c(2,0,2,2),20.22)
list_2

# Set name for list
list_3 = list(nameone=c(2,0,2,2),nametwo=20.22)
list_3

############################## Indexing a list ##############################
# Retrieve a list slice with the single square bracket "[]" operator
# To reference a list member directly, use the double square bracket "[[]]" operator

list_3[1]

list_3$'nameone'

list_3['nameone']

# Adding element from list with a number, we use "[[]]"
list_3[['nameone']] + 1000

# Slicing the list
list_4 = list(nameone=c(2,0,2,0),
              nametwo=c(2,0,2,1),
              namethree=c(2,0,2,2),
              namefour=c(2,0,2,3))

list_4[2:3]


list_4[[1]][2:3]
list_4[['nameone']][2:3]

############################## Matrices ##############################
# Vector + dimension => matrix
# A matrix is a 2-dimensional rectangular data set that can be created using vectors.
# A matrix can contain only one basic data type

# To create a matrix: matrix(data=,nrow=,ncol=,byrow=TRUE)
# To create a matrix having name: matrix(data=..., nrow=(number), ncol=(number), byrow= T, dimnames= listt(c(...),c(...)))
# To add rows => rbind(), add columns => cbind()
# To transpose a matrix => t(object)

matrix_1 = matrix(dimesion_vector)
matrix_1 # Have only 1 column

matrix_2 = matrix(dimesion_vector, nrow = 2, ncol = 5, byrow = FALSE) # byrow is default
matrix_2

matrix_3 = matrix(dimesion_vector, nrow = 2, ncol = 5, byrow = TRUE) # byrow = T
matrix_3

# Add more rows for matrix
matrix_4 = rbind(matrix_3, c(110,120,130,140,150))
matrix_4
# To transpose a matrix
t(matrix_4)

############################## Row names & Column names ##############################

# Set name for row and col
rownames(matrix_4) = c(2020:2022)
colnames(matrix_4) = c('a','b','c','d','e')
matrix_4

# Set name for row and col by dimnames.
matrix_5 = matrix(seq(10,150, by=10),nrow = 3, ncol = 5, byrow = T,
                  dimnames = list(c(2020:2022),
                                  c('a','b','c','d','e')))
matrix_5

############################## Subsetting/Indexing/Slicing a matrix ############################## 

matrix_6 = matrix(c(1:16), nrow = 8, ncol = 2, byrow = T, 
                  dimnames = list(c('a','b','c','d','e','f','g','h'),
                                  c('USA','World')))
matrix_6

# Indexing a matrix
matrix_6[3,2]  # (row 3rd, col 2nd)
matrix_6[3,-1] # (row 3rd, col 2nd)

# return a matrix from row 1st to row 3rd
matrix_6[1:3,1:2] 
matrix_6[c(1,2,3),] 

# Entire rows or columns
matrix_6[6,] # entire 6th row
matrix_6[,2] # entire 2nd column

# Retrieve by names of col or row
matrix_6['b',] # retrieve by using a row name
matrix_6[c('b','h'),] # retrieve by using row names
matrix_6[,'USA'] # retrieve by using col names

############################## Matrix arithmetics ############################## 

matrix_revenue = matrix(c(1:6), nrow = 3, ncol = 2, byrow = T, 
                        dimnames = list(c('a','b','c'), 
                                        c('usa','world')))
matrix_revenue

# Rescale the value in the matrix (e.g., divide all elements by 1000)
revenue.scaled = matrix_revenue*1000
revenue.scaled

#matrix * matrix
budget = matrix(c(63,150,150),nrow=3,ncol=2) #R recycle vector budget
profit_1 = revenue.scaled-budget
profit_2 = revenue.scaled-c(63,150,150) #same result, R recycle vector
profit_1
profit_2


breakfast = c(1,2,3)
lunch = c(4,5,6)
x = rbind(breakfast, lunch)

shop1 = c(50,100,200)
shop2 = c(40,80,120)
y = cbind(shop1, shop2)

x
y 
# Vector (2,3) time vector (3,2) => Vector (2,2) we use " %*% "
x%*%y 

############################## Matrix arithmetics ############################## 

# colSums(data): return the sum of each column
# rowSums(data): return the sum of each row
# colMeans(data): return the mean of each column
# rowMeans(data): return the mean of each row

matrix_revenue
rowSums(matrix_revenue) # Calculate sum of each row (1+2=3, 3+4=7, 5+6=11)
colSums(matrix_revenue) # Calculate sum of each col (1+3+5=9, 2+4+6=12)
total = colSums(matrix_revenue)
colMeans(matrix_revenue) # Calculate mean of each col ([1+3+5]/3=3, [2+4+6]/3=4)
average = colMeans(matrix_revenue)

matrix_revenue.new= rbind(matrix_revenue,total,average)
matrix_revenue.new

############################## Factors ############################## 
# - Factors are vectors of labels.
# - The labels are always character regardless whether it is numeric or character or Boolean, etc..
# - Factors: norminal and ordinal data
# - Factors are created using the factor(). The nlevels functions gives the count of levels

colors = c('green','green','yellow','red','red','red','green')

colors

typeof(colors)

nlevels(colors)

factor_color = factor(colors)

factor_color

typeof(factor_color)

nlevels(factor_color)


marital = c('m','m','s','d','w','d')
str(marital)

fator_marital = factor(marital)
fator_marital

str(fator_marital)

typeof(fator_marital)

#factor(data=,levels=) #levels=set the order
new.factor=factor(marital,levels=c('s','m','d','w'))
new.factor
str(new.factor)

new.factor=factor(marital,
                  levels=c('s','m','d','w'),
                  labels=c('sing','mar','div','wid'))

new.factor

#factors as ordinal data
ordered.factor=factor(marital,ordered=T,
                      levels=c('s','m','d','w'))
ordered.factor



############################## Factors in Data Frame ############################## 
# In a data frame, R treats the text column as categorical data and automatically creates factors on it.

# Create the vectors for data frame.
height = c(132,151,162,139,166,147,122)
weight = c(48,49,66,53,67,52,40)
gender = c("male","male","female","female","male","female","male")

input_data = data.frame(height,weight,gender)

input_data

is.factor(input_data$gender)

input_data$gender

