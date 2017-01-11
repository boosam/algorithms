About my implementation language: Smalltalk
========================

I wrote my random sampler code in Smalltalk, [Pharo Smalltalk](http://pharo.org/).

Smalltalk is an interesting "what could have been" of computing. Smalltalk comes with its own entire environment, from window manager to code navigator to text editor. 

Why? Because Smalltalk predates Windows / the Mac! Ever wonder what would have happened if Xerox Parc *won*? Or if the [Dynabook](https://en.wikipedia.org/wiki/Dynabook) had happened? Smalltalk.

Mostly Smalltalk code is stored not in files, but as part of a "image" - like a VM snapshot. It's unusual to export it to files / folders, although such an export *can* be [done with modern tools](http://www.slideshare.net/esug/of-metacello-git-scripting-and-things). This export does produce a file/folder structure that looks... non-traditional... to modern eyes. What are you going to do: machines.

It's friendlier to look at Smalltalk code via the Smalltalk code browser in a Smalltalk VM.

Smalltalk's syntax has very few special forms, in that most of it can be shown in an [index card sized bit of sample code](http://stackoverflow.com/a/25321514/224334). Or [a one page overview](http://files.pharo.org/media/flyer-cheat-sheet.pdf).

But in general:

  * statements end with a `.` (not `;`)
  * Objective-C style message parameters: `object method: argumentOne: argumentTwo:`
  * comments are done with double quotes (`"I am a comment! Trippy!"`)
  * Pascal style assignment operators ( `a := 42`)
  * variables assigned at a top of a lexical scope, inside `||` (`|in out res|`)
  * everything is a message on an object, including looping and `if` statements


About my implementation of RandomSearch
============================

Implementation of Random Search from:

http://cleveralgorithms.com/nature-inspired/stochastic/random_search.html

Inspiration taken from the C++ algorithm pattern [very quick overview](https://msdn.microsoft.com/en-us/library/hh438471.aspx).

In essence we assume since the caller gives us the input array (or search space), THEY are best responsible for both creating more similar candidates AND ranking a given candidate vector.

Thus, the RandomSearch class is only responsible for controlling search space, and keeping track of the current best candidate. 

This "object" heavy method feels very Smalltalk like. (Lake Smalltalkbegon, a town where sometimes the OO feels very correct, if maybe a bit awkward. All the men are strong, the women good looking and all the children above average).

Smalltalk's overheavy OOP was one of the reasons I selected a design based on that C++ design method: I tried to implement it with my current functional bias style of writing, but had design blockers and had to do a 180.

Important Parts In The Code
=========================

A Smalltalk image is downloaded by Docker, and my `RandomSearch` class loaded into it as part of the `Dockerfile`. (with a helper Smalltalk script!)

`sample.st` in this folder is the triggering code / Dockerfile `CMD`: it sets up the search space and calls the `search:iterations:` method. (Also mirrored in `src/RandomSearch.package/RandomSearch.class/class/sample.st`).

Besides `sample.st` the other main point of interest is the implementation of `search:iterations` itself, found in: `src/RandomSearch.class/instance/search.iterations..st`.