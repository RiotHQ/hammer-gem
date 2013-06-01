class Hammer

  class HammerFile
    
    attr_accessor :hammer_project
    attr_accessor :filename, :full_path, :output_filename, :output_path, :extension
    attr_accessor :raw_text, :text, :compiled_text
    attr_accessor :error_line, :error_message, :error_file, :error
    attr_accessor :compiled, :is_a_compiled_file, :source_files
    attr_accessor :messages, :todos
    attr_accessor :from_cache
    attr_accessor :compiled, :is_a_compiled_file

    def initialize(options={})
      @source_files = []
      @messages = []
      super()
      
      # This is an initializer because I have this as a function.
      self.filename = options.delete(:filename) if options[:filename]
      self.raw_text = options.delete(:text) if options[:text]
      self.full_path = options.delete(:full_path) if options[:full_path]

      if options[:hammer_project]
        @hammer_project = options.delete(:hammer_project)
      end
    end
    
    def filename=(filename)
      @filename = filename
      @extension = File.extname(@filename)[1..-1]
    end
    
    def output_filename
      @output_filename || Hammer.output_filename_for(self)
    end
    
    def raw_text
      if full_path
        @raw_text ||= File.open(full_path).read
      end
      @raw_text
    end

    # style.scss -> style.css    
    # blog/app.coffee -> blog/app.js
    def finished_filename
      new_extension = extension
      
      last_parser = Hammer.parsers_for_extension(@extension).last
      
      if last_parser
        new_extension = last_parser.finished_extension
        
        dirname = File.dirname(@filename)
        dirname = nil if dirname == "."
        
        path_components = [dirname, File.basename(@filename, ".*")]
        path = File.join(path_components.compact)
        
        "#{path}.#{new_extension}"
      else
        filename
      end
    end

  end
end