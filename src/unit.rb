class Unit
	@@attribs = [:id, :name, :abbr, :compositionGroup, :unitType, :category, :size, :cost, :itemCount, :localAttributes, 
		:externalAttributes, :links, :notes, :report, :comments, :userComments ]
	@@semisplits = [:localAttributes, :externalAttributes, :notes, :report, :comments, :userComments]
	@@commasplits = [:links]
	attr_accessor  *@@attribs
	
	attr_reader :statnames, :gameSystem

	def initialize gameSystem
		@gameSystem = gameSystem
	end

	def stats
		p @stats
		@stats
	end

	def load_from_string s
		statnames = @gameSystem.getStats
		arr = s.split "\t", 16 + statnames.length
		# fixedattrs = arr[0...16]
		@@attribs.zip(arr[0...16]) {|a| instance_eval "@#{a[0]}=a[1]" }

		
		# puts "id=#{@id}, abbr=#{@abbr}, name=#{@name}, unit type=#{@unitType} size=#{@size} cost=#{@cost} "
		# puts "stats #{@stats}"
		# puts "#{@id} #{@stats[11..-1]}"
		# puts "composition Group #{@compositionGroup} item count=#{@itemCount}"
		# puts "links: #{@links}"
		@links = @links.split ","
		puts "#{@id} links: #{@links}" unless @links.length == 0
		# puts "loc attr= #{@localAttributes} \n ex attr= #{@externalAttributes}"
		# p @@semisplits
		# @@semisplits.each {|a| eval "puts #{a} "}
		@@semisplits.each {|a| instance_eval " @#{a} = @#{a}.split ';' "}
		# puts "local attributes #{@localAttributes}"
		@localAttributes = @localAttributes.map! {|l| ' puts "loc = #{l}" ' ; la = Attribute.new ; la.load_from_string l ; la }
		# puts "local attributes #{@localAttributes}"
		@externalAttributes = @externalAttributes.map! {|e| ' puts "ext = #{e} " '; ea = Attribute.new ; ea.load_from_string e ; ea }
		# puts "loc attr= #{@localAttributes} \n ex attr= #{@externalAttributes}"
		# p @userComments

		@stats = Hash[statnames.zip arr[16..-1]]
		# puts @id
		# puts "name=#{@name}, cp=#{@stats['Cp']}" if @stats['Cp'].to_i > 0
		# puts "name=#{@name}, num=#{@stats['Num']}" if @stats['Num'].to_i != 1
		# puts @stats
		
		self
	end

	def stats
	end

	def to_hash
		h = Hash[ @@attribs.zip @@attribs.collect {|a| instance_eval "@#{a}"} ]
		h[:localAttributes].map! { |att| att.to_hash } 
		h[:externalAttributes].map! { |att| att.to_hash } 
		h[:stats] = @stats
		h
	end
end