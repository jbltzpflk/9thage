class VersionInfo
	attr_accessor :description, :version, :author, :lock, :comments
	def initialize lines
		@description = lines[0].split("Description:")[1].lstrip
		@version = lines[1].split("Version:")[1].lstrip
		@author = lines[2].split("Author:")[1].lstrip
		@lock = lines[3].strip.downcase == 'lock'
		@comments = lines[(@lock ? 4 : 3)..-1].join "\n"
	end
end