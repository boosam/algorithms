//
//  main.swift
//  1-random-search
//
//  Created by Schilling, Graham M. on 1/19/17.
//  Copyright © 2017 Schilling, Graham M. All rights reserved.
//

import Foundation

func main() {
    let problemSize = 2
    //let searchSpace = [[Int]](count: problemSize, repeatedValue: [Int](count: problemSize, repeatedValue: 0))
    //Int(arc4random_uniform(100) - 50)))
    let searchSpace = [[-5,5],[-5,5]]
    let numberOfIterations = 100
    
    let theBestAnswer = findAnswer(searchSpace, numberOfIterations: numberOfIterations)
    print("Best Answer found:  \(theBestAnswer)")
}

func findAnswer(searchSpace: [[Int]], numberOfIterations: Int) -> Double {
    var bestAnswer: Double?
    for i in 0...numberOfIterations {
        let contender = getRandom(searchSpace)
        let value = objectiveCalc(contender)
        if (i == 0 || value < bestAnswer) {
            bestAnswer = value
        }
    }
    return bestAnswer!
}

func getRandom(searchSpace: [[Int]]) -> [Double] {
    let random = drand48()
    var solution = [Double](count: searchSpace.count, repeatedValue: 0.0)
    
    for i in 0...searchSpace.count - 1 {
        solution.append((Double(searchSpace[i][0]) + (Double(searchSpace[i][1] - searchSpace[i][0]) * random)))
    }
    return solution;
}

func objectiveCalc(contender: [Double]) -> Double {
    var value = 0.0
    for i in 0...contender.count - 1 {
        value = value + pow(contender[i],2)
    }
    return value
}

main()

