require_relative 'restaurant_error'
require_relative 'restaurant_scanner'
require_relative 'restaurant'

describe Restaurant do

	let(:valid_csv_args) {["./restaurant_app_test.csv", "steak_sandwich"]}
	let(:value_meal_csv)  {["./restaurant_app_test.csv", "fancy_european_water", "extreme_fajita"]}
	let(:order_item_same_price_csv) {["./restaurant_app_test.csv", "coke"]}
	let(:non_existing_csv) {["./no_csv_file.csv", "coke"]}
	let(:no_matching_restaurants_csv)   {["./restaurant_app_test.csv", "Pepsi"]}
	let(:invalid_csv_args) {["./restaurant_app_invalid_test.csv"]}
	let(:invalid_price_csv_args) {["./restaurant_app_invalid_test.csv", "steak_sandwich" , "chicken_pizza"]}
	let(:invalid_rest_id_csv) {["./invalid_rest_id.csv", "steak_sandwich" , "chicken_pizza"]}
	let(:no_csv_args) 	  {["./restaurant_app_test", "ham_sandwich", "burrito", "tofu_log"]}
	let(:unsorted_order_items){["./restaurant_app_test.csv", "fettuccine_alfredo", "veggie_calzone"]}
	let(:multiple_item_quantity){["./restaurant_app_test.csv", "lasagna", "pepsi" , "pepsi"]} #ordering 2 cokes and a steak sandwich
	

	#restaurant scanner
	context 'RestaurantScanner' do

		context "validations" do
			it "validates that the csv files exists" do
				expect {RestaurantScanner.new(non_existing_csv)}.to raise_error(RestaurantError, "InputError: Price list is undefined")								
			end
			it "validates the restaurant id in the price list" do
				expect {RestaurantScanner.new(invalid_rest_id_csv)}.to raise_error(RestaurantError, "DataError: Restaurant ID cannot be string or zero")				
			end
			it "validates the restaurant id in the price list" do
				expect {RestaurantScanner.new(invalid_rest_id_csv)}.to raise_error(RestaurantError, "DataError: Restaurant ID cannot be string or zero")				
			end
			it "validates the price list file " do
				expect {RestaurantScanner.new(no_csv_args)}.to raise_error(RestaurantError, "InputError: Price list is undefined")
			end

			it "validates the order items" do
				expect {RestaurantScanner.new(invalid_csv_args)}.to raise_error(RestaurantError, "InputError : Order Items are undefined")
			end

			it "validates invalid price" do
				expect{RestaurantScanner.new(invalid_price_csv_args)}.to raise_error(RestaurantError, "DataError: Invalid Price found in Price List")
			end
		end

		context "restaurant initialization" do
			it "builds the restaurants from price list" do
				RestaurantScanner.new(valid_csv_args).price_list.should be_kind_of(Array)
				RestaurantScanner.new(valid_csv_args).price_list.first.should be_kind_of(Restaurant)
				RestaurantScanner.new(valid_csv_args).price_list.first.id.should == 1
			end
		end

		context "printing output" do
			it "exits with a system code" do
				expect{RestaurantScanner.print_cheapest_restaurant([1, 5.35])}.to raise_error(SystemExit)
			end
		end
	end

	#restaurant
	context "Restaurant" do

		it "should have an ID and menu item" do
			new_restaurant = Restaurant.new(1, 2.00, "Test Item")
			new_restaurant.should be_kind_of(Restaurant)
			new_restaurant.id.should == 1
			new_restaurant.price.should == 2.00
			new_restaurant.menu_item.should == "Test Item"
		end

		it "find cheapest restaurant" do
			restaurants = RestaurantScanner.new(valid_csv_args)
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).should be_kind_of(Array)
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).should eq([3,2.0])
		end

		it "finds nil if order items have matching restaurants" do
			restaurants = RestaurantScanner.new(no_matching_restaurants_csv)
		    Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).should be_kind_of(NilClass)
		end

		it "find cheapest order for a value meal" do
			restaurants = RestaurantScanner.new(value_meal_csv)
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).should eq([9, 7.0])
		end

		it "returns the first restaurant for order item with same price" do
			restaurants = RestaurantScanner.new(order_item_same_price_csv)
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).first.should eq(1)
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).should eq([1,2.0])
		end

		it "should return the cheapest items with same price from an unsorted csv file" do
			restaurants = RestaurantScanner.new(unsorted_order_items)
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).first.should eq(4)
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).should eq([4,11.0])
		end

		it "return the chepeast cheapest item when with multiple item quantity" do
			restaurants = RestaurantScanner.new(multiple_item_quantity)
		    Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).first.should eq(7)
		    Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).should eq([7,7.00])
		end


	end


end
