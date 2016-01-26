
require_relative "classfactory.rb"
$data_path = File.expand_path('../../data', __FILE__)

class PrematureEOFError < StandardError ; end
class BadHeaderError < StandardError ; end
class FinalSectionError < StandardError ; end

class DefEntry
	@@pat = /^\s+(?<linedata>.*)/
	def initialize(line)
		@linedata = @@pat.match(line)
		puts @linedata.inspect
	end
end
class PropDefEntry
	attr_accessor :key, :value
	@@pat = /^(?<key>\w*)=(?<value>.*)/
	def initialize(line)
		@linedata = @@pat.match line
		#puts @linedata.inspect
		@key = @linedata[:key]
		@value = Regexp.last_match(:value)
		p "#{@key} #{@value}"
	end
end

class OptionCategory
	attr_accessor :category
	@@pat =  /^(?<category>\S+)/
	def initialize(line)
		linedata = @@pat.match line
		#puts linedata.inspect
		#puts @@pat.inspect
		@category = linedata[:category]
	end
end

class RecordDefEntry
	def initialize(line,keys)
		fields = line.split '|'
		field0 = fields[0].gsub /^ +| +$/, ""
		rest = fields[1..-1].collect {|f| f.tr " ", "" }
		fields = [field0] + rest
		#puts fields.inspect
		record = Hash[keys.zip fields]
		#puts record.inspect
	end
end


class ABDefs 
	
	def self.loadMeta
		metafilename = "#{$data_path}/metadefs.yaml"
		puts metafilename
		metafile = File.new(metafilename)
		#rawmetadata = metafile.readlines
		@@metadefs = YAML.load_stream(metafile)
		@@metakeys = @@metadefs[0]
		@@metahash = @@metadefs[1]
		#puts @@metakeys.inspect
		@@defsData = Hash.new
		@@metakeys.each {|k| @@defsData[k] = Array.new }
		["General", "Publish"].each {|k| @@defsData[k] = Hash.new }
		{
			# Class name => [section, index of id field ]
			'Stat' => ['Stats', 0],
			'CompositionGroup' => ['Compositions', 1],
			'FigureType' => ['Units', 1],
			'OptionCategory' => ['options', 0],
			'ConflictGroup' => ['conflicts', 0],
			'Tweak' => ['tweaks', 0],
			'StatSet' => ['sets', 0],
			'ItemCategory' => ['items', 1]
		}.each { |k,v| 
			fields = @@metahash[v[0]]
			idpos = v[1]	#which field no is primary key
			ClassFactory.create_class k, *fields
		}
		@@defsData["end"] = nil
		#puts @@defsData.inspect
	end

	loadMeta

	def self.stripcomments line ; line.chomp! ; line.split('~')[0] ; end

	def self.isHeader? line ; /^\S/ =~ line ; end

	def self.processLine(section,line)
		if @@metakeys.include? section
			case section
			when "General", "Publish"
				p = PropDefEntry.new line
				#puts p.inspect
				@@defsData[section][p.key] = p.value
			when "Stats", "Compositions", "Units", "conflicts", "tweaks", "sets", "items"
				r =  RecordDefEntry.new line, @@metahash[section]
				@@defsData[section] << r
			when "options"
				# category = 
				@@defsData[section] << OptionCategory.new(line).category
			when "end"
				raise FinalSectionError.new('Definitions load complete.')
			end
		else
			raise BadHeaderError.new(section) 
		end
	end

	def self.loadGSDefs(gsdefsfilename)
		@@sections = {}
		@@pat = /^\s+(?<linedata>.*)/
		f = File.new(gsdefsfilename)
		gsdeflines = f.readlines.collect {|l| stripcomments l } 
		gsdeflines.select! {|l| l.length > 0}
		section = "begin"
		gsdeflines.each  do |line|
			if 	linedata = @@pat.match(line)
				#puts linedata[:linedata].inspect
				processLine(section, linedata[:linedata])
			else
				# puts line
				section = line.split()[0]
			end
		end
		# gsdeflines.select {|l| isHeader?(l)}.each {|l| puts l}
		# gsdeflines.each {|l| print (isHeader?(l) ? 'H' : 'E')}
		# gsdeflines.each {|l| puts l if isHeader? l}
	rescue BadHeaderError => msg
		puts "ERROR Bad Header #{msg}"
	rescue FinalSectionError 
		puts "End of file reached"
	ensure
		f.close if f
		# puts @@metahash.inspect
		# puts YAML.dump @@defsData
		# 
		# puts YAML.dump @@defsData["Stats"]
		# puts @@defsData["options"]
	end
	
	def parseGSDefs

	end


	def initialize(filename)
		# read in the defs file
		begin
			f = File.new(filename)
			@deflines = f.readlines
		ensure
			f.close unless f.nil?
		end

		# 
	end

	def parseLines
		nil
	end

end
