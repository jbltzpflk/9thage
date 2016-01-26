=begin
load meta-definitions from a yaml file

=end

require 'set'
require 'yaml'
$data_path = File.expand_path('../../data', __FILE__)


class MetaDefs

	def self.symOrNil s
		s ? s.to_sym : nil
	end	

	def self.classMaker metadef
		fields = metadef["fields"].map {|f| f.to_sym} if metadef['fields']
		case metadef['supername']
		when "Struct"
			Struct.new(metadef["classname"],*fields)
		when "Set"
			Set
		else
			Object
		end
	end

	def self.section_keys ; @@section_keys ; end	
	def self.section_strings ; @@section_strings; end
	def self.class_for section ; @@classes[section] ; end
	def self.parser_for section ; @@parsers[section] ; end
	def self.loader_for section ; @@loaders[section] ; end
	def self.fields_for section ; @@fields[section] ; end
	def self.section_class_for section; @@section_classes[section] ; end

	# metafilename = "#{$data_path}/metadefs.yaml"
	metafilename = "#{$data_path}/md.yaml"
	## puts metafilename
	metafile = File.new(metafilename)
	@@metadefs = YAML.load_stream(metafile)[0]
	@@metadefs.map! {|m| m['loader'] = classMaker(m) ; m}
	# @@classes = @@metadefs.collect {|m| {:class=>symOrNil(m["classname"]),:super=>symOrNil(m["supername"])} }
	@@classes = Hash[ @@metadefs.collect {|m| [m['section'], m['loader']]} ]
	@@loaders = {}
	@@section_keys = []
	@@section_strings = []
	@@section_classes = Hash[ @@metadefs.collect {|m| [m['section'], m['sectionclass']]} ]
	@@parsers = {}
	@@fields = {}
	@@metadefs.each {
		|m| 
		section = m['section']
		@@section_strings << section
		@@section_keys << m['sectionkey']
		@@parsers[section] = m['parser']
		@@loaders[section] = m['loader']
		@@fields[section] = m['fields']
		# puts m.inspect
		# puts "#{m['section']}, #{m['sectionkey']}, #{m['parser']},  #{m['loader']}, #{m['sectionclass']}"
		# puts "	#{m['fields'].join '|'}" if m['fields']
	}
	# puts @@section_keys.inspect
	# puts @@section_strings.inspect
	# puts @@section_classes.inspect
	# puts @@parsers.inspect
	# puts @@classes.inspect
end
# puts MetaDefs.section_keys
# puts "-------"