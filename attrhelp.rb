require 'yaml'

def one_shortdesc s, attr_type
	a = s.split "\t"
	[a[0], {:shortdesc=>a[1], :attr_type=>attr_type}]
end

def one_longdesc s
	#p s
	s.strip!
	return if s.length == 0
	lines = s.split "\n" 
	syntax = lines[0]
	# puts lines
	
	attr_id = syntax.slice(0...4)
	rest = lines[1..-1].join "\n"
	# puts syntax
	[attr_id, {:attr_id=>attr_id, :syntax=>syntax, :longdesc=>rest.strip}]
end

data = STDIN.read
sections = data.split "\n---\n"
sections.map! {|s| s.split "\n...\n:"}
# sections.each {|s| puts s[0].split("\n")[0]}

data = Hash.new{}

sections.collect! { |s|  {:shortdesc => s[0].split("\n"), :longdesc => s[1].split("\n:")} }
sections.each { 
	|s| 
	# puts [s.class, s[:shortdesc].class, s[:longdesc].class ].inspect
	s[:attr_type] = s[:shortdesc][0].slice(1..-1).to_sym 
	# p s[:attr_type]
	# p s[:attr_type] 
	short_d = Hash[ s[:shortdesc][1..-1].collect {|d| one_shortdesc d, s[:attr_type] }  ]
	# puts [s.class, s[:shortdesc].class, s[:longdesc].class ].inspect
	# p s[:shortdesc]
	long_d = Hash[ s[:longdesc].collect {|d| one_longdesc d}  ]
	# p s.keys
	# p short_d.keys
	# p long_d.keys
	data[s[:attr_type]] = Hash[ short_d.keys.collect { |k| [ k, short_d[k].merge(long_d[k]) ] } ]
	# p data[s[:attr_type]].keys
	# p long_d["skip"]
	# p data[s[:attr_type]]["skip"]
	# p data[s[:attr_type]].first
}

# puts YAML.dump sections[1]

x = sections[0]
#p Hash[ x[:shortdesc].collect {|d| one_shortdesc(d) } ]
# puts YAML.dump x[:shortdesc]["xbrk"]
# puts YAML.dump x[:longdesc]["xbrk"]
# puts "========================"
### puts YAML.dump data[:race_attrs]["xbrk"]  #["accu"]
puts YAML.dump data