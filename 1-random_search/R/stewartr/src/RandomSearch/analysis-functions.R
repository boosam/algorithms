rm(list = ls())

iterations <- 20
# runif([howManyNumbers,start,end(non-inclusive)])
number.list <- c(runif(100, 0, 101))
number.list

#lowest <- runif(1, min<-1, max<-length(number.list))
number.iterations <- 0
random.search <- function () {
  get.rand.in.set <- function () runif(1, 1, length(number.list))
  lowest <- get.rand.in.set()
  for (i in iterations-1) {
    #rand.in.set = get.rand.in.set()
    lowest <- min(c(lowest, rand.in.set))
    #number.iterations.values <<- number.iterations.values + rand.in.set
  }
  return(lowest)
}

#random.search()

#lowest

