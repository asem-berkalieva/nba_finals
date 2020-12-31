# load libraries
library(tidyverse)

# import data
setwd('code/raw_code')
champs <- read_csv('../../data/raw_data/championsdata.csv')
runners <- read_csv('../../data/raw_data/runnerupsdata.csv')

# find distinct team names
champs %>% select(Team) %>% distinct()

# fix typos for the heat and warriors
champs <- champs %>%
  mutate(Team = ifelse(Team == "Warriorrs","Warriors",Team)) %>%
  mutate(Team = ifelse(Team == "'Heat'","Heat",Team))

runners <- runners %>%
  mutate(Team = ifelse(Team == "Warriorrs","Warriors",Team)) %>%
  mutate(Team = ifelse(Team == "'Heat'","Heat",Team))

# what classes are the Win and Home variables?
class(champs$Win)
class(champs$Home)

# convert Win and Home variables to factor
champs <- champs %>%
  mutate(Win = as.factor(Win)) %>%
  mutate(Home = as.factor(Home))

runners <- runners %>%
  mutate(Win = as.factor(Win)) %>%
  mutate(Home = as.factor(Home))

# bind the two data sets together
allteams <- bind_rows(champs,runners)
# another option: allteams <- rbind(champs, runners)

# add a column that shows champions vs. runnerups call it rank
allteams <- bind_rows("Champion" = champs, "Runner" = runners, .id = "rank")
