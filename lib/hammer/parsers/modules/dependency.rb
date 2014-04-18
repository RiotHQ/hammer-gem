module Hammer
  module Dependency
    def add_wildcard_dependency(tag)
    end

    def find_file_with_dependency(tag, extension=nil)
      find_files(tag, extension)[0]
    end

    def find_files_with_dependency(tag, extension=nil)
      find_files(tag, extension)
    end
  end
end