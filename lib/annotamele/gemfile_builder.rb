require "fileutils"
require_relative "ui_helpers"
require_relative "version"
require_relative "string_helpers"
require_relative "file_helpers"
require_relative "config_values"

module GemfileBuilder
  BCRYPT = "3.1.9"
  DEVISE = "3.4.1"
  JBUILDER = "2.2.4"
  SQLITE3 = "1.3.10"
  TURBOLINKS = "2.5.1"
  
  
  def self.build_gemfile(app_dir, options)
    new_line(2)
    wputs "----> Generating Gemfile ...", :info
        
    annotamele_dir = File.dirname(__FILE__)
    add_gem = ""
    
    # Copy base Gemfile
    FileUtils.cp_r(annotamele_dir + "/assets/gemfile/Gemfile", app_dir)
    
    # Set Ruby version
    FileHelpers.replace_string(/BRICK_RUBY_VERSION/, options[:ruby_version], app_dir + "/Gemfile")
    
    # Database
    FileHelpers.add_to_file(app_dir + "/Gemfile", "# SQLite 3\ngem 'sqlite3', 'BRICK_SQLITE3_VERSION'")
    
    # Devise
    FileHelpers.add_to_file(app_dir + "/Gemfile", "# Devise: https://github.com/plataformatec/devise\ngem 'devise', 'BRICK_DEVISE_VERSION'")
    
    # Unicorn
    FileHelpers.add_to_file(app_dir + "/Gemfile", "# Unicorn: http://unicorn.bogomips.org\ngroup :production do\n  gem 'unicorn'\nend")
    
    # Set gem versions
    FileHelpers.replace_string(/BRICK_BCRYPT_VERSION/, BCRYPT, app_dir + "/Gemfile")
    FileHelpers.replace_string(/BRICK_DEVISE_VERSION/, DEVISE, app_dir + "/Gemfile")
    FileHelpers.replace_string(/BRICK_FIGARO_VERSION/, FIGARO, app_dir + "/Gemfile")
    FileHelpers.replace_string(/BRICK_JBUILDER_VERSION/, JBUILDER, app_dir + "/Gemfile")
    FileHelpers.replace_string(/BRICK_RAILS_VERSION/, options[:rails_version], app_dir + "/Gemfile")
    FileHelpers.replace_string(/BRICK_SQLITE3_VERSION/, SQLITE3, app_dir + "/Gemfile")
    FileHelpers.replace_string(/BRICK_TURBOLINKS_VERSION/, TURBOLINKS, app_dir + "/Gemfile")
    
    new_line
    wputs "----> Gemfile generated.", :info
    
  rescue
    Errors.display_error("Something went wrong and the Gemfile couldn't be generated. Stopping app creation.", true)
    abort
    
  end
  
  def self.wputs(text, highlight = :none)
    StringHelpers.wputs(text, highlight)
  end
  
  
  def self.new_line(lines=1)
    StringHelpers.new_line(lines)
  end
  
  
end