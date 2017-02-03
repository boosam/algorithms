# Programming Level UP Challenges

## Challenge #1

Used to find the most optimal solution in fixed number of iterations by uniformly sampling the solution space.

**Resource**
http://www.cleveralgorithms.com/nature-inspired/stochastic/random_search.html

## The algorithm

- Find the best solution in a fixed amount of time.
  - Allows you to find a “good” answer when the “right” answer is not required.
  - Likely will NOT find the right answer
- Good for large, complex solution sets which may be prohibitively long to find the right answer.
- Components to the algorithm
  - The problem space (e.g. data, function)
  - The solution space - the portion of the problem space to test
  - The number of iterations to test

## How It Works

**f(x) = x^2**
Find the min / Find the max


## solution

**Use Node JS and Python**

Using Node JS to run the application in a browser and practice boilerplate setup.

Using Python to do the numerical and scientific computation. In node application, _spawn_ a python process that will run a random search on a data set using the algorithm.


## How to run

1. npm install (sudo)
2. npm run start
3. In your browser goto: http://localhost:3000/