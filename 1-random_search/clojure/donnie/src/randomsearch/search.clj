(ns randomsearch.search)

(defn exp [x n]
     (if (zero? n) 1
         (* x (exp x (dec n)))))

(def MaxIterations)
(def CurrentResult)
(def BestResult)

(defn compareResultToBestResult[current]
  (if (< (int current) (int CurrentResult)) current CurrentResult)
  )

(defn getRandomResult[]
  (int (rand 1000)))

(defn searchDataSet[]
    (dotimes [n 10] 
      (compareResultToBestResult (getRandomResult)))
  )


(defn -main
  []
  (searchDataSet))