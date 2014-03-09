require_relative 'restaurant_error'
require_relative 'restaurant_scanner'
require_relative 'restaurant'

describe Restaurant do

	let(:valid_csv_args) {["./restaurant_app_test.csv", "steak_sandwich"]}
	let(:order_item_same_price_csv) {["./restaurant_app_test.csv", "coke"]}
	let(:no_matching_restaurants_csv)   {["./restaurant_app_test.csv", "Pepsi"]}
	let(:invalid_csv_args) {["./restaurant_app_invalid_test.csv"]}
	let(:invalid_price_csv_args) {["./restaurant_app_invalid_test.csv", "steak_sandwich" , "chicken_pizza"]}
	let(:no_csv_args) 	  {["./restaurant_app_test", "ham_sandwich", "burrito", "tofu_log"]}
	let(:value_meal_csv)  {["./jurgensville_price_list2.csv", "fancy_european_water", "extreme_fajita"]}

	#restaurant scanner
	context 'RestaurantScanner' do

		context "validations" do
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
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).should eq([6, 11.00])
		end

		it "returns the first restaurant for order item with same price" do
			restaurants = RestaurantScanner.new(order_item_same_price_csv)
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).first.should eq(1)
			Restaurant.find_cheapest_restaurant(restaurants.price_list, restaurants.items).should eq([1,2.0])
		end
	end


end
