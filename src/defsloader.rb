
class PrematureEOFError < StandardError ; end
class UnimplementedSectionTypeError < StandardError ; end
class BadHeaderError < StandardError ; end
class FinalSectionError < StandardError ; end
class BadFieldError < StandardError ; end


class GameDef

	module IniParser
		@@pat = /^(?<key>\w*)=(?<value>.*)/
		def parse defs, section, line, keys
			linedata = @@pat.match line
			# puts line
			# puts @@pat.inspect
			# puts linedata.inspect
			# puts "========"
			# p keys
			key = linedata[:key]
			value = linedata[:value]
			# puts "#{section} : '#{key}' = '#{value}'"
			raise BadFieldError("#{section} : #{key} = #{value}") unless keys.include? key
			# puts defs.sections[section].inspect
			# puts defs.sections[section].length
			defs.sections[section][key] = value
		end

	end

	module StructParser
		def parse defs, section, line, keys
			defs.sections[section] ||= Array.new
			fields = line.split '|'
			fields.map! {|f| f.strip}
			# puts fields.inspect
			# puts Hash[keys.zip fields] if section == 'Stats'
			# puts "#{MetaDefs.loader_for(section)}" if section == 'Stats'
			record = MetaDefs.loader_for(section).new *fields
			# puts record.inspect if section == 'Stats'
			defs.sections[section] << record
		end
	end

	module SetParser
		def parse defs, section, line, keys
			value = line.strip
			defs.sections[section] << value
		end
	end

	module StructGroupParser
		def parse defs, section, line, keys
			raise UnimplementedSectionTypeError('StructGroups arent implemented in this version')
		end
	end

	module CSVParser
		def parse defs, section, line, keys
			items = line.split(',').map {|item| item.strip}
		end
	end

	module EndParser
		def parse defs, section, line, keys
			raise FinalSectionError.new('Definitions load complete.')
		end
	end

	attr_accessor :sections 

	def stripcomments line ; line.chomp! ; line.split('~')[0] ; end

	@@sections = {}
	@@parsers = {}
	MetaDefs.section_strings.each do
		|s| 
		# puts s
		# puts MetaDefs.parser_for(s)
		# puts  "Class.new do extend #{MetaDefs.parser_for(s).to_s} ; end" 
		@@parsers[s] =  eval "Class.new do extend #{MetaDefs.parser_for(s)} ; end" 
		#@@sections[s] = Metadefs.section_strings[s]
	end
	# puts @@parsers.inspect

	def initialize(filename)

		@sections = {}
		pat = /^\s+(?<linedata>.*)/
		f = File.new(filename)
		lines = f.readlines.collect {|l| stripcomments l } 
		lines.select! {|l| l.length > 0}
		section = "begin"
		lines.each  do |line|
			if 	linedata = pat.match(line)
				# puts linedata[:linedata].inspect
				@@parsers[section].send :parse, self, section, linedata[:linedata], MetaDefs.fields_for(section)
			else
				# puts line
				# puts @sections[section].inspect
				section = line.split()[0]
				# puts "#{section}:  #{MetaDefs.section_class_for section}.new"
				@sections[section] = eval "#{MetaDefs.section_class_for section}.new"
				# puts "section #{section}"
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
		# puts @sections['General'].inspect
		# puts @sections['Publish'].inspect
		# @sections['Stats'].each {|s| puts s.inspect }
		# @sections['Compositions'].each {|s| puts s.inspect}
		# @sections['Units'].each {|s| puts s.inspect }
		# puts @sections['options'].inspect
		# @sections['conflicts'].each {|s| puts s.inspect }
		# puts @sections['tweaks'].inspect
		# puts YAML.dump @sections['options']
		# puts @sections['sets'].inspect
		# @sections['items'].each  {|s| puts s.inspect }
		# puts @sections['end'].inspect


	end

	def getStats
		st = []
		@sections['Stats'].each {|s| st << s['abbr']}
		st
		#YAML.dump @sections['Stats']
		@sections['Stats'].collect {|s| s['abbr']}
	end


end
