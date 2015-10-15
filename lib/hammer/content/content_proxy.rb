module Hammer
  class ContentProxy
    @@variables = { }

    def initialize
    end

    def contentful
      @contentful ||= Hammer::ContentfulHelper.new(Settings.contentful)
    end

    def markdown(text)
      Hammer::MarkdownParser.new.parse(text) if text
    end

    # hack to return "registered variables"
    def method_missing(method_name, *arguments, &block)
      @@variables[method_name] || super
    end

    class << self
      def register_variable(name, value)
        @@variables[name] = value
      end

      def unregister_variable(name)
        @@variables.delete(name)
      end

      def add_paths(paths)
        @@variables['autogenerated_content_files'] ||= []
        @@variables['autogenerated_content_files'].concat(paths)
      end

      def find_file(filename)
        @@variables['autogenerated_content_files'].select do |path|
          path.match(filename)
        end.max_by(&:length)
      end
    end
  end
end