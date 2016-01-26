class Message
	@@attribs = [ :id, :name, :message ]
	attr_accessor *@@attribs
	def initialize gameSystem
		@gameSystem = gameSystem
	end

	def load_from_string s
		arr = s.split "\t", 3
		# p arr
		@@attribs.zip(arr[0...3]) {|a| instance_eval "@#{a[0]}=a[1]" }
		# puts "id=#{@id}, name=#{@name}\n\t #{@message}"
	end
	
	def to_hash
		{:id=>@id, :name=>@name, :message=>@message}
	end
	
end