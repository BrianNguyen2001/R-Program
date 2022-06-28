library(tidyverse) #for dataframe manipulation
library(ggplot2) #for plotting
library(forcats) #for handling factors
library(scales) #for axis scale formatting
library(readr)

# barplot is used for discrete variable, 
# and histagramplot is used for continous variable

acs = read.csv('acs.csv')
str(acs)
names(acs)

unique(acs$female)
unique(acs$edu)

# Arrange the levels of the dataframe.
# 1st way
acs$edu <- as.factor(acs$edu)
acs$edu <- fct_relevel(acs$edu,
                       "Less than High School",
                       "High School",
                       "Some College",
                       "Bachelors",
                       "Advanced Degree")

# 2nd way
acs$edu = factor(acs$edu, levels = c("Less than High School",
                                     "High School",
                                     "Some College",
                                     "Bachelors",
                                     "Advanced Degree"), ordered = T)

acs$female = factor(acs$female)
levels(acs$edu)
levels(acs$female)

set.seed(123)
acs_sample = acs[sample(1:nrow(acs), 300), ] %>%
  filter(!is.na(edu), !is.na(income))
acs_sample

# To want to fill, we must tranfer it into factor
ggplot(acs, aes(x = edu,fill = female)) + # fill colors for values in aes
  geom_bar()

ggplot(acs, aes(x = edu)) +
  geom_bar(fill = 'blue')

ggplot(acs, aes(x = edu,fill = female)) +
  stat_count()

ggplot(acs, aes(x = edu,fill = edu)) + # fill colors for values in aes
  geom_bar() +
  geom_hline(yintercept = 2500, color='red',size = 1)


acs %>%
  filter(!is.na(edu)) %>%
  ggplot(aes(x = edu,fill = female)) +
  geom_bar() +
  coord_flip()

# 3.2. Continuous variable
# 3.2.1. Histograms
ggplot(acs, aes(x = age)) +
  geom_histogram()

ggplot(acs, aes(x = age)) +
  geom_histogram(binwidth = 5,fill = 'red', color = 'white')

# 3.2.2. Density plot
ggplot(acs, aes(x = age)) +
  geom_density()

ggplot(acs, aes(x = age)) +
  geom_density(adjust = .5, fill = 'pink', color = 'red')

# PLOT TWO VARIABLES
# One discrete variable, one continuous variable
# Barplots

# geom_bar() : count

acs %>%
  filter(!is.na(edu)) %>%
  group_by(edu) %>%
  summarize(income = mean(income, na.rm = T)) %>%
  ggplot(aes(x = edu, y = income)) +
  # geom_bar(stat = 'identity') + 
  geom_col() + # default stat is indentity
  geom_text(aes(label = round(income,1)),vjust = -0.5)

acs %>%
  filter(!is.na(edu)) %>%
  group_by(edu) %>%
  summarize(income = mean(income, na.rm = T)) %>%
  ggplot(aes(x = edu, y = income)) +
  geom_bar(stat = "identity") +
  geom_col() +
  coord_flip() +
  geom_text(aes(label = round(income)),hjust = -0.1)

