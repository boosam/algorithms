# Random Search Program in Python - Shannon Rhodes
#http://www.cleveralgorithms.com/nature-inspired/stochastic/random_search.html

from random import randint #https://docs.python.org/3.1/library/random.html#random.randint

#this list was used for testing
list = [ 1, 7, 3, 4, 2, 8, 10, 3, -1, 9]

#function: calculates the smaller value between two numbers
#param(number1): number to compare
#param(number2): number to compare
def min(number1,number2):
    if (number1 == '' or number2 < number1) : return True
    else : return False

#function: to identify the best solution given a number of iterations
#param(search_space): will be running random search algorithm on this data set
#param(max_iterations): the number of times of comparison between values
def search(search_space,max_iterations):
    bestSolution = ''
    for iterator in range(0,max_iterations):
        testIndex = randint(0,len(list)-1)
        if(min(bestSolution,list[testIndex])):
            bestSolution = list[testIndex]
    return bestSolution

#terminal output in python
print 'Best Solution from random search: ', search(list,5)
