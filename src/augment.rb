class Augment
	@@attribs = [:augtype, :id, :attributes, :userComments ]
	@@semisplits = [:attributes,:userComments]
	@@commasplits = []
	attr_accessor  *@@attribs

	def initialize gameSystem
		@gameSystem = gameSystem
	end

	def load_from_string s
		arr = s.split "\t", 12
		# p arr
		@@attribs.zip(arr[0...11]) {|a| instance_eval "@#{a[0]}=a[1]" }
		# puts "augtype #{@augtype}, id=#{@id} "
		
		# puts "loc attr= #{@localAttributes} \n ex attr= #{@externalAttributes}"
		# p @@semisplits
		# @@semisplits.each {|a| eval "puts #{a} "}
		@@semisplits.each {|a| instance_eval " @#{a} = @#{a}.split ';' " unless instance_eval "@#{a}.nil?" }
		@@commasplits.each {|a| instance_eval " @#{a} = @#{a}.split ',' " unless instance_eval "@#{a}.nil?" }
		# puts "attributes #{@attributes}"
		@attributes = @attributes.map! {|s| ' puts "attrib = #{l}" ' ; a = Attribute.new ; a.load_from_string s ; a }
		#puts " attributes #{@attributes}"
		# puts "attr= #{@attributes}"
		# @attributes.each do |a| puts "\t#{a} " ; end
		# p @userComments
	end
	
	def print
		puts "augtype #{@augtype}, id=#{@id} "
		@attributes.each do |a| puts "\t#{a} " ; end
		@userComments.each do |c| puts c ; end
	end

end