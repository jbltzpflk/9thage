require 'yaml'


def keyprint(key)
	print key.ljust(20)
end

def tagprint(tag)
	print tag.ljust(10)
end

def profileprint(army,key)
	begin
		print "#{army[key]['Profile']}"
	rescue
		print "No profile"
	end
end

def jprint(list)
	sep = ','
	print "[#{list.join(sep)}]"
end

def printRules(rules)
	sep = ','
	print "[#{rules.join(sep)}]"
end

def printKeys(figdef)
	print "---\n"
	sep = ','
	print figdef
	print "\n"
	# print "\t[#{keys.join(sep)}]\n"
end

def rulesprint(figdef)
	begin
		jprint figdef["Rules"]
	rescue
		print "\tNo rules \n"
	end
end

def tagsprint(figdef)
	begin
		jprint figdef["TypeTags"]
	rescue
		print "\tNo tags \n"
	end	
end

def keysprint(army,key)
	begin
		# print "#{key}\t"
		print key.ljust(20)
		# print(army[key])
		figdef = army[key]
		# print figdef.keys
		# rulesprint(figdef)
		tagsprint(figdef)
		print "\n"
	rescue
		print "\tNo keys \n"
	end
end

def figHasRule(figdef,rule)
	begin
		rules = figdef["Rules"]
		return rules.include? rule
	rescue 
		return false
	end
end

def figHasTag(figdef,tag)
	begin
		tags = figdef["TypeTags"]
		return tags.include? tag
	rescue 
		return false
	end
end

def hasRule(army,key,rule)
	return figHasRule(army[key],rule)
end


def hasTag(army,key,tag)
	return figHasTag(army[key],tag)
end

def taglister(army,taglist)
	for tag in taglist do
		for key in army.keys.select{|k| hasTag(army,k,tag) } do 
			keysprint(army,key) 
		end
	end
end



datadir = "C://9thage"
Dir.chdir(datadir)
version = 'WFB8'
armyname = 'DK'
armyfile = "#{armyname}-#{version}.yml"
data = File.open(armyfile)
allarmies = YAML::load(data)
print "army list loaded\n"
army = allarmies[armyname]

mylistfile = "samplearmyDK.yml"
mylist = YAML::load(File.open(mylistfile))
print "my army loaded\n"

print YAML::dump(mylist)

print mylist
print "\nregiments:\n"
for key in mylist do print mylist[key] end
print mylist.class
# for regiment in mylist[:regiments] do 
# 	print regiment.figures
# end

# for key in army.keys do profileprint(army,key) end
# for key in army.keys do rulesprint(army,key) end
# for key in army.keys.sort do keysprint(army,key) end
# for tag in ["Lord", "Hero", "Core", "Special", "Rare", "Mount"] do
# 	for key in army.keys.select{|k| hasTag(army,k,tag) } do 
# 		keysprint(army,key) 
# 	end
# end

# for tag in ["Skink", "Saurus", "Kroxigor", "Dino", "ColdOne"] do
# 	for key in army.keys.select{|k| hasTag(army,k,tag) } do 
# 		keyprint(key)
# 		tagprint(tag)
# 		profileprint(army,key) 
# 		print "\n"
# 	end
# end


# for rule in ["Lord", "Hero", "Core", "Special", "Rare", "Mount"] do
# 	for key in army.keys.select{|k| hasTag(army,k,tag) } do keysprint(army,key) end
# end

