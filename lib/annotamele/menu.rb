require_relative "ui_helpers"
require_relative "version"
require_relative "string_helpers"
require_relative "config_values"
require "etc"

class Menu
  
  attr_accessor :options
  
  
  def initialize
    @options = {annotamele_version: Version.to_s}
  end
  
  
  def new_app_menu
    # WELCOME
    @options[:rails_version] = ConfigValues.rails_version    
    new_line
    wputs '*****************************'
    wputs "*                           *"
    wputs "*     AnnotameLE #{Version.to_s}     *"
    wputs "*                           *"
    wputs "*     using Rails #{@options[:rails_version]}     *"
    wputs "*                           *"
    wputs '*****************************'
    new_line(2)

    # APP NAME
    wputs "1. Your Rails App Name"
    wputs "----------------------"
    wputs "First of all, you need to give a name to your new app. I'll create it in #{Dir.pwd}/. Of course, only use a valid Rails app name.", :help
    new_line
    wputs "- What do you want to name your app?"
    default_name = "annotamele_#{4.times.map{ 0 + Random.rand(9)}.join}"
    wputs "(default: #{default_name})"
    @options[:app_name] = StringHelpers.sanitize(answer("App name:"))
    @options[:app_name] = default_name if @options[:app_name].length < 1
    @options[:rails_app_name] = StringHelpers.convert_to_app_name(@options[:app_name])
    new_line(2)
    
    # DEVELOPMENT ENVIRONMENT
    wputs "2. Your Development Environment"
    wputs "-------------------------------"
    
    # ruby version
    @options[:ruby_version] = "2.1.4"
    
    # gem command
    wputs "On some systems, you can't install gems by issuing a simple 'gem install name_of_gem' command but need to prefix it with 'sudo' and issue 'sudo gem install name_of_gem'. If this is the case, you most likely will need to input your password at some point.", :help
    new_line
    wputs "- How do you usually install new gems?"
    wputs "1. gem install name_of_gem (default)", :info
    wputs "2. sudo gem install name_of_gem", :info
    @options[:gem_command] = answer() == "2" ? "sudo gem" : "gem"
    new_line(2)
    
    # rake command
    wputs "Do you usually run rake tasks by prefixing them with 'bundle exec'? I also need to know that.", :help
    new_line
    wputs "- How do you usually run rake tasks?"
    wputs "1. rake some_task (default)", :info
    wputs "2. bundle exec rake some_task", :info
    @options[:rake_command] = answer() == "2" ? "bundle exec rake" : "rake"
    new_line(2)
    
    # development database
    @options[:development_db] = "sqlite"
    @options[:db_config] = {}
    new_line(2)
    
    @options[:db_config][:server] = nil
    @options[:db_config][:port] = nil
    @options[:db_config][:name] = nil
    @options[:db_config][:username] = nil
    @options[:db_config][:password] = nil
    
    
    # APP INFO
    wputs "3. About Your App"
    wputs "-----------------"
    
    # devise
    @options[:devise] = true
    @options[:devise_config] = {}
    new_line(2)
    
    # sign in
    @options[:devise_config][:scheme] = "email"
      
    # allow sign up
    @options[:devise_config][:allow_signup] = true
      
    # test users
    @options[:devise_config][:test_users] = false      
      
    # post model
    @options[:post_resources] = false
    
    # contact form
    @options[:contact_form] = false
    
    # google analytics
    @options[:google_analytics] = false
    @options[:google_tracking_id] = nil
    
    # email settings
    wputs "Your app can send emails. Let's go through the basic settings I need to know. If you choose not to configure your email settings now, you can do it at a later stage by editing the relevant section within #{@options[:app_name]}/config/application.yml.", :help
    new_line
    wputs "- Configure email settings?"
    wputs "1. Yes (default)", :info
    wputs "2. No", :info
    @options[:email_settings] = answer() == "2" ? false : true
    @options[:email_config] = {}
    new_line(2)

    if @options[:email_settings]
      #sender
      wputs "- What is the email address you will send emails from?"
      wputs "example: someone@example.com", :help
      @options[:email_config][:sender] = answer("Email address:")
      new_line(2)
      
      # smtp server
      wputs "- What is your SMTP server address?"
      wputs "example: smtp.example.com", :help
      @options[:email_config][:smtp] = answer("SMTP server:")
      new_line(2)
      
      # domain
      wputs "- What is the domain name of your SMTP server?"
      wputs "example: 192.168.1.1, example.com, ...", :help
      @options[:email_config][:domain] = answer("Domain name:")
      new_line(2)
      
      # port
      wputs "- What is the SMTP server port number?"
      wputs "(default: 587)"
      choice = answer("SMTP port:")
      @options[:email_config][:port] = choice == "" ? "587" : choice
      new_line(2)
      
      # username
      wputs "- What is your SMTP username?"
      @options[:email_config][:username] = answer("SMTP username:")
      new_line(2)
      
      # password
      wputs "- What is your SMTP password?"
      wputs "tip: it will be stored in #{@options[:app_name]}/config/application.yml but won't be tracked by Git", :help
      @options[:email_config][:password] = answer("SMTP password:", false)
      new_line(2)
      
    else
      @options[:email_config][:sender] = nil
      @options[:email_config][:smtp] = nil
      @options[:email_config][:domain] = nil
      @options[:email_config][:port] = nil
      @options[:email_config][:username] = nil
      @options[:email_config][:password] = nil
    end
    
    # PRODUCTION
    wputs "4. Your Production Settings"
    wputs "---------------------------"
    
    # production
    wputs "At some point, you will deploy your app to a production environment. I can already set up some settings for you.", :help
    new_line
    wputs "- Do you want to set up some production settings already?"
    wputs "1. Yes (default)", :info
    wputs "2. No", :info
    @options[:production] = answer() == "2" ? false : true
    @options[:production_settings] = {}
    new_line(2)
    
    if @options[:production]
      # url
      wputs "- What will be the URL of your app?"
      wputs "example: www.my-app.com, blog.my-app.com, ...", :help
      wputs "tip: don't prefix the URL with http://", :help
      @options[:production_settings][:url] = answer("URL:")
      new_line(2)
      
      # unicorn
      @options[:production_settings][:unicorn] = true
      new_line(2)
    else
      @options[:production_settings][:target] = nil
      @options[:production_settings][:url] = nil
      @options[:production_settings][:unicorn] = nil
    end
    
    # SUMMARY
    wputs "5. Summary"
    wputs "----------"
    new_line
    
    # generate now
    wputs "- I am ready! Generate #{@options[:app_name]} now?"
    wputs "1. Do it! (default)", :info
    wputs "2. No, not now", :info
    @options[:generate] = answer() == "2" ? false : true
    new_line
    
    @options
  end
  
  
  # Shortcut/alias methods
  
  private
  
  def wputs(text, highlight = :none)
    StringHelpers.wputs(text, highlight)
  end
  
  
  def new_line(lines=1)
    StringHelpers.new_line(lines)
  end
  
  
  def answer(choices="Your choice (1-2):", is_downcase = true)
    print "#{choices} "
    if is_downcase
      STDIN.gets.chomp.downcase.strip
    else
      STDIN.gets.chomp.strip
    end
  end  
  
  
end