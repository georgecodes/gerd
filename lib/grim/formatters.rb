require 'json'

module Grim
  module Formatters

    def self.find_formatter(file)
      return Grim::Formatters::Stdout.new unless file
      return Grim::Formatters::FileFormatter.new(file)
    end

    class Stdout

      def print(hash, options = {})
        puts JSON.pretty_generate(hash)
      end

    end

    class FileFormatter

      def initialize(file)
        @file = file
      end

      def print(hash, options = {})
        
        if(File.exists?(@file))
          puts "The file #{@file} already exists. Use -o or --overwrite" unless options[:overwrite]
          return unless options[:overwrite]
        end
        output_file = File.new(@file, "w")
        content = JSON.pretty_generate(hash)
        output_file.write(content)
      end

    end

  end
end