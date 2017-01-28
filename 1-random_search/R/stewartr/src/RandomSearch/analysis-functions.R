rm(list = ls()) # reset R environment

sample.size <- 25 # iterations
number.count <- 1000 # objects in total search space
number.range.min <- -20 # min input number
number.range.max <- 20 # max input number
number.func <- function(input) input^2 # treat this as f(x)
number.list <- number.func(c(runif(number.count, number.range.min, number.range.max))) # gets random numbers and applies f(x)
sample.list <- sample(number.list, sample.size) # get a set of random data to search in

random.search <- function (random.selections) {
  min(random.selections) #return lowest value
} 
lowest <- random.search(sample.list) # store the lowest value globally (to graph)

graph.results <- function() {
  png(paste("output/", format(Sys.time(),"%m_%d_%Y-%H_%M_%S"),".png",sep=""),width=1600,height=900) # start image cap
  par(usr=c(0, sample.size, number.range.min, number.range.max),pch=16,cex=0.85,bg="#DDDDDD") # graph parameters
  plot(number.list, type="p") # graph the full number set in black
  par(cex=1.25)
  points(match(sample.list, number.list), sample.list, col="red") # graph the whole sample set in red 
  par(cex=1.5)
  points(which(number.list == lowest),lowest, col="green") # graph the best-fit from the sample in green
  dev.off() # Done building image, save it out
}
graph.results() # build the graph
