class Element
	@@attribs = [:id, :name, :abbrev, :category, :conflicts, :cost, :maxTaken, :slotsUsed, :isUnique, 
		:attributes, :comments, :report, :minTaken, :userComments ]
	@@semisplits = [:attributes, :comments, :report, :userComments]
	@@commasplits = [:conflicts]
	attr_accessor  *@@attribs

	def initialize gameSystem
		@gameSystem = gameSystem
	end

	def load_from_string s
		arr = s.split "\t", 14
		# p arr
		@@attribs.zip(arr[0...14]) {|a| instance_eval "@#{a[0]}=a[1]" }
		@isUnique = @isUnique ==1
		# puts "id=#{@id}, name=#{@name}, category=#{@category}, cost=#{@cost}, isUnique?=#{@isUnique}"
		
		# p @@semisplits
		# @@semisplits.each {|a| eval "puts #{a} "}
		@@semisplits.each {|a| instance_eval "@#{a} = @#{a}.split ';' " unless instance_eval "@#{a}.nil?" }
		@@commasplits.each {|a| instance_eval " @#{a} = @#{a}.split ',' " unless instance_eval "@#{a}.nil?" }
		@attributes = @attributes.map! {|l| ' puts "attrib = #{l}" ' ; la = Attribute.new ; la.load_from_string l ; la }
		#puts " attributes #{@attributes}"
		# puts "attr= #{@attributes}"
		# @attributes.each do |a| puts "\t#{a} " ; end
		# p @comments
		# p @report
		# p @userComments
	end
end