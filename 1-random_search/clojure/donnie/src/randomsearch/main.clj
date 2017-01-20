(ns randomsearch.search
  (:require [clojure.data.json :as json]))

(defn exp [x n]
     (if (zero? n) 1
         (* x (exp x (dec n)))))

(def MaxIterations 10)
(def MaxSampleSize 1000)
(def CurrentResult)
(def BestResult 0)

(defn searchDataSet[]
    (dotimes [n (int (MaxIterations))] 
      (compareResultToBestResult (getRandomResult))
        ))
  )

(defn getRandomResult[]
  (rand-int (int (MaxSampleSize))))

(defn compareResultToBestResult[first]
  (if (< first second) first second)
  )

(searchDataSet)