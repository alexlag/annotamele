require_relative "annotamele/version"
require_relative "annotamele/string_helpers"
require_relative "annotamele/errors"
require_relative "annotamele/menu"
require_relative "annotamele/app_generator"
require_relative "annotamele/config_helpers"

class AnnotameLE


  def self.main(args)
    if args[0] == '-n' || args[0] == '--new'
      new_app
    elsif args[0] == '-v' || args[0] == '--version'
      display_version  
    else
      display_help
    end
  end
  
  
  def self.new_app
    menu = Menu.new
    @options = menu.new_app_menu
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
    puts "  --> create a new AnnotameLE app."
    puts
    puts "annotamele --version (or -v) :"
    puts "  --> display the AnnotameLE version"
    puts
  end
  
end