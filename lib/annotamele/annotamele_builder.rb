require "fileutils"
require_relative "ui_helpers"
require_relative "version"
require_relative "string_helpers"
require_relative "file_helpers"
require_relative "config_values"

module AnnotameleBuilder

  def self.build_annotamele(app_dir, options)
    new_line(2)
    wputs "----> Generating AnnotameLE initializer ...", :info
        
    annotamele_dir = File.dirname(__FILE__)
    add_gem = ""
    
    # Copy base initializer
    FileUtils.cp_r(annotamele_dir + "/assets/config/initializers/annotamele.rb", app_dir + "/config/initializers/")
    
    # Set variables
    FileHelpers.replace_string(/ANNOTAMELE_TYPES/, generate_types_builder(options[:annotamele][:types]), app_dir + "/config/initializers/annotamele.rb")

    # Make seed file
    FileUtils.cp_r(options[:annotamele][:dataset], app_dir + "/db/seed_data.json")
    
    new_line
    wputs "----> AnnotameLE initializer generated.", :info
    
  # rescue
  #   Errors.display_error("Something went wrong and the AnnotameLE initializer couldn't be generated. Stopping app creation.", true)
  #   abort
    
  end

  def self.generate_types_builder(types)
    types.map { |type| 
      %Q/AnswerTypes.#{type[:name]}(#{type[:params].to_s[1..-2]})/
    }.join(",\n")
  end
  
  def self.wputs(text, highlight = :none)
    StringHelpers.wputs(text, highlight)
  end
  
  
  def self.new_line(lines=1)
    StringHelpers.new_line(lines)
  end
  
  
end