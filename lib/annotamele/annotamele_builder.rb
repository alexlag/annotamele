require 'fileutils'
require_relative 'ui_helpers'
require_relative 'version'
require_relative 'string_helpers'
require_relative 'file_helpers'
require_relative 'config_values'

module AnnotameleBuilder
  def self.build_annotamele(app_dir, options)
    new_line(2)
    wputs '----> Generating AnnotameLE initializer ...', :info

    annotamele_dir = File.dirname(__FILE__)

    # Make types file
    File.open(app_dir + '/db/answer_types.json', 'w') do |file|
      file.write options[:annotamele][:types].to_json
    end

    # Make seed file
    FileUtils.cp_r(options[:annotamele][:dataset], app_dir + '/db/seed_data.json')

    new_line
    wputs '----> AnnotameLE initializer generated.', :info
  end

  def self.wputs(text, highlight = :none)
    StringHelpers.wputs(text, highlight)
  end

  def self.new_line(lines = 1)
    StringHelpers.new_line(lines)
  end
end
