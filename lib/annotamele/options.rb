require_relative "version"
require_relative "config_values"

class Options
  attr_accessor :options
  
  def initialize
    # Basic
    @options = {
      annotamele_version: Version.to_s,
      rails_version: ConfigValues.rails_version,
      ruby_version: ConfigValues.ruby_version,
      generate: true
    }
  end

end