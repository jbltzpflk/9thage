class Race
	@@attribs = [:name, :abbr, :isShared, :allies, :allyGroup, :breakdownList, :itemsAllowed, :attributes, :userComments]
	@@semisplits = [:attributes, :userComments]
	@@commasplits = [:itemsAllowed, :allies]
	attr_accessor  *@@attribs

	def load_from_string s
		arr = s.split "\t", 9
		# p arr
		@@attribs.zip(arr[0...9]) {|a| instance_eval "@#{a[0]}=a[1]" }
		@isShared = @isShared ==1
		# puts "Name: #{@name}, Abbreviation: #{@abbr}, Is Shared?: #{@isShared}"
		
		@breakdownList = Hash[ @breakdownList.split(',').collect {|b| b.split ':'} ]
		@@semisplits.each {|a| instance_eval " @#{a} = @#{a}.split ';' " unless instance_eval "@#{a}.nil?" }
		@@commasplits.each {|a| instance_eval " @#{a} = @#{a}.split ',' " unless instance_eval "@#{a}.nil?" }
		@attributes = @attributes.map! {|l| ' puts "attrib = #{l}" ' ; la = Attribute.new ; la.load_from_string l ; la }
		
		# @attributes = @attributes.split(';').collect {|s| Attribute.new().load_from_string s }
		# puts "Allies: #{@allies} , Ally Group: #{@allyGroup.inspect}"
		# p @breakdownList
		# puts "Special Item Groups: #{@itemsAllowed}"  
		# @attributes.each { |a| puts a }
		# p @userComments
	end

	def load_from_array *arr
		@@attribs.zip(arr) {|a| instance_eval "@#{a[0]}=a[1]" }
		@isShared = @isShared ==1
		@breakdownList = Hash[ @breakdownList.split(',').collect {|b| b.split ':'} ]
		@itemsAllowed = @itemsAllowed.split(',')
		@allies = @allies.split(',')
		@attributes = @attributes.split(';').collect {|s| Attribute.new().load_from_string s }
		# p "Name: #{@name}, Abbreviation: #{@abbr}, Is Shared?: #{@isShared}"
		# puts "Allies: #{@allies} , Ally Group: #{@allyGroup.inspect}"
		p @breakdownList
		# puts "Special Item Groups: #{@itemsAllowed}"  
		# @attributes.each { |a| puts a }
		p @userComments
	end
end