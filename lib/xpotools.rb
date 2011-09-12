#require "xpotools/version"

module Xpotools
  # Your code goes here...
  class AOTElement
    attr_accessor :type, :name, :source
    
    def initialize(type, name, src = "")
      @type = type.downcase.to_sym
      @name = name
      @source = src
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
      src = ""
      type = nil
      @source.each_line do |line|
        if line =~ /\*{3}Element:\s*(\w*)/
          src = ""
          name = ""
          curelt = ""
          open = false
          elt = true
          type = $1
        end
        
        if elt && line =~ /\s*(USERTYPE|ENUMTYPE|CLASS|PROJECT)\s*#(\w*)/
          curelt = $1
          name = $2
          open = true
        elsif elt && type =~ /(MCR|JOB)/
          if line =~ /\s*SOURCE\s*#(\w*)/
            name = $1
            open = true
            curelt = "SOURCE"
          end
        end

        
        if open && line.match("\s*END#{curelt}\s*")
          open = false
          elt = false
          src << line
          @objects << AOTElement.new(curelt, name, src)
        end
        
        if elt
          src << line
        end
          
      end
      
    end
    
    def inspect
      p "elts = #{@objects.size}"
      @objects.each{|elt| p elt.inspect}
    end
  end
  

end


