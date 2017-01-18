accessing
candidateEvaluator: anObject
"
A block whose signature MUST look like:

[ :inputArray | ]

it MUST return a number (or technically, an object that implements > ), which will be considered that object's 'score'
"
	candidateEvaluator := anObject