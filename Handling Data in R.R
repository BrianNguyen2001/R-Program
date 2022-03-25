###############################  Import Library ############################### 
library(readr)
library(readxl)
library(tidyverse)

############################## Read csv files ##############################  

# Read from working directory
    # df = read.csv("path")

StudentPerformance = read.csv("StudentPerformance.csv")
View(StudentPerformance)

# Read from the internet.
    # path = '...'
    # df = read.csv(path)

path='https://raw.githubusercontent.com/BrianNguyen2001/CAPM-Model-MSN-stock/main/Data_MSN.csv'
df=read.csv(path)
View(df)

# Use context menu in Rstudio
df_trim=read_csv("StudentPerformance.csv", trim_ws = FALSE) #trim_ws (trim the white space)
View(df_trim)
# Read from Excel
    # df = read_excel(PATH, sheet=, range=)

df_1 = read_excel('StudentPerformance.xlsx')
View(df_1)

# Read from context menu.
StudentPerformance1 = read_excel("StudentPerformance.xlsx", na = "0", n_max = 10)
View(StudentPerformance1)

# Select a range in the Excel
read_excel("StudentPerformance.xlsx", range = "A1:F10")
read_excel("StudentPerformance.xlsx",range=cell_rows(1:10))


#cell_rows (select range of rows)
#cell_cols(select range of columns)
read_excel('StudentPerformance.xlsx',range=cell_rows(1:10))
read_excel('StudentPerformance.xlsx',range=cell_cols(1:5))
read_excel('StudentPerformance.xlsx',range=cell_cols('C:D'))
read_excel('StudentPerformance.xlsx',range=cell_cols(2))

############################## Import from a clipboard ############################## 

df.clip= read.delim('clipboard',header=F,skip=2)
View(df.clip)

# Set names for the variables
names=c('date','tong klgd','tong gtgd', 'von hoa tt', 'dongcua', 'thaydoigia',
        'thaydoigia_prc', 'khoplenh_kl', 'khoplenh_gt')

names(df.clip)=names
View(df.clip)

############################## Tidy data ############################## 

# Tibble is a more modern version of data frame
car.tib=as_tibble(mtcars) #convert to tibble
car.tib
cars.df=as.data.frame(car.tib)
print(cars.tib,n=15,width=Inf) #print all columns


######################## Tidy data ######################## 


wide_pop=read.csv('wide_population.csv')
colnames(wide_pop) = c('Sate','2018','2019','2020')
View(wide_pop)

# Tranfer the columns (2018,2019,2020) into new column named "year" by value of "population".
# pivot_longer
# gather
tidy_pop = pivot_longer(wide_pop, c('2018','2019','2020'),
                        names_to = 'year',
                        values_to='population')
View(tidy_pop)

long_pop = gather(wide_pop, c('2018','2019','2020'),
                            key='year',
                            value='population')
View(long_pop)


######################## long format (not tidy data) ######################## 

long_states = read.csv('long_population.csv')
View(long_states)
# There are 3 variable on a columns, we need to split it.

# Get three elements on the "condition" column and split it into 03 columns.
tidy_states = pivot_wider(long_states,
                          names_from = 'condition',
                          values_from='measure')
View(tidy_states)

tidystatespread= spread(long_states,
                        key='condition',
                        value = 'measure')
View(tidystatespread)

######################## Separate and unite data ######################## 
# Separate data
state_rate=read_csv('state_rate.csv')
View(state_rate)

# separate(df, columns want to split, into = c('columns 1','columns 2', sep = ''))
tidy_rate=separate(state_rate,rate,into=c('death','population'),sep = '/')
View(tidy_rate)

# Unite data
# unite(df,columns need to concatenate,columns 1, columns 2, sep='')
untidy_rate=unite(tidy_rate,rate,death,population,sep='/')
View(untidy_rate)


staff = data.frame(
    name = c("Megan", "Amy", "Jen", "Karl", "Jeremy","Ken","Henry"),
    gender = c("female", "female", "female", "male", "male", "male", "male"),
    sale = c(5, 7, 6, 2, 1,4,8),
    expense = c(3, 4, 3.5, 2, 1.5, 3, 5)
)

staff

# Arrange function
staff %>% arrange(name)
# Nghich dao
staff %>% arrange(desc(name))

staff %>% arrange(name,sale)

# Select function: choose the columns
staff %>% select(name, sale)

staff %>% select(-gender) %>% 
    filter(sale >4) %>% 
    filter(expense >3.0)

staff %>% select(-gender) %>% 
  filter(sale >4 & expense >3.0) 

staff %>% 
    select(sale,expense, name, gender) 

# Filter function: choose the row is suitable with the conditions.
staff %>%  
    select(sale, expense, everything()) %>% 
    filter(gender == 'female') %>% 
    filter(sale > 5)

# And and Or function
staff %>%  
    select(sale, expense, everything()) %>% 
    filter(gender == 'female' & sale > 5)

staff %>%  
    select(sale, expense, everything()) %>% 
    filter(gender == 'female' | sale > 5)

# In function
staff %>% 
    filter(sale %in% c(2,4,6,8))

# Groupby function.
staff %>% 
    group_by(gender) %>% 
    filter(max(expense) >3) # expense of female is  4 and male is 2. So female is satificated

staff %>% 
    group_by(gender) %>% 
    filter(n()<3) # n(): count number of observations

staff %>% 
    group_by(expense) %>% 
    filter(n()==1) # n(): count number of observations

# Mutate function: create a new col and add into the dataframe
staff %>% 
    mutate(sale.expense = sale/expense) -> staff

staff %>% 
  mutate(sale.geater.3 = sale >3)

staff %>% 
  mutate(insurance = 1) -> staff

# Mutate function: only create a new col.
staff %>% 
    transmute(sale.expense = sale/expense)

# new variable = ifelse(condition, True value, False value)
staff %>% 
  mutate(insurance = ifelse(sale>5, insurance+0.5,insurance)) 

staff %>% 
  mutate(expense_denmeaned = expense - mean(expense)) 

staff %>% 
  mutate(estimate = ifelse(sale.expense>mean(sale.expense),'good','not good')) 

# Create two new columns at the same time
staff %>% 
  mutate(bonus = 0, sale.insurance = sale/insurance)

staff %>% 
  group_by(gender) %>% 
  summarise(mean_expense=mean(expense), meadian_expense = median(expense))


staff %>% 
  group_by(gender) %>% 
  summarise(first.sale = first(sale),
            last.sale = last(sale), 
            min.sale = min(sale),
            max.sale = max(sale),
            std.sale = sd(sale))

# Khử trung bình
staff %>% 
  group_by(gender) %>% 
  mutate(expense_denmeaned_gender = expense-mean(expense)) 

staff %>% 
  group_by(gender) %>% 
  summarise(count = n())


staff %>% 
  group_by(gender) %>% 
  summarise()


slice_min(mtcars,mpg,prop=0.25)
slice_max(mtcars,mpg,prop=0.25)
slice_max(mtcars,mpg,n=5)
slice_head(mtcars, n= 5)
slice_tail(mtcars, n= 5)

staff %>% 
  slice_max(sale, n=2)

staff %>% 
  group_by(gender) %>% 
  slice_max(sale, n=1)




































































