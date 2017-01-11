Implementation of Random Search from:

http://cleveralgorithms.com/nature-inspired/stochastic/random_search.html

Inspiration taken from the C++ algorithm pattern (see https://msdn.microsoft.com/en-us/library/hh438471.aspx for a very quick overview).

In essence we assume since the caller gives us the input array (or search space), THEY are best responsible for both creating more similar candidates AND ranking a given candidate vector.

Thus, the RandomSearch class is only responsible for controlling search space, and keeping track of the current best candidate. 

This "object" heavy method feels very Smalltalk like. (Lake Smalltalkbegon, a town where sometimes the OO feels very correct, if maybe a bit awkward. All the men are strong, the women good looking and all the children above average).