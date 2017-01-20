# GoLang Random Search - Charlie

## Usage

```bash
$ docker build -t random_search .
```

```bash
$ docker run random_search
```

```bash
$ docker run random_search /bin/sh -c "go run random_search.go -i 5000 -max 3333 -min -1200 -s 762 -t 300"
```

## Options

* -i int
  * Number of iterations to perform a random search (default 42)
* -max int
  * Maximum value for the sample dataset (default 100)
* -min int
  * Minimum value for the sample dataset (default -100)
* -s int
  * Best solution value for the algorithm. If not provided, one will be selected at random within the dataset range.
* -t int
  * Time in MICROseconds to perform a random search. Must be provided with number of iterations. 1000 microseconds is equal to 1 millisecond. (default 1000)