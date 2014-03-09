class RestaurantError < StandardError

	def initialize(msg)
		msg ||= "An error has occured" #failsafe incase msg hasnt been provided
		super(msg)
	end

end