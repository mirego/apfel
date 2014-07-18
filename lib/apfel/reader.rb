module Apfel
  # Class for reading in files and returning an array of its content
  class Reader
    # Reads in a file and returns an array consisting of each line of input
    # cleaned of new line characters
    def self.read(file)
      File.open(file, 'r') do |f|
        content = f.read.force_encoding('UTF-8')

        # File is utf16, let’s fix this.
        if content.chars.first == "\xFF".force_encoding('UTF-8')
          ec = Encoding::Converter.new('UTF-16LE', 'UTF-8')
          content = ec.convert content
        end

        # remove the BOM that can be found at char 0 in UTF8 strings files
        if content.chars.first == "\xEF\xBB\xBF".force_encoding('UTF-8')
          content.slice!(0)
        end

        content.each_line.inject([]) do |content_array, line|
          line.gsub!("\n","")
          content_array.push(line)
        end
      end
    end
  end
end
