#require "xpotools/version"

module Xpotools
  # Your code goes here...
  class AOTElement
    attr_accessor :type, :name, :source
    
    def initialize(type, name)
      @type = type.downcase.to_sym
      @name = name
    end
    
    def inspect
      "#{type} : #{name}"
    end
  end
  
  
  class XPOParser
    
    attr_accessor :objects
    attr_accessor :source
    
    def initialize(source)
      @source = source
    end
    
    def parse
      @objects = []
      elt = false
      open = false
      curelt = ""
      name = ""
      @source.each_line do |line|
        if line =~ /\*{3}Element:\s*(\w*)/
          elt = true
          #p "#{line} : #{$1}"
        end
        if elt && line =~ /\s*(USERTYPE|CLASS|PROJECT)\s*#(\w*)/
          curelt = $1
          name = $2
          open = true
          #p "type : #{$1} name : #{$2}"
        end
        
        if open && line.match("END#{curelt}")
          open = false
          elt = false
          @objects << AOTElement.new(curelt, name)
          #p "end #{curelt}"
        end
          
      end
      
    end
    
    def inspect
      p "elts = #{@objects.size}"
      @objects.each{|elt| p elt.inspect}
    end
  end
  

end


