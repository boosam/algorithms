# Implementing Random Search in R

The language chosen for this project is R.

**From Wikipedia:**

- R is a programming language and software environment for statistical computing and graphics supported by the R Foundation for Statistical Computing. The R language is widely used among statisticians and data miners for developing statistical software and data analysis.

R is built on C, and was designed to resemble S and Scheme.

**R syntax notes:**

- `=` is `<-` (R 1.4+ supports using `=`, but it’s considered good practice by most to continue using `<-`)
- `.` is used as punctuation in variable names, not method call/property like other languages
So `my.variable` in R would be equivalent to `myVariable` or `my_Variable` in other languages.
- Scoping is lexical. One important difference between R and S is that functions can access variables that were in effect when the function was defined.


**My Implementation of Random Search in R:**

1. Start by resetting R environment to make sure we are in a clean state
2. Set all variables (iterations, size of data set, range, etc.)
3. Set f(x) function (in this case f(x)=X^2)
4. Generate set of random numbers using params and immediately apply f(x) to the whole set
5. Generate sample set (R has a method for getting a random sample of n size from a larger set)
6. Implement RandomSearch function
  * Takes the sample set as an argument and finds the smallest number
7. Implement graph function
  * Sets parameters for .png image of graph
  * Sets parameters for the actual graph
  * Plots full number set in black
  * Bumps up the plot size then redraws the sample set in red
  * Bumps up the plot size a bit more then redraws the best candidate in green
  * Saves out file to `output/[date-time].png`
