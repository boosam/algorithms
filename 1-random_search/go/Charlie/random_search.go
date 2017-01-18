package main

import (
	"flag"
	"fmt"
	"math/rand"
	"math"
	"time"
	"os"
	"github.com/olekukonko/tablewriter"
	"strconv"
)

// Set vars
var iterations, timeLimit, minRange,
	maxRange, solutionValue, bestCandidate,
	currentIteration int
var bestAbs float64
var endTime time.Duration

// Parse incoming options
func optParse() {
	flag.IntVar(&iterations, "i", 42, "Number of iterations to perform a random search")
	flag.IntVar(&timeLimit, "t", 1000, "Time in MICROseconds to perform a random search.\n\tMust be provided with number of iterations.\n\t1000 microseconds is equal to 1 millisecond.")
	flag.IntVar(&minRange, "min", -100, "Minimum value for the sample dataset")
	flag.IntVar(&maxRange, "max", 100, "Maximum value for the sample dataset")
	flag.IntVar(&solutionValue, "s", 0, "Best solution value for the algorithm.\n\tIf not provided, one will be selected at random within the dataset range.")
	flag.Parse()
}

// Returns a random integer between the minRange and maxRange
func getRand() int {
	rand.Seed(time.Now().UnixNano())
	return rand.Intn(maxRange - minRange) + minRange
}

func search(iterations, timeLimit, minRange, maxRange, solutionValue int) int {
	startTime := time.Now()
	for currentIteration = 0; currentIteration < iterations; currentIteration++ {
		// Get random value within range and calulate absolute value
		candidate := getRand()
		candidateAbs := math.Abs(float64(candidate - solutionValue))

		// Set values on first iteration
		if currentIteration == 0 {
			bestCandidate, bestAbs = candidate, candidateAbs
		}

		// Set best abs value to new candidate if it's closer
		if candidateAbs < bestAbs {
			bestAbs = candidateAbs
			bestCandidate = candidate
		}
	}
	endTime = time.Since(startTime)
	return bestCandidate
}

// Print formatted table to stdout
func printTable() {
	data := [][]string{
		[]string{"Total iterations", strconv.Itoa(iterations)},
		[]string{"Iterations Ran", strconv.Itoa(currentIteration)},
		[]string{"Time Limit", time.Duration.String(time.Duration(timeLimit) * 1000)},
		[]string{"Elapsed Time", time.Duration.String(endTime)},
		[]string{"Minimum Range", strconv.Itoa(minRange)},
		[]string{"Maximum Range", strconv.Itoa(maxRange)},
		[]string{"Solution Value", strconv.Itoa(solutionValue)},
		[]string{"Best Candidate", strconv.Itoa(bestCandidate)},
	}
	table := tablewriter.NewWriter(os.Stdout)
	table.SetHeader([]string{"Key", "Value"})
	table.AppendBulk(data) 
	table.Render()
}

func main() {
	// Parse script args
	optParse()

	// Get solution value in data range
	if solutionValue == 0 {
		solutionValue = getRand()
	}

	// 
	searchChan := make(chan int)

	// Concurrently iterate over algorithm
	go func() {
		searchChan <- search(iterations, timeLimit, minRange, maxRange, solutionValue)
	}()

	// Continuously loop until the time limit is up, or we finished iterating
	select {
	case <-searchChan:
		printTable()
	case <-time.After(time.Duration(timeLimit) * time.Microsecond):
		fmt.Println("The program timer limit was reached before it could finish iterating!")
		endTime = time.Duration(timeLimit * 1000)
		printTable()
	}

}
