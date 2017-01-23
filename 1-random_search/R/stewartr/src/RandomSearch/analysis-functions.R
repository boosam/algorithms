rm(list = ls()) # reset R environment

sample.size <- 20 # iterations
number.count <- 100 # objects in total search space
number.range.min <- -10 # min input number
number.range.max <- 10 # max input number
number.func <- function(input) input^2 # treat this as f(x)
number.list <- number.func(c(runif(number.count, number.range.min, number.range.max))) # gets random numbers and applies f(x)
sample.list <- sample(number.list, sample.size) # get a set of random data to search in

random.search <- function (random.selections) {
  min(random.selections) #return lowest value
} 
lowest <- random.search(sample.list) # store the lowest value globally (to graph

graph.results <- function() {
  dev.new() # open new graph window
  par(usr=c(0, sample.size, number.range.min, number.range.max)) #graph parameters
  plot(number.list, type="p") # graph the full number set in black
  points(match(sample.list, number.list), sample.list, col="red") # graph the whole sample set in red 
  points(which(number.list == lowest),lowest, col="green") # graph the best-fit from the sample in green
}
graph.results() # build the graph
