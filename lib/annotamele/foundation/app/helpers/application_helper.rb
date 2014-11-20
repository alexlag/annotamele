module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | AnnotameLE"      
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
