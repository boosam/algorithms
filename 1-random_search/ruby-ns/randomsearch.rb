

#arr_samplespace = [10,4,30,100,-1,2,1,5]
#Assigns the list of strings into an array
arr_args = ARGV

raise ArgumentError.new("A sample space needs to be provided such 6 8 40 ...") if arr_args.nil?

puts "Sample space is #{arr_args}"

#Converts the string input to a array of integers
arr_samplespace = arr_args.map { |i| i.to_i }

puts "Sample space after converting to int #{arr_samplespace}"


#Method to return the minimum value of a give integer array
def search(arr_samplespace) 

	if arr_samplespace.length == 0
		return nil
    end 

    best = arr_samplespace.first

    arr_samplespace.each { |value|
	  if best > value
	  	best = value
	  end 
	}

   return best
end

result = search(arr_samplespace)

	if result == nil
		puts "Empty sample space"
	else 
		puts "The minimum value is #{result}"
	end