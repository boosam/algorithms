rm(list = ls())

iterations <- 20
number.list <- c(runif(100, 1, 101))
sample.list <- sample(number.list, iterations)

random.search <- function (random.selections) {
  lowest <- random.selections[1]
  for (i in 2:length(random.selections)) lowest <- min(c(lowest, random.selections[i]))
  return(lowest)
} 
random.search(sample.list)


