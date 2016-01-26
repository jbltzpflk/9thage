class Item
	@@attribs = [:id, :name, :category, :conflicts, :cost, :numAvail, :attributes, :comments, :notes, :report, :userComments ]
	@@semisplits = [:attributes, :comments, :notes, :report, :userComments]
	@@commasplits = [:conflicts]
	attr_accessor  *@@attribs

	def initialize gameSystem
		@gameSystem = gameSystem
	end

	def load_from_string s
		arr = s.split "\t", 12
		# p arr
		@@attribs.zip(arr[0...11]) {|a| instance_eval "@#{a[0]}=a[1]" }
		# puts "id=#{@id}, name=#{@name}, category=#{@category}, cost=#{@cost} "
		
		# puts "loc attr= #{@localAttributes} \n ex attr= #{@externalAttributes}"
		# p @@semisplits
		# @@semisplits.each {|a| eval "puts #{a} "}
		@@semisplits.each {|a| instance_eval " @#{a} = @#{a}.split ';' " unless instance_eval "@#{a}.nil?" }
		@@commasplits.each {|a| instance_eval " @#{a} = @#{a}.split ',' " unless instance_eval "@#{a}.nil?" }
		# puts "attributes #{@attributes}"
		@attributes = @attributes.map! {|l| ' puts "attrib = #{l}" ' ; la = Attribute.new ; la.load_from_string l ; la }
		#puts " attributes #{@attributes}"
		# puts "attr= #{@attributes}"
		# @attributes.each do |a| puts "\t#{a} " ; end
		# p @comments
		# p @notes
		# p @report
		# p @userComments
		self
	end

	def print
		puts "id=#{@id}, name=#{@name}, category=#{@category}, cost=#{@cost} "
		attributes.each {|a| a.print}
		[@comments, @notes, @report, @userComments].each {|s| s.each {|l| puts l} }
	end

end