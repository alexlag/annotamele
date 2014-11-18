module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | ANNOTAMELE_APP_NAME"      
    end
  end

  def annotamele_input
  	case Rails.application.config.annotamele_type
  	when :multilabel
  		'checkbox'
  	when :singlelabel
  		'radio'
  	else 
  		'radio'	
  	end
  end
end
