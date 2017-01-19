package com.espn.levelup.randomsearch

/**
 * <p>Performs a random search, as described in <a href="http://www.cleveralgorithms.com/nature-inspired/stochastic/random_search.html">Clever Algorithms</a>,
 * stochastic algorithm #1.</a>
 * 
 * @author J. Nathaniel Sloan
 */

class RandomSearch {
	
	/**
	 * <p>Performs a random search of the input.  The {@link Comparator} is used to determine
	 * which result to keep; this method will always keep the maximal result.  (To search for
	 * the minimum value instead, reverse the order of the comparator).  The source {@link Closure}
	 * is used to provide input to the function; e.g., it could be a random number generator.
	 * The function {@link Closure} is expected to accept the results output from the
	 * source and compute an appropriate result; it is the result of this method that is maximized.</p>
	 * 
	 * @param maxTries the maximum number of attempts to make
	 * @param comparator a {@link Comparator} that will be used to determine which result to keep.
	 * May not be {@code null}.
	 * @param source a {@link Closure} that should expect no input and should return an appropriate
	 * input value for the computation function.  May not be {@code null}.
	 * @param function a {@link Closure} that computes the value that is to be maximized by this
	 * search function.  May not be {@code null}.
	 * @return the maximum value returned by the function within the allowed number of iterations.
	 */
	
	public <T, X> T search(int maxTries, Comparator<T> comparator, Closure<X> source, Closure<T> function) {
		T result = null
		for (i in 1..maxTries) {
			T nextVal = function source()
			if (! (result && comparator.compare(result, nextVal) > 0)) {
				result = nextVal
			}
		}
		
		result

	}
	
	/**
	 * <p>A special-purpose version of random search that supplies random values between a
	 * lower bound (inclusive) and an upper bound (exclusive).</p>
	 * 
	 * @param maxTries the maximum number of attempts to make
	 * @param comparator a {@link Comparator} that will be used to determine which result to keep.
	 * May not be {@code null}.
	 * @param low the lower bound for the random data to pass to the function; inclusive.
	 * @param high the upper bound for the random data to pass to the function; exclusive.
	 * @param function a {@link Closure} that computes the value that is to be maximized by this
	 * search function.  May not be {@code null}.
	 * @return the maximum value returned by the function within the allowed number of iterations.
	 */
	public <T> T search(int maxTries, Comparator<T> comparator, double low, double high, Closure<T> function) {
		search(maxTries, comparator, { -> Math.random() * (high - low) + low }, function);
	}
	
	/**
	 * <p>A time-bound (rather than iteration-bound) version of the random search; it runs
	 * as many iterations as possible within the time slice provided.</p>
	 * 
	 * @param maxDurationInMillis the maximum amount of time to search for an answer, in milliseconds.
	 * @param comparator a {@link Comparator} that will be used to determine which result to keep.
	 * May not be {@code null}.
	 * @param source a {@link Closure} that should expect no input and should return an appropriate
	 * input value for the computation function.  May not be {@code null}.
	 * @param function a {@link Closure} that computes the value that is to be maximized by this
	 * search function.  May not be {@code null}.
	 * @return the maximum value returned by the function within the allowed number of iterations.
	 */
	
	public <T, X> T search(long maxDurationInMillis, Comparator<T> comparator, Closure<X> source, Closure<T> function) {
		def count
		T result = null
		T nextVal = null
		def proc = new Runnable() {
			@Override void run() {
				try {
					result = function source()
					count = 1
					
					while (true) {
						nextVal = function source()
						if (comparator.compare(result, nextVal) < 0) {
							result = nextVal
						}
						count++
					}
				}
				catch (InterruptedException ie) {
					// allow execution to end
				}
				
				result
			}
		}
		
		def t = new Thread(proc)
		t.start()
		Thread.sleep(maxDurationInMillis)
		t.interrupt()
		result
	}
}
