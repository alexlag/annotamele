module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | ANNOTAMELE_APP_NAME"      
    end
  end
end
