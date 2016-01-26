require 'yaml'

require 'src/metadefs.rb'
require 'src/defsloader.rb'
require 'src/versioninfo.rb'
require 'src/attribute.rb'
require 'src/race.rb'
require 'src/unit.rb'
require 'src/option.rb'
require 'src/item.rb'
require "src/element.rb"
require 'src/tweak.rb'
require 'src/link.rb'
require 'src/message.rb'
require 'src/augment.rb'
#tweak
#message
require 'src/armydefs.rb'
armies = %w[ae br cd ch cl cr dk dm do dw em et he ks lz mc mg og ok pk sk tk ul vm we]
armyfiles = armies.collect { | a | "data/#{a}/#{a}.txt" }
# p armies
# p armyfiles

filename = "data/br/br.txt"
# filename = "data/tk/tk.txt"
defsfilename = "data/wf8.txt"
defs = GameDef.new defsfilename

p defs.getStats

armylists = {}
# armyfiles.each {|f| p f; ArmyDefs.new(defs).load f }

fields = %w[races units options items elements tweaks links messages augments]
puts "army, #{fields.join ', ' }"
armies.each do 
	|a|
	f =  "data/#{a}/#{a}.txt"
	s = a.to_sym
	ad = ArmyDefs.new(defs).load f
	armylists[s] = ad
	el = fields.collect {|s1| [eval("ad.#{s1}.length.to_s"), s1].join " "}
	el2 = fields.collect {|s1| eval("ad.#{s1}.length.to_s")}
	
	puts "#{a}, #{el.join ', ' }"
end
armylists[:dw].items.each {|i|  i[1].print; puts "\n"}
# army.load armyfiles[1]
# army.load armyfiles[2]