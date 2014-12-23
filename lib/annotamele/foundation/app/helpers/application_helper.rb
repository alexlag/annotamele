module ApplicationHelper

  def title(value)
    unless value.nil?
      @title = "#{value} | AnnotameLE"      
    end
  end

end
