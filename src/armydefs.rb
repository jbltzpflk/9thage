class ArmyDefs
	attr_accessor :version, :races, :units, :options, :items, :elements, :tweaks, :links, :augments, :messages
	
	def initialize gameSystem
		@gameSystem = gameSystem
		@version = []
		@races = {}
		@units = {}
		@options = {}
		@items = {}
		@elements = {}
		@links = []
		@tweaks = {}
		@messages = {}
		@augments = {}
	end
	def load filename
		f = File.new(filename)
		data = f.read
		data = data.split "^\n",10
		data.collect! {|d| d.split("\n").select {|l| l[0] != '~' }  }
		#data.collect! {|d| d.collect! {|l| l.split("~")[0]} ; d.select! {|l| l.length >0 } }
		@version = VersionInfo.new data[0]
		# p @version
		races = data[1].collect! {|s| r = Race.new ; r.load_from_string s ; @races[r.abbr] = r}
		# races.each {|r| @races[r.abbr] = r}

		units = data[2].collect! {|s|  u = Unit.new @gameSystem; u.load_from_string s ; @units[u.id] = u }
		# units.each {|u| @units[u.id] = u}
		# units.each {|u| p u.stats,u.id if u.stats.nil?  }
		# units.each {|u| puts YAML.dump u.to_hash   unless u.stats && u.stats['Num'] != '1'}
		# p data[3]
		# options = data[3].collect! {|s| o = Option.new @gameSystem; puts o.class; o.load_from_string s ; @options[o.id] = o}
		data[3].each {|s| o = Option.new @gameSystem; o.load_from_string s ; @options[o.id] = o}
		# options.each {|o| @options[o.id] = o}
		# p data[4]
		items = data[4].collect! {|s| i = Item.new @gameSystem; i.load_from_string s;  @items[i.id] = i }
		# items.each {|i| @items[i.id] = i}
		# p data[5]
		elements = data[5].collect! {|s| e = Element.new @gameSystem; e.load_from_string s; @elements[e.id] = e }
		# elements.each {|e| @elements[e.id] = e}
		
		# puts data[6]
		tweaks = data[6].collect! {|s| t = Tweak.new @gameSystem; t.load_from_string s; @tweaks[t.id] = t }
		# tweaks.each {|t| @tweaks[t.id] = t}
		
		# p data[7]
		links = data[7].collect! {|s| l = Link.new @gameSystem; l.load_from_string s; @links << l ; l }
		# links.each { |l| @links << l }

		# p data[8]
		augments = data[8].collect! {|s| a = Augment.new @gameSystem; a.load_from_string s; @augments[a.id] = a }
		# augments.each {|a| @augments[a.id] = a}
		
		# p data[9]
		messages =  data[9].collect! {|s| m = Message.new @gameSystem; m.load_from_string s; m }
		messages.each {|m| @messages[m.id] = m unless m.id == "^"}
		self
	end
end