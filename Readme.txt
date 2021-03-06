
Problem Statement : 
Because it is the Internet Age, but also it is a recession, the Comptroller
of the town of Jurgensville has decided to publish the prices of every item
on every menu of every restaurant in town, all in a single CSV file
(Jurgensville is not quite up to date with modern data serialization
methods).  In addition, the restaurants of Jurgensville also offer Value
Meals, which are groups of several items, at a discounted price.

Since you are an expert software engineer, you decide to write a program
that accepts the town's price file, and a list of item labels that someone
wants to eat for dinner, and outputs the restaurant they should go to, and
the total price it will cost them.  It is okay to purchase extra items, as
long as the total cost is minimized.

Input
=====
Your program should accept the path to the file and any number of desired
items as command-line parameters, e.g.

% ./my_program data.csv item1 item2 item3

The file's format is as follows:

- for lines that define a price for a single item:
restaurant ID, price, item label

- for lines that define the price for a Value Meal (there can be any number of
items in a value meal)
restaurant ID, price, item 1 label, item 2 label, ...

All restaurant IDs are integers, all item labels are lower case letters and
underscores, and the price is a decimal number.

Output
======
When your program is able to produce a solution with the given arguments, it
should write the best restaurant's id and price to standard out as a
comma-delimited pair and terminate with an exit status of zero. For example:

% ./find_the_best_restaurant data.csv an_item
22,3.00
% echo $?
0

If multiple restaurants offer the best price, the restaurant with the lowest id wins.

If your program cannot produce a solution because no restaurant can fill the given order, the process should terminate with a non-zero exit status and write nothing to standard out. E.g.

% ./find_the_best_restaurant no_hamburgers.csv hamburger
% echo $?
1

Any additional output such as debugging or status messages should be written to standard error or activated by a command-line option.

Examples
========
Here are some sample data sets, program inputs, and the expected result:

Data File data.csv
1, 4.00, burger
1, 8.00, tofu_log
2, 5.00, burger
2, 6.50, tofu_log

% ./program data.csv burger tofu_log
2,11.50
% echo $?
0

=======

Data File data.csv
3, 4.00, chef_salad
3, 8.00, steak_salad_sandwich
4, 5.00, steak_salad_sandwich
4, 2.50, wine_spritzer

% ./program data.csv chef_salad wine_spritzer
% echo $?
1

=======

Data File data.csv
5, 4.00, extreme_fajita
5, 8.00, fancy_european_water
6, 5.00, fancy_european_water
6, 6.00, extreme_fajita, jalapeno_poppers, extra_salsa

% ./program data.csv fancy_european_water extreme_fajita
6,11.00
% echo $?
0

=======

Please include instructions for how to run your program with your submission.

Instruction and Requirements:

Ruby version  : ruby 1.9.2p320 (2012-04-20 revision 35421) [x86_64-darwin12.3.0]

RubyGems Used :
rspec (2.14.1)
rspec-core (2.14.7)
rspec-expectations (2.14.4)
rspec-mocks (2.14.4)

Instructions :

In order to run the different scenarios for the Restaurant App , different csv's exist for each case.

The following commands need to used to to test each of the cases . Please make sure that you are in the root of the app while you run this command.

1. Input : ruby cheapest_restaurant.rb ./jurgensville_price_list.csv ham_sandwich burrito tofu_log
	
2. Input : ruby cheapest_restaurant.rb ./jurgensville_price_list.csv fancy_european_water extreme_fajita

3. Input : ruby cheapest_restaurant.rb ./jurgensville_price_list.csv chef_salad wine_spritzer

Testing :
 All the tests have been written using rspec . To run the testcases execute

 1. rspec restaurant_spec.rb


 Design Details :

 Two classes have been create that work together to get the cheapest restaurant
 1. RestaurantScanner Class: 
 	a.This class scans the input command and creates an array of restaurants objects consisting of id , price and item label. 
 	b.This class validates the values within the csv file and also the command .
 	c.It writes the cheapest hotel to STDOUT along with the exit code.

 2. Restaurant Class:
    a. Take the array of the restaurants and ordered items and find the cheapest restaurants in 3 simple steps
       - step1: find all the restaurants that can fullfill the order
       - step2: calculate the order total for each fullfilling restaurant
       - step3: find and return the restaurant with minimum order total

  3. Also inline comments have been written for each function to explain the responsibility of each of the function.

  Assumptions :
  1. The CSV file being input should not have duplicate menu item. If tried with duplicate m both the menu items will be added up while calculating the total count.

  2. Its also assumed that when ordering multiple value meals only one item from the value meal will be passed in the input multiple times. If all the items are passed then each items will be uniqualy considered as different order.
  For Example : For a value meal containing extreme_fajita, jalapeno_poppers, extra_salsa
    a.To give 2 orders of value meal just pass in extreme_fajita 2 times.You need to pass all the items . 
    
    b.If pass more than one item , for example , extreme_fajita jalapeno_poppers  extreme_fajita jalapeno_poppers
    Then the program will create 4 orders.

 Known Improvements

 1. Extract tests, the CSV files and the main libraries into separate directories
 







