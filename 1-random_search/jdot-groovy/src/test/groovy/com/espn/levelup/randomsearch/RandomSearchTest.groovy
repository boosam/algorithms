package com.espn.levelup.randomsearch

import static java.lang.Math.abs
import static java.lang.Math.pow
import static java.lang.Math.sqrt

import java.text.DecimalFormat

import org.junit.Test

import com.espn.testutil.SimpleTestBase
import com.espn.testutil.log.EventFilter
import com.espn.testutil.log.RegularExpressionFilter

class RandomSearchTest extends SimpleTestBase {

	private RandomSearch mTestRS
	private DecimalFormat format = new DecimalFormat("0.0000")
	
	@Override void setUp() throws Exception {
		super.setUp()
		mDumpLog = true
		mTestRS = new RandomSearch()
	}
	
	@Test public void test() {
		def theo = pow(40, 3)
		
		for (count in [5, 25, 100, 500, 5000, 100_000]) {
			def result = mTestRS.search(count, Comparators.NaturalOrderComparator.INSTANCE,
				           10, 40) {
			    x -> pow(x, 3)
			}
		
			def error = format.format(abs(theo - result) / theo * 100)
			
			// Ignore the print statement
			mLogStub.addFilter(new RegularExpressionFilter(1, ".*"))
			println "Cube between 10-40, $count iterations: $result; theoretical: $theo; error: $error%"
		}
	}
	
	@Test public void testIntegers() {
		def r = new Random()
		def result = mTestRS.search(100, Comparators.NaturalOrderComparator.INSTANCE,
			    { -> r.nextInt() }) {
					x -> new BigInteger(x).power(4)
				}
				
		def theo = new BigInteger(Integer.MAX_VALUE).power(4)
		def error = format.format((theo - result).abs() / theo * 100)
		// Ignore the print statement
		mLogStub.addFilter(new RegularExpressionFilter(1, ".*"))
		println "x^4 across all integers: $result; theoretical: $theo; error: $error%"
		
	}
	
	@Test public void testTimed() {
		def r = new Random()
		def comparator = { x, y -> x.isNaN() && y.isNaN() ? 0 : 
			 							 x.isNaN() ? -1 :
										 y.isNaN() ? 1 :
										 Comparators.NaturalOrderComparator.INSTANCE.compare(x, y) }
		def rng = { -> r.nextDouble() * 14 - 7 }
		def batman = {
					x -> 2*sqrt(-abs(abs(x)-1)*abs(3-abs(x))/((abs(x)-1)*(3-abs(x))))*(1+abs(abs(x)-3)/(abs(x)-3))*sqrt(1-pow(x/7, 2))+(5+0.97*(abs(x-0.5)+abs(x+0.5))-3*(abs(x-0.75)+abs(x+0.75)))*(1+abs(1-abs(x))/(1-abs(x)))
				}

		def theo = batman(0.75)
		for (ms in [10, 15, 50, 250, 500, 1250]) {
			def result = mTestRS.search(ms, comparator, rng, batman)
			def error = format.format(abs(theo - result) / theo * 100)
			
			// Ignore the print statement
			mLogStub.addFilter(new RegularExpressionFilter(1, ".*"))
			println "Batman! $ms ms: $result; theoretical: $theo; error: $error%"
		}
	}
	
	@Test public void testDataset() {
		def baseline = new ArrayList(1_000_000)
		for (x in 1..1_000_000) {
			def next = randStr(100, 100)
			baseline <<= next
		}
		
		def sorted = new ArrayList(baseline)
		sorted.sort()
		def total = sorted.size

		for (ms in [10, 15, 50, 250, 500, 1250]) {
			def randomOrder = new ArrayList(baseline)
			Collections.shuffle(randomOrder)
			def result = mTestRS.search(ms, Comparators.NaturalOrderComparator.INSTANCE, { null }, { randomOrder.remove(0) })

			def index = sorted.lastIndexOf result
			def error = format.format(abs(total - index) / total * 100)
						
			// Ignore the print statement
			mLogStub.addFilter(new RegularExpressionFilter(1, ".*"))
			println "Partial search $ms ms: index $index; theoretical: index $total; error: $error%"
		}

				
	}
}
