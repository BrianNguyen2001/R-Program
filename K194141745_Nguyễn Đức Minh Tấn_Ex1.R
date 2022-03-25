############################## Exercise_1 ##############################

# Input information
product = 'meat'
price = 100

# Create Data Frame
Exercise_1 = data.frame(
  Category = c("A","B","C"),
  Item.1 = c('book','vegetable', 'shirt'),
  Item.2 = c('magazine','meat', 'jean'),
  Item.3 = c('newspaper','beverage', 'pant'),
  Tax = c(0.08, 0.1, 0.2),
  stringsAsFactors = FALSE)
Exercise_1

# Logical 
for (i in seq(1, nrow(Exercise_1))) {
  for (j in seq( 2, ncol(Exercise_1) - 1)) {
    if (product == Exercise_1[i,j]) {
      
      kind = Exercise_1[i,1]
      interest_rate = Exercise_1[i,5]
      price_at = as.integer(price*(1+interest_rate))
      
      print(paste('The',product,'belong to',kind,
                  '. The tax rate is',interest_rate,
                  '. The price after tax is',price_at))
      break
    }
  }
}

############################## Exercise_2 ##############################

# Import library
library(tidyverse)

# Input information for Data Frame
Month = seq(1,12)
Revenue = c(150,120,140,160,90,95,145,175,190,200,180,185)
Expense = round(Revenue * (2/3),2)

# Create Data Frame
Exercise_2 = data.frame(
  Month,
  Revenue,
  Expense
)

# Print Data Frame
Exercise_2

# Calculate profit before tax = revenue - expense
Profit.before.tax = Revenue - Expense
Profit.before.tax

# Calculate tax liability
Tax.rate = c()

for (p in seq(1:length(Profit.before.tax))){
  if (Profit.before.tax[p] < 30){
    Tax.rate[p] = 0
  } else if (Profit.before.tax[p]>=30 & Profit.before.tax[p]<=60) {
    Tax.rate[p] = 0.1
  } else {
    Tax.rate[p] = 0.2
  }
}

Tax.liability = round((Profit.before.tax*Tax.rate),2)
# Tax.liability = as.integer(Tax.liability)
Tax.liability 

# Calculate profit after tax
Profit.after.tax = round((Profit.before.tax - Tax.liability),2)
Profit.after.tax 

# Generate a table for better readability of the revenue, expense, tax, profit before tax, profit after tax
Exercise_2 = data.frame(Exercise_2, Profit.before.tax, Tax.liability, Profit.after.tax)
Exercise_2

mean(Profit.before.tax)

# Find month(s) that has(have) profit before tax > mean of monthly profit 
print('The month(s) that has(have) profit before tax > mean of monthly profit.')
Exercise_2 %>% filter(Profit.before.tax > mean(Profit.before.tax)) %>% 
  select(Month,Profit.before.tax)

# Find month(s) that has(have) profit before tax < mean of monthly profit 
print('The month(s) that has(have) profit before tax < mean of monthly profit.')
Exercise_2 %>% filter(Profit.before.tax < mean(Profit.before.tax)) %>% 
  select(Month,Profit.before.tax)


