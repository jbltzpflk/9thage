class Tweak
	@@attribs = [:id, :name, :abbrev, :category, :conflicts, :cost, :attributes, :comments, :notes, :report, :userComments ]
	@@semisplits = [:attributes, :comments, :notes, :report, :userComments]
	@@commasplits = [:conflicts]
	attr_accessor  *@@attribs

	def initialize gameSystem
		@gameSystem = gameSystem
	end

	def load_from_string s
		arr = s.split "\t", 11
		# p arr
		@@attribs.zip(arr[0...11]) {|a| instance_eval "@#{a[0]}=a[1]" }
		# puts "id=#{@id}, name=#{@name}, abbrev=#{@abbrev}, category=#{@category}, cost=#{@cost} "
		
		# puts "loc attr= #{@localAttributes} \n ex attr= #{@externalAttributes}"
		# p @@semisplits
		# @@semisplits.each {|a| eval "puts #{a} "}
		@@semisplits.each {|a| instance_eval " @#{a} = @#{a}.split ';' " unless instance_eval "@#{a}.nil?" }
		@@commasplits.each {|a| instance_eval " @#{a} = @#{a}.split ',' " unless instance_eval "@#{a}.nil?" }
		# p @conflicts
		@attributes = @attributes.map! {|s| ' puts "attrib = #{s}" ' ; a = Attribute.new ; a.load_from_string s ;  a }
		# @attributes.each {|a| puts "\t#{a.fullstring}"}
		# p @comments
		# p @notes
		# p @report
		# p @userComments
	end
	
	
end