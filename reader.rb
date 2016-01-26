require 'yaml'

require 'src/abdefs.rb'
filename = "data/br/br.txt"
defsfilename = "data/wf8.txt"
ABDefs.loadGSDefs defsfilename
f = File.new(defsfilename)
deflines = f.readlines
f.close if f
f = File.new(filename)
lines = f.readlines
f.close if f
# print deflines[0]
# print lines[0]


# ABDefs.loadDefs(defsfilename)
