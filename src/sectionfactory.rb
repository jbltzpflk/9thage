class SectionFactory
  def self.create_class(new_class, id, *fields)
    c = Class.new do
      define_class_method :add_record do
        
      end
      
      fields.each do |field|
        define_method field.intern do
          instance_variable_get("@#{field}")
        end
        define_method "#{field}=".intern do |arg|
          instance_variable_set("@#{field}", arg)
        end
      end
    end

    Kernel.const_set new_class, c
  end
end