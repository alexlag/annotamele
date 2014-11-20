require "fileutils"
require_relative "ui_helpers"
require_relative "version"
require_relative "string_helpers"
require_relative "file_helpers"
require_relative "config_helpers"

class AppGenerator
  
  attr_accessor :options

  
  def initialize(options)
    @options = options
    @app_dir = Dir.pwd + "/#{@options[:app_name]}"
    @annotamele_dir = File.dirname(__FILE__)
  end
  
  
  def generate_app
    # Drop creation if necessary
    if !@options[:generate]
      wputs "App creation aborted...", :error
      new_line
      abort
    end
    
    # updating necessary global gems
    update_essential_gems
    
    # install Rails
    install_rails
    
    # copy foundation app to directory
    create_foundation

    # annotamele variables
    AnnotameleBuilder.build_annotamele(@app_dir, @options)
    
    # environment variables
    config_env_var
    
    # prod settings
    set_production
    
    # install gems
    bundle_install

    # create database
    create_database
    
    # save config
    ConfigHelpers.create_config(@app_dir, @options)
      
    # Summary
    new_line(2)
    wputs "----> #{@options[:rails_app_name]} created successfully!", :help
    new_line
    wputs "Run 'rails server' within #{@options[:app_name]} to start it.", :help
    new_line    
    
  end
  
  
  
  
  # Private/shortcut/alias methods
  
  private
  
  def update_essential_gems
    new_line
    wputs "----> Updating Rake & Bundler ... ", :info
    system "#{@options[:gem_command]} install rake --no-rdoc --no-ri"
    system "#{@options[:gem_command]} update rake"
    system "#{@options[:gem_command]} install bundler --no-rdoc --no-ri"
    system "#{@options[:gem_command]} update bundler"
    new_line
    wputs "----> Rake & Bundler updated to their latest versions.", :info

  rescue
    Errors.display_error("Required gems (rake & bundler) couldn't be updated properly. Stopping app creation.", true)
    abort

  end
  
  
  def install_rails
    new_line(2)
    wputs "----> Installing Rails #{@options[:rails_version]} ...", :info
    system "#{@options[:gem_command]} install rails -v #{@options[:rails_version]} --no-rdoc --no-ri"
    new_line
    wputs "----> Rails #{@options[:rails_version]} installed.", :info

  rescue
    Errors.display_error("Something went wrong and Rails #{@options[:rails_version]} couldn't be installed. Stopping app creation.", true)
    abort

  end
  
  
  def create_foundation
    FileUtils::mkdir_p @app_dir
    FileUtils.cp_r(@annotamele_dir + "/foundation/.", @app_dir)
    
  end
  
  
  def config_db
    new_line(2)
    wputs "----> Configuring database ...", :info
    
    FileUtils.cp_r(@annotamele_dir + "/assets/database/sqlite3.yml", @app_dir + "/config/database.yml")
    
    new_line
    wputs "----> Database configuration set.", :info
  end
  
  
  def config_env_var
    new_line(2)
    wputs "----> Setting environment variables ...", :info
    FileUtils.cp_r(@annotamele_dir + "/assets/config/application.yml", @app_dir + "/config")
            
    if @options[:email_settings]
      FileHelpers.replace_string(/ANNOTAMELE_SENDER/, @options[:email_config][:sender], @app_dir + "/config/application.yml")
      FileHelpers.replace_string(/ANNOTAMELE_SMTP_SERVER/, @options[:email_config][:smtp], @app_dir + "/config/application.yml")
      FileHelpers.replace_string(/ANNOTAMELE_MAILER_DOMAIN/, @options[:email_config][:domain], @app_dir + "/config/application.yml")
      FileHelpers.replace_string(/ANNOTAMELE_SMTP_PORT/, @options[:email_config][:port], @app_dir + "/config/application.yml")
      FileHelpers.replace_string(/ANNOTAMELE_SMTP_USERNAME/, @options[:email_config][:username], @app_dir + "/config/application.yml")
      FileHelpers.replace_string(/ANNOTAMELE_SMTP_PASSWORD/, @options[:email_config][:password], @app_dir + "/config/application.yml")
    end
      
    if @options[:production]
      FileHelpers.replace_string(/ANNOTAMELE_DOMAIN/, @options[:production_settings][:url], @app_dir + "/config/application.yml")
    end
    
    new_line
    wputs "----> Environment variables set.", :info
  end
  
  
  def set_production
    new_line(2)
    wputs "----> Production settings ...", :info

    if @options[:production_settings][:unicorn]
      FileUtils.cp_r(@annotamele_dir + "/assets/procfile/Procfile", @app_dir)
      FileUtils.cp_r(@annotamele_dir + "/assets/config/unicorn.rb", @app_dir + "/config")
      wputs "--> Unicorn config created."
    end
    new_line
    wputs "----> Production settings updated.", :info    
  end
  
  
  def set_app_name
    new_line(2)
    wputs "----> Setting app name ...", :info
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/config/routes.rb")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/Rakefile")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/app/helpers/application_helper.rb")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/app/views/layouts/application.html.erb")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/config/application.rb")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/config/environment.rb")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/config/environments/development.rb")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/config/environments/test.rb")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/config/environments/production.rb")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/config/initializers/secret_token.rb")
    FileHelpers.replace_string(/ANNOTAMELE_APP_NAME/, @options[:rails_app_name], @app_dir + "/config/initializers/session_store.rb")
    new_line
    wputs "----> App name set.", :info
  end
  
  
  def bundle_install
    new_line(2)
    wputs "----> Installing gems into 'vendor/bundle/' ...", :info
    Dir.chdir "#{@app_dir}" do
      system "bundle install --without production --path vendor/bundle"
    end
    new_line
    wputs "----> Gems installed in 'vendor/bundle/'.", :info
  end
  
  
  def create_database
    new_line(2)
    wputs "----> Creating database ...", :info
    Dir.chdir "#{@app_dir}" do
      system "#{@options[:rake_command]} db:create:all"
      system "#{@options[:rake_command]} db:migrate"
      system "#{@options[:rake_command]} db:seed"
    end
    new_line
    wputs "----> Database created.", :info
  end
  
  
  def wputs(text, highlight = :none)
    StringHelpers.wputs(text, highlight)
  end
  
  
  def new_line(lines=1)
    StringHelpers.new_line(lines)
  end

end
























