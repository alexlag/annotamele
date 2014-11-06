require "fileutils"
require_relative "ui_helpers"
require_relative "version"
require_relative "string_helpers"
require_relative "file_helpers"
require_relative "config_values"

module AuthBuilder

  def self.build_auth(app_dir, options)
    new_line(2)
    wputs "----> Generating authentication scheme ...", :info
    
    rbricks_dir = File.dirname(__FILE__)
    add_string = ""
    
    # Model
    FileUtils.cp_r(rbricks_dir + "/assets/models/devise_email/user.rb", app_dir + "/app/models")
    wputs "--> User model created."
    
    # Migration
    FileUtils.cp_r(rbricks_dir + "/assets/migrations/devise_email/20141010133701_devise_create_users.rb", app_dir + "/db/migrate")
    wputs "--> Migration created."
    
    # Seeds
    FileUtils.rm(app_dir + "/db/seeds.rb")
    FileUtils.cp_r(rbricks_dir + "/assets/seeds/devise_email/seeds_test_users.rb", app_dir + "/db/seeds.rb")
    wputs "--> Seeds created."
    
    # Admin Controllers
    FileUtils.mkdir_p(app_dir + "/app/controllers/admin")
    FileUtils.cp_r(rbricks_dir + "/assets/controllers/admin/base_controller.rb", app_dir + "/app/controllers/admin/base_controller.rb")
    FileUtils.cp_r(rbricks_dir + "/assets/controllers/admin/devise_email/users_controller.rb", app_dir + "/app/controllers/admin/users_controller.rb")
    wputs "--> User admin controllers created."
    
    # Controllers
    FileUtils.cp_r(rbricks_dir + "/assets/controllers/pages_controller.rb", app_dir + "/app/controllers/pages_controller.rb")
    FileUtils.rm(app_dir + "/app/controllers/application_controller.rb")
    FileUtils.cp_r(rbricks_dir + "/assets/controllers/devise_email/application_controller.rb", app_dir + "/app/controllers/application_controller.rb")
    wputs "--> Controllers created."
    
    # Admin Views
    FileUtils.mkdir_p(app_dir + "/app/views/admin")
    FileUtils.mkdir_p(app_dir + "/app/views/admin/base")
    FileUtils.mkdir_p(app_dir + "/app/views/admin/users")
    FileUtils.cp_r(rbricks_dir + "/assets/views/admin/base/devise_email/index.html.erb", app_dir + "/app/views/admin/base")
    FileUtils.cp_r(rbricks_dir + "/assets/views/admin/users/devise_email/index.html.erb", app_dir + "/app/views/admin/users")
    FileUtils.cp_r(rbricks_dir + "/assets/views/admin/users/devise_email/edit.html.erb", app_dir + "/app/views/admin/users")
    wputs "--> Admin views created."
    
    # Devise views
    FileUtils.mkdir_p(app_dir + "/app/views/devise")
    FileUtils.cp_r(rbricks_dir + "/assets/views/devise/devise_email/.", app_dir + "/app/views/devise")
    wputs "--> Devise views created."
    
    # Links views
    FileUtils.rm(app_dir + "/app/views/layouts/_navigation_links.html.erb")
    FileUtils.cp_r(rbricks_dir + "/assets/views/layouts/_navigation_links.html.erb", app_dir + "/app/views/layouts")
    wputs "--> Navbar links created."
        
    # Protected page
    FileUtils.cp_r(rbricks_dir + "/assets/views/pages/inside.html.erb", app_dir + "/app/views/pages")
    wputs "--> Protected view created."
    
    # Devise initializer
    FileUtils.cp_r(rbricks_dir + "/assets/config/initializers/devise_email/devise.rb", app_dir + "/config/initializers")
    wputs "--> Devise initializer created."
    
    # Routes
    FileUtils.rm(app_dir + "/config/routes.rb")
    FileUtils.cp_r(rbricks_dir + "/assets/config/routes.rb", app_dir + "/config")
    wputs "--> Routes created."
    
    # Allow signup
    FileHelpers.replace_string(/BRICK_ALLOW_SIGNUP/, ':registerable,', app_dir + "/app/models/user.rb")
    FileHelpers.replace_string(/BRICK_ALLOW_SIGNUP_LINK/, '<li><%= link_to "Sign up", new_user_registration_path %></li>', app_dir + "/app/views/layouts/_navigation_links.html.erb")
    FileHelpers.replace_string(/BRICK_ALLOW_EDIT_LINK/, '<li><%= link_to "Edit your account", edit_user_registration_path %></li>', app_dir + "/app/views/layouts/_navigation_links.html.erb")
    FileHelpers.replace_string(/BRICK_ALLOW_SIGNUP_LINKS/, FileHelpers.get_file(:brick_allow_signup_links), app_dir + "/app/views/devise/shared/_links.erb")
    wputs "--> User registration options set."
    
    new_line
    wputs "----> Authentication scheme generated.", :info
    
    
  rescue
    Errors.display_error("Something went wrong and the authentication scheme couldn't be generated. Stopping app creation.", true)
    abort
    
  end
  
  
  def self.wputs(text, highlight = :none)
    StringHelpers.wputs(text, highlight)
  end
  
  
  def self.new_line(lines=1)
    StringHelpers.new_line(lines)
  end
  
end


























