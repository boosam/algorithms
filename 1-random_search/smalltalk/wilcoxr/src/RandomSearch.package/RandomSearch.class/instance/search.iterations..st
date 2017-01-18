as yet unclassified
search: searchSpace iterations: maxIter
	| currentBestCost currentBestArray output|
	output := Array new: 2.
	
	currentBestCost := nil.
	1 to: maxIter do: [ :i | 
		| candidateArray candidateCost |
		candidateArray := self candidateCreator value: searchSpace.
		candidateCost := self candidateEvaluator value: candidateArray.
		currentBestCost
			ifNil: [ currentBestCost := candidateCost.
				currentBestArray := candidateArray ].
		candidateCost < currentBestCost
			ifTrue: [ currentBestCost := candidateCost.
				currentBestArray := candidateArray ] ].
	
	output at: 1 put: currentBestCost .
	output at: 2 put: currentBestArray.
	^ output.
	