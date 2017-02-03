# This script will establish a connection to the WorldCities table of the dynomodb instance 
# create for this eample in the aws https://console.aws.amazon.com/dynamodb/home?region=us-east-1#tables:selected=WorldCities

require 'rubygems'
require 'aws-sdk'


#returns a log and lat for a  provided city
def get_city_data(city)
    search_city = city
    puts city

    dynamo_db = Aws::DynamoDB::Client.new
	params = {
    	table_name: "WorldCities",
    	expression_attribute_names: {
    		"CityName" => "CityName",
    		"Latitude" => "Latitude", 
    		"Longitude" => "Longitude", 
  		}, 
    	projection_expression: "CityName, Latitude, Longitude", 
    	filter_expression: "CityName = :city",
    	expression_attribute_values: {
    		":city" => search_city
    	}
    }

    result = dynamo_db.scan(params)
    puts "Query succeeded."

    return result

end


#returns log and lat for all cities in the WorldCities table
def get_cities()
    dynamo_db = Aws::DynamoDB::Client.new
	params = {
    	table_name: "WorldCities",
    	projection_expression: "CityName, Latitude, Longitude"
    }

    result = dynamo_db.scan(params)
    puts "Query succeeded."

    return result

end


#puts "Querying for cities from WorldCities.";

#begin
 #   result = get_cities
  #  puts "#{result}"
    
   # result.items.each{|city|
    #    puts "#{city["CityName"]} #{city["Latitude"]} #{city["Longitude"]}"
    #}

#rescue  Aws::DynamoDB::Errors::ServiceError => error
 #   puts "Unable to query table:"
  #  puts "#{error.message}"
#end
