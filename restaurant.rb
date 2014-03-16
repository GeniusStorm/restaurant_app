class Restaurant

	attr_accessor :id , :price , :menu_item 

	def initialize(id , price  , menu_item)
		@id, @price, @menu_item = id, price, menu_item
	end

	#gets all the restaurants with the ordered line items
	def self.find_cheapest_restaurant(restaurant_list, order_items)
		#step1: find all the restaurants that can fullfill the order
	    fulfiilling_restaurants = find_restaurants_with_all_order_items(restaurant_list, order_items)
	    #step2: calculate the order total for each fullfilling restaurant
	    restaurants_with_order_total = calculate_order_total_by_restaurant(fulfiilling_restaurants, order_items)
	    #step3: find and return the restaurant with minimum order total
	    get_cheapest_restaurant(restaurants_with_order_total)
	end

	#group all the restaurants by id
	def self.menu_items_by_restaurant(restaurant_list)
		restaurant_list.group_by(&:id)
	end

	#takes the restaurants ordered by id and checks if each of the restaurant fullfills the order
	# and then returns the restaurants that are applicable for order
	def self.find_restaurants_with_all_order_items(restaurant_list, order_items)
		restaurants_with_order_items = []
		menu_items_by_restaurant(restaurant_list).each_value do |restaurant|
		   restaurants_with_order_items	 << restaurant if (restaurant.collect(&:menu_item).flatten & order_items).length == order_items.uniq.length 
		end
		restaurants_with_order_items.flatten
	end

	#groups the restaurant menu by order item
	def self.menu_items_by_order(restaurants, order_items)
		valid_items, final_menu_items =[], []
		menu_items_by_restaurant(restaurants).each_value do |restaurant|
		    restaurant.each do |rest| 
				next if (order_items & rest.menu_item).empty? 
				order_items.count(rest.menu_item.first).times{valid_items << rest.dup }
			end
		end
		valid_items.group_by(&:id)
	end

	#calculates the order total and returns an array containing the restaurant id and order total
	def self.calculate_order_total_by_restaurant(restaurants, order_items)
		order_total =[]
		menu_items_by_order(restaurants,order_items).each_value do |restaurant|
		  order_total << [restaurant.first.id , restaurant.map(&:price).reduce(:+)]
		end
		order_total
	end

	#find the restaurant with minimum total and return it
	def self.get_cheapest_restaurant(restaurants)
		restaurants.sort.min_by{|restaurant| restaurant[1]}
	end

end


