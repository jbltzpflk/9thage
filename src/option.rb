class Option
	@@attribs = [:id, :name, :abbr, :category, :conflicts, :cost, :attributes, :notes, :report, :comments, :userComments ]
	@@semisplits = [:attributes, :notes, :report, :comments, :userComments]
	@@commasplits = [:conflicts]
	attr_accessor  *@@attribs

	def initialize gameSystem
		@gameSystem = gameSystem
	end

	def load_from_string s
		arr = s.split "\t", 11
		# p arr
		@@attribs.zip(arr[0...11]) {|a| instance_eval "@#{a[0]}=a[1]" }
		# puts "id=#{@id}, name=#{@name}, abbr=#{@abbr}, category=#{@category}, cost=#{@cost} "
		# puts "stats #{@stats}"
		# puts "composition Group #{@compositionGroup} item count=#{@itemCount}"
		# puts "links: #{@links}"
		
		# puts "loc attr= #{@localAttributes} \n ex attr= #{@externalAttributes}"
		# p @@semisplits
		# @@semisplits.each {|a| eval "puts #{a} "}
		# puts "links: #{@links}"
		@@commasplits.each {|a| instance_eval " @#{a} = @#{a}.split ',' "}
		# puts "links: #{@links}"
		@@semisplits.each {|a| instance_eval " @#{a} = @#{a}.split ';' " unless instance_eval "@#{a}.nil?" }
		# puts "local attributes #{@localAttributes}"
		@attributes = @attributes.map! {|l| ' puts "attrib = #{l}" ' ; la = Attribute.new ; la.load_from_string l ; la }
		#puts " attributes #{@attributes}"
		# puts "attr= #{@attributes}"
		# @attributes.each do |a| puts "\t#{a} " ; end
		# p @userComments
		self
	end
end