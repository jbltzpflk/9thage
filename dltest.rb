require 'src/defsloader.rb'
class Foo; extend IniParser ; attr_accessor :b ; end
class Foo; def oneline line ; Foo.parse @b,line, ["M","WS","BS"] ; end ; end
class Foo; def initialize ; @b = Hash.new ; end ; end
p = Foo.new
puts p.inspect
p.oneline "M=5"
puts p.inspect
p.oneline "WS=3"
puts p.inspect
p.oneline "xyz=4"
puts p.inspect
