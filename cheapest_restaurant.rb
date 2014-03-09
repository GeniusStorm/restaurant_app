
#Cheapest Restaurant is an umbrella script over the other classes and marks
#the entry point for restaurant puzzle.

#requires
require_relative 'restaurant_scanner'
require_relative 'restaurant'

#scan all the arguments and raise necesaary errors if not valid
scanned_restaurants = RestaurantScanner.new(ARGV)

# pass the valid set of arguments to the restaurant class
cheapest_restaurant = Restaurant.find_cheapest_restaurant(scanned_restaurants.price_list , scanned_restaurants.items)

#print the cheapest restaurant status with an exit status of 0 or 1
RestaurantScanner.print_cheapest_restaurant(cheapest_restaurant)

