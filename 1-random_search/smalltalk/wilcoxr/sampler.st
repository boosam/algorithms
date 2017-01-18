| a searchSpaceStream problemSize maxIter output |

"-------------SET UP---------------------"
problemSize := 2.
maxIter := 100.
searchSpaceStream := WriteStream on: Array new.
"populate searchSpace(Stream)"
1 to: problemSize do: [ :i | searchSpaceStream nextPut: #(-5 5) ].
a := RandomSearch new.

"set candidateCreator: create a random array whose contents we will eval to see if better"
a
	candidateCreator: [ :inArray | 
		| outArrayWriter |
		outArrayWriter := WriteStream on: Array new.
		inArray
			do: [ :currentInputItem | 
				| itemOne itemTwo randVal randomItem |
				itemOne := currentInputItem at: 1.
				itemTwo := currentInputItem at: 2.
				randVal := Random new next.
				randomItem := itemOne + ((itemTwo - itemOne) * randVal).
				outArrayWriter nextPut: randomItem ].
		outArrayWriter contents ].

"set candidateEvaluator: what is the score of the array we're passing in (up to the algorithm to determine if this score is better than one we currently have"
a candidateEvaluator: [ :inputArray | inputArray inject: 0 into: [ :sum :nextElement | sum + (nextElement * nextElement) ] ].


"-----------------RUN THE CODE----------------"
output := a search: searchSpaceStream contents iterations: maxIter.

FileStream stdout cr; nextPutAll: (output printString); cr. 
Smalltalk snapshot: false andQuit: true.