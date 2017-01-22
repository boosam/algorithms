rm(list = ls())

iterations <- 20
number.list <- c(runif(100, 1, 101))
sample.list <- sample(number.list, iterations)

random.search <- function (random.selections) {
  return(min(random.selections))
} 
random.search(sample.list)


