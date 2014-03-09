# ArgumentScanner scans the incoming arguments from the command line and
# raises necessary exceptions or prepares arguments for use with restaurant

require 'csv'
require_relative 'restaurant_error'
require_relative 'restaurant'
class RestaurantScanner

	attr_accessor :price_list_file , :items , :price_list 

	def initialize(args)
		@price_list_file = args.first && args.first.include?(".csv") ? args.first : \
										(raise RestaurantError.new("InputError: Price list is undefined"))
		@items =  args[1..args.length] && !args[1..args.length].empty? ?  args[1..args.length] : \
																		(raise RestaurantError.new("InputError : Order Items are undefined"))
	    build_restaurants #scans the restaurants and builds the restaurants object for each csv row   
	end

	#scans the price list and wraps the restaurant object for easy manipulation of restaurant properties(id, price, item label)
	def build_restaurants
	  @price_list =[]
	  CSV.foreach(@price_list_file) do |row|
	  	id = Integer(row[0])  
	  	price = row[1].to_f > 0.0 ? row[1].to_f : \
	  								(raise RestaurantError.new("DataError: Invalid Price found in Price List")) 
	  	item = row[2..price_list_file.length].collect(&:strip) #all elements after third index shall be considered as order items
	  												
	 	@price_list << Restaurant.new(id,price,item)
	  end
	  @price_list.flatten
	end

	#prints the given restaurant to standard output along with the exit status of 0 or 1 conditionally
	def self.print_cheapest_restaurant(restaurant)
	    restaurant ? STDOUT.write(restaurant.join(",") + "\n" ) && (exit 0) : (exit 1)
	end


end