require "json"

class OptionsFile < Options

  def initialize(path)
    super()
    @options = JSON.parse(IO.read(path), symbolize_names: true).merge(@options)
  end

end