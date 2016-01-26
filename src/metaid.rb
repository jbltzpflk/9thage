# from http://ruby-metaprogramming.rubylearning.com/html/seeingMetaclassesClearly.html
class Object
  # The hidden singleton lurks behind everyone
  def metaclass; class << self; self; end; end
  def meta_eval &blk; metaclass.instance_eval &blk; end

  # Adds methods to a metaclass
  def meta_def name, &blk
    meta_eval { define_method name, &blk }
  end

  # Defines an instance method within a class
  def class_def name, &blk
    class_eval { define_method name, &blk }
  end
end


=begin
className = "Foo"
Object.const_set(className,Class.new)
className = Object.const_get(className)
className::module_eval{ define_method(:myname){
        puts("The name of my class is '#{self.class}'" ) }
    }

x = className.new
x.myname
=end

=begin
method_missing  defined to create the method if it doesnt exist, 
by looking up the method from the figure definition 

=end

=begin
Object.const_set("MaskedString", Class.new)

  # Define on self, since it's  a class method
  def self.method_missing(method_sym, *arguments, &block)
    # the first argument is a Symbol, so you need to_s it if you want to pattern match
    if method_sym.to_s =~ /^find_by_(.*)$/
      find($1.to_sym => arguments.first)
    else
      super
    end
  end

# It's important to know Object defines respond_to to take two parameters: the method to check, and whether to include private methods
# http://www.ruby-doc.org/core/classes/Object.html#M000333
def self.respond_to? method_sym, include_private = false
  method_check(method_sym) ? true : super
end



=end