acs %>%
  filter(!is.na(edu)) %>%
  group_by(edu) %>%
  summarize(income = mean(income, na.rm = T)) %>%
  ggplot(aes(x = edu, y = income)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  geom_text(aes(label = round(income)),hjust = -.2) +
  ylim(c(0, 75000))

# Boxplots
acs %>%
  filter(!is.na(edu), !is.na(income)) %>%
  ggplot(aes(x = edu, y = income)) +
  geom_boxplot() +
  coord_flip()

# Two continuous variables
# Scatter plot
ggplot(acs, aes(x = age, y = income)) +
  geom_point()

ggplot(acs, aes(x = age, y = income)) +
  geom_point(size = .5)

# Two discrete variables
# Barplots
ggplot(acs, aes(x = race, fill = edu)) + #race + edu: 2 discrete variables
  geom_bar(position = "dodge")

ggplot(acs, aes(x = race, fill = edu)) +
  geom_bar(position = "stack")

ggplot(acs, aes(x = race, fill = edu)) +
  geom_bar(position = "fill")

acs %>%
  group_by(race, edu) %>%
  summarize(n = n()) %>%
  mutate(perc = 100*n/sum(n))

acs %>%
  group_by(race, edu) %>%
  summarize(n = n()) %>%
  mutate(perc = 100*n/sum(n)) %>%
  ggplot(aes(x = race, y = perc)) +
  geom_bar(stat = "identity")

acs %>%
  group_by(race, edu) %>%
  summarize(n = n()) %>%
  mutate(perc = 100*n/sum(n)) %>%
  ggplot(aes(x = race, y = perc)) +
  geom_bar(stat = "identity") +
  facet_grid(~ edu) +
  coord_flip()

acs %>%
  group_by(race, edu) %>%
  summarize(n = n()) %>%
  mutate(perc = 100*n/sum(n)) %>%
  ggplot(aes(x = race, y = perc)) +
  geom_bar(stat = "identity") +
  facet_grid(~ edu) +
  coord_flip() +
  ylim(c(0, 90)) +
  geom_text(aes(label = round(perc, 1)), hjust = -.1)

# Add color
acs %>%
  filter(!is.na(edu)) %>%
  group_by(race, edu) %>%
  summarize(n = n()) %>%
  mutate(perc = 100*n/sum(n)) %>%
  ggplot(aes(x = race, y = perc, fill = edu)) +
  geom_bar(stat = "identity") +
  facet_grid(~ edu) +
  coord_flip() +
  ylim(c(0, 90)) +
  geom_text(aes(label = round(perc, 1)), hjust = -.1)

# Remove the not-so-needed legend
acs %>%
  filter(!is.na(edu)) %>%
  group_by(race, edu) %>%
  summarize(n = n()) %>%
  mutate(perc = 100*n/sum(n)) %>%
  ggplot(aes(x = race, y = perc, fill = edu)) +
  geom_bar(stat = "identity", show.legend = F) + #to remove legend
  facet_grid(~ edu) +
  coord_flip() +
  ylim(c(0, 90)) +
  geom_text(aes(label = round(perc, 1)), hjust = -.1)



ggplot(acs_sample, aes(x = age, y= income)) +
  geom_point() +
  facet_wrap(~edu, nrow =1)


# facet_grid(row~col)
ggplot(acs_sample, aes(x = age, y= income)) +
  geom_point() +
  facet_grid(edu~female)


female.label = c('0' = 'male', '1' = 'female')
ggplot(acs_sample, aes(x = age, y= income)) +
  geom_point() +
  facet_grid(female~edu, labeller = labeller(female = female.label))


ggplot(acs_sample, aes(x = age, y= income)) +
  geom_point() +
  facet_grid(female~edu, labeller = labeller(female = label_both, edu = label_value))


ggplot(acs_sample, aes(x = age, y= income)) +
  geom_point() +
  scale_color_manual(values = c('0' = 'seagreen3', '1' = 'red2'))


ggplot(acs_sample, aes(x = age, y = income,
                       shape = as.factor(female))) +
  geom_point() +
  labs(title = "Income by Age, Sex, and Education",
       caption = "Random sample of\nACS Dataset",
       x = "Age",
       y = "Income (in US Dollars)",
       shape = "Sex") +
  facet_wrap(~ edu) +
  scale_shape_discrete(labels = c("Male", "Female"))


ggplot(acs_sample, aes(x = age, y = income,
                       color = as.factor(female))) +
  geom_point() +
  labs(title = "Income by Age, Sex, and Education",
       caption = "Random sample of\nACS Dataset",
       x = "Age",
       y = "Income (in US Dollars)",
       color='gender') +
  facet_wrap(~ edu) +
  scale_color_discrete(labels = c("Male", "Female"))


ggplot(acs_sample, aes(x = age, y = income,
                       shape = as.factor(female))) +
  geom_point() +
  labs(title = "Income by Age, Sex, and Education",
       caption = "Random sample of\nACS Dataset",
       x = "Age",
       y = "Income (in US Dollars)",
       shape = "Sex") +
  facet_wrap(~ edu) +
  scale_shape_discrete(labels = c("Male", "Female")) +
  theme(axis.title.x = element_text(size = 10, face = "italic"),
        axis.title.y = element_text(size = 25, face = "bold"),
        axis.text.y = element_text(angle = 20),
        legend.position = "bottom",
        plot.title = element_text(angle = 15, vjust = .2)) +
  scale_x_continuous(breaks = seq(0, 100, 20))
