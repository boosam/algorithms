# Random Search Program in Python - Shannon Rhodes

from random import randint #https://docs.python.org/3.1/library/random.html#random.randint

list = [ 1, 7, 3, 4, 2, 8, 10, 3, -1, 9] #waiting for data set

def min(number1,number2):
    if (number1 == '' or number2 < number1) : return True
    else : return False

def search(search_space,max_iterations):
    bestSolution = ''
    for iterator in range(0,max_iterations):
        testIndex = randint(0,len(list)-1)
        if(min(bestSolution,list[testIndex])):
            bestSolution = list[testIndex]
    return bestSolution

print 'Best Solution: ', search(list,5)
