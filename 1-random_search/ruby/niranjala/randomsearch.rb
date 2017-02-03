

#arr_samplespace = [10,4,30,100,-1,2,1,5]
#Assigns the list of strings into an array
#arr_args = ARGV

#raise ArgumentError.new("A sample space needs to be provided such 6 8 40 ...") if arr_args.nil?

#puts "Sample space is #{arr_args}"

#Converts the string input to a array of integers
#arr_searchspace = arr_args.map { |i| i.to_i }

#puts "Sample space after converting to int #{arr_searchspace}"


###########################################################################
# With the new change we will build our sample space from the WorldCities dynomodb table
###########################################################################
require_relative "Connection"
require_relative "Distance"


# This function will call the scripts to connect to dynomodb and get the results of lat and log values 
#for the given cities and calculate the distance from bristol 

def build_samplespace () 
 hash_distance = {}
 arr_city_of_choice = [41.6718, 72.9493]
 cities = get_cities()

 puts cities.length
 
  
  #create a collection of the sample data
  cities.items.each{|city|
        #puts "#{city["CityName"]} #{city["Latitude"]} #{city["Longitude"]}"
        #city_points(:CityName => city["CityName"], :Latitude => city["Latitude"], :Longitude => city["Longitude"])
        
        lat = city["Latitude"]
        lon = city["Longitude"]
        arr_random_city = [lat, lon] 

        #puts "==========>" + city["CityName"]
        distance = distance(arr_city_of_choice, arr_random_city)
        #puts "Distance #{distance}"

        hash_distance[city["CityName"]] = distance
  }

  return hash_distance

end

#randomly search for the closet city to Bristal searc
#random search
def random_search(searchspace, iteration) 

	if searchspace.length == 0
		return nil
    end 

    bestkey = searchspace.keys[0]
    bestvalue = searchspace.values[0]
  
    for i in 0..iteration
      candidate_solution = get_random_solution(random_items(searchspace))#will check a sample of problem space
	  
	  #puts "Best Key #{candidate_solution[0]}"
      #puts "Best Value #{candidate_solution[1]}"

	  if bestvalue.to_f > candidate_solution[1].to_f
	  	bestvalue = candidate_solution[1]
	  	bestkey = candidate_solution[0]
	  end 
	end

   return bestkey
end

#Method to return the minimum value of a give integer array
def get_random_solution(samplespace) 

    #puts "Sample space #{samplespace}"

    bestkey = samplespace.keys[0]
    bestvalue = samplespace.values[0]

    #puts "Best Key #{bestkey}"
    #puts "Best Value #{bestvalue}"

    samplespace.each { |key , value|

	  if bestvalue.to_f > value.to_f
	  	bestvalue = value
	  	bestkey = key
	  end 
	}
   
   #puts bestkey
   #puts bestvalue

   return [ bestkey, bestvalue ]
end



def random_items(array)
  array.sample(1 + rand(array.count))
end

#Method to return the minimum value of a give integer array
def get_random_solution_1(arr_samplespace) 

    puts "Sample space #{arr_samplespace}"

    best = arr_samplespace.first

    arr_samplespace.each { |value|
	  if best > value
	  	best = value
	  end 
	}

   return best
end

def random_items(hashsample)
  #array.sample(1 + rand(array.count))
  return hashsample.to_a.sample(1 + rand(hashsample.count)).to_h
end

###############################################################
#Maing body of the script

###############################################################

begin
	#puts "How many times should I search ? "
	#num_iterations = gets.chomp
	num_iterations = 5

	#build_samplespace()

	result = random_search(build_samplespace(),num_iterations)

	if result == nil
		puts "Something went wrong"
	else 
		puts "The city closes to bristol is  #{result}"
	end

end


