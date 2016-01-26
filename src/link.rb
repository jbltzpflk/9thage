class Link
	@@attribs = [:unitId, :optionId, :linkNature ]
	
	attr_accessor  *@@attribs

	def initialize gameSystem
		@gameSystem = gameSystem
	end

	def load_from_string s
		arr = s.split "\t", 3
		@@attribs.zip(arr[0...3]) {|a| instance_eval "@#{a[0]}=a[1].to_sym" }
		# puts "unitId=#{@unitId}, optionId=#{@optionId}, linkNature=#{@linkNature} "
	end

	@@pat = /(?<optionId>.+)=(?<linkNature>.+)/
	def load_from_unit_and_link unit, string
		m = @@pat.match string
		@@attribs.zip([unit.id,  m[:optionId], m[:linkNature] ]) {|a| instance_eval "@#{a[0]}=a[1].to_sym" }
	end
end