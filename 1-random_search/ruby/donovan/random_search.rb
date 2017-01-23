# prompts user for a number of iterations ensuring value is in [1-5]
def get_iterations()
  num_iterations = nil
  begin
    puts "\nEnter a value for number of iterations: [1-5]"
    print ">"
    num_iterations = $stdin.gets.chomp.to_i
  end until num_iterations > 0 and num_iterations <= 5
  return num_iterations
end

# checks for maximum value in an array in n attempts
def max_random_search(array, number_of_tries)
  used_index_array = Array.new(5)
  best_result = nil
  until number_of_tries == 0
    search_index = get_random_index(array, used_index_array)
    used_index_array.push(search_index)
    current_result = array.fetch(search_index)
    puts "Checking current result of #{current_result}"

    if best_result.nil?
      best_result = current_result
    end
    if current_result > best_result
      best_result = current_result
    end
    number_of_tries -=1
  end

  used_index_array.push(search_index)
  max = array.fetch(search_index)
  return best_result;
end

# checks if an array contains the supplied value
def check_for_existing_value(array, value)
  return array.include? value
end

# gets a random index based on an array and it's size
def get_random_index(array, index_array)
  original = false
  until original == true
    random_index = rand(0..array.length-1)
    original = !check_for_existing_value(index_array, random_index)
  end
  return random_index
end

# array of values to be used
array = [10, 5, 27, 36, 8, 16, 22, 56, 31, 2]

# main part of the program

# print out test array
print "Test array: "
print array

# print out the number of iterations selected
num_iterations = get_iterations()
puts "Searching for best maximum value in array in #{num_iterations} iterations"

# prints out the result for best maximum value
result = max_random_search(array, num_iterations)
puts "Best maximum value is: #{result} "
