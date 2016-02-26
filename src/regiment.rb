class Regiment
	def record(*args)
		@history.append @controller.newEvent *args
	end



end