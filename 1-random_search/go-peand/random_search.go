package main
import (
	"fmt"
	"math/rand"
	"math"
	"time"
)
func main() {

	var NumIterations int = 100
	var problemSpace int = 2
	var best float64
	var searchSpace [2][2]int
	

	for i := 0; i < problemSpace; i++ {
        searchSpace[i] = [...]int{-5, 5}
    }
     
	for i := 0; i < NumIterations; i++ {
		
        candidate := randomSolution(searchSpace)
        //fmt.Println("candidate:", candidate)
        value := randomCalculation(candidate)
        fmt.Println("Value:", value)
        if i == 0 || value < best{
        	best = value
        }
         
    }
    fmt.Println("Best:", best)
 
}

func randomSolution(searchSpace [2][2]int)[2]float64{
	s1 := rand.NewSource(time.Now().UnixNano())
    r1 := rand.New(s1) 
   
	var solution [2]float64
	for i := 0; i < 2; i++ {
		solution[i] = float64(searchSpace[i][0]) + (float64( searchSpace[i][1] - searchSpace[i][0] ) * r1.Float64() )
	}
	return solution
	 
}

func randomCalculation(candidate [2]float64)float64{
	calc := 0.0
	for i := 0; i < 2; i++ {
		calc = calc + math.Pow(candidate[i],2) 
	}
	return calc
}

 