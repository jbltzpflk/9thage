def regex_wrap s
	"(?<#{s}>.*)"
end
@@sections = [:version, :races, :units, :options, :items, :elements, :links, :tweaks, :messages, :augments]
joiner = '\\n\\^\\n?'
@@rex = @@sections.map {|s| regex_wrap s}.join joiner
@@rex = "/#{@@rex}/m"

#@@rex = %r{#{@@sections.map {|s| regex_wrap s}.join joiner}}
p @@rex
# puts @@sections.join joiner
regex = /(?<version>.*)\n\^\n?()/
@@pat = /^(?<key>\w*)=(?<value>.*)/


data = File.new('./data/br/br.txt').read
data = ['a','b','c','d','e','f','g','h','i','j','k'] . join "\n^\n"
puts data
sections = @@rex.match data
# p sections


rex1 = /(?<key>.*)\n\^\n?(?<value>.*)\n\^\n?(?<attrib>.*)/m
rex2 = "(?<key>.*)\n\^\n?(?<value>.*)\n\^\n?(?<attrib>.*)"
r = Regexp.new( rex2, Regexp::MULTILINE)
p rex1.match "foo\nbar\n^\nbla\n^\nbah"

p rex2.match "foo\nbar\n^bla\n^\n"