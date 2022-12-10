# import data
gapminder <- read.csv("https://raw.githubusercontent.com/resbaz/r-novice-gapminder-files/master/data/gapminder-FiveYearData.csv")

summary(gapminder)

# load the package
library(dplyr)

# 1. filter() : Pick observations with filter()
#Logical operators allow us to compare things. Here are some of the most important ones:

# ==: equal
# !=: different or not equal
# >: greater than
# <: smaller than
# >=: greater or equal
# <=: smaller or equal

# EX
austria <- filter(gapminder, country == "Austria")

allDataFrom2000 <- filter(gapminder, year >= 2000)


# 2. arrange: Reorder observations
arrange(gapminder, gdpPercap)
arrange(gapminder, desc(gdpPercap))
head(arrange(gapminder, desc(gdpPercap)))



# 3. select: pick var
gap_small <- select(gapminder, year, country, gdpPercap)

# example TODO same thing with diff ways in code
gap_small_97_ex1 <- filter(gap_small, year == 1997)

gap_small_97_ex2 <- filter(select(gapminder, year, country, gdpPercap),
                           year == 1997)

gap_small_97_ex3 <- gapminder %>%
  select(year, country, gdpPercap)  %>%
  filter(year == 1997)


# Select the 2002 life expectancy observation for Eritrea (and remove the rest of the variables).

eritrea_2002 <- gapminder %>%
  select(year, country, lifeExp) %>%
  filter(country == "Eritrea", year == 2002)


# 4. mutate: Create new variables
?mutate
gap_gdp <- gapminder %>%
  mutate(gdp = gdpPercap * pop)
dim(gap_gdp)


# 5. summarise: Collapse to a single value
gapminder %>% 
  summarise(meanLE = mean(lifeExp))

# 6. group_by: Change the scope
gapminder %>% 
  group_by(continent)


gapminder %>% 
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarise(pop = sum(pop))


# Challenge 4 – max life expectancy per country
maxLE <- gapminder %>%
  group_by(country) %>%
  summarise(maxLEVal = max(lifeExp)) %>% 
  arrange(desc(maxLEVal))
maxLE


# Another example of a summary, with a the starwars data set that dplyr provides:

# Grouping by species, summarise the number of characters per species and find the mean mass. Only for species groups with more than 1 character.

?starwars
?na
starwars %>%
  group_by(species) %>%
  summarise(
    n = n(), # this counts the number of rows in each group
    mass = mean(mass, na.rm = TRUE)
  ) %>%
  filter(n > 1) # the mean of a single value is not worth reporting

