require_relative "annotamele/version"
require_relative "annotamele/string_helpers"
require_relative "annotamele/errors"
require_relative "annotamele/options_menu"
require_relative "annotamele/options_file"
require_relative "annotamele/options"
require_relative "annotamele/app_generator"
require_relative "annotamele/config_helpers"

class AnnotameLE


  def self.main(args)
    if args[0] == '-n' || args[0] == '--new'
      new_menu
    elsif args[0] == '-f' || args[0] == '--file'
      new_from_file args[1]  
    elsif args[0] == '-v' || args[0] == '--version'
      display_version  
    else
      display_help
    end
  end
  
  
  def self.new_menu
    @options = OptionsMenu.new.options
    generator = AppGenerator.new(@options)
    generator.generate_app    
  end

  def self.new_from_file(path)
    @options = OptionsFile.new(path).options
    generator = AppGenerator.new(@options)
    generator.generate_app  
  end
  
  def self.display_version
    puts
    StringHelpers.wputs "AnnotameLE #{Version.current} (#{Version.current_date})", :info
    puts
  end

  
  def self.display_help
    puts
    StringHelpers.wputs "AnnotameLE usage:", :info
    StringHelpers.wputs "------------------", :info
    puts
    puts "annotamele --new (or -n) :"
    puts "  --> create a new AnnotameLE app with wizard."
    puts
    puts "annotamele --file <filepath> (or -f <filepath>) :"
    puts "  --> create a new AnnotameLE app with config file."
    puts
    puts "annotamele --version (or -v) :"
    puts "  --> display the AnnotameLE version"
    puts
  end
  
end