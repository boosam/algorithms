

#arr_samplespace = [10,4,30,100,-1,2,1,5]
#Assigns the list of strings into an array
arr_args = ARGV

raise ArgumentError.new("A sample space needs to be provided such 6 8 40 ...") if arr_args.nil?

puts "Sample space is #{arr_args}"

#Converts the string input to a array of integers
arr_searchspace = arr_args.map { |i| i.to_i }

puts "Sample space after converting to int #{arr_searchspace}"


#random search
def random_search(arr_searchspace, iteration) 

	if arr_searchspace.length == 0
		return nil
    end 

    best = arr_searchspace.first
  
    for i in 0..iteration
      candidate_solution = get_random_solution(random_items(arr_searchspace))#will check a sample of problem space
	  
	  if best > candidate_solution
	  	best = candidate_solution
	  end 
	end

   return best
end

#Method to return the minimum value of a give integer array
def get_random_solution(arr_samplespace) 

    puts "Sample space #{arr_samplespace}"

    best = arr_samplespace.first

    arr_samplespace.each { |value|
	  if best > value
	  	best = value
	  end 
	}

   return best
end

def random_items(array)
  array.sample(1 + rand(array.count))
end


#puts "How many times should I search ? "
#num_iterations = gets.chomp
num_iterations = 5

result = random_search(arr_searchspace, num_iterations)

	if result == nil
		puts "Empty sample space"
	else 
		puts "The minimum value is #{result}"
	end