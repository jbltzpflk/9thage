class IniParser
	@@pat = /^(?<key>\w*)=(?<value>.*)/
	def parse section,line
		linedata = @@pat.match line
		#puts @linedata.inspect
		key = linedata[:key]
		value = Regexp.last_match(:value)
		section[key] = value
	end
end
