module HomeHelper

  def check_home
    if current_page?(root_path) || current_page?(about_path)
      body_class = ""
    else
      body_class ="margin-bottom:-80px;"
    end
    # body_class ="margin-bottom:-80px;"
    return body_class
  end
end
