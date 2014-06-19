module ApplicationHelper

   # For flash messages
  def twitterized_type(type)
    case type.to_sym
    when :alert   then "alert alert-danger"
    when :error   then "alert alert-danger"
    when :notice  then "alert alert-success"
    when :success then "alert alert-success"
    else type.to_s
    end
  end

end
