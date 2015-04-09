module ApplicationHelper
  def title(value)
    @title = "#{value} | AnnotameLE" unless value.nil?
  end
end
