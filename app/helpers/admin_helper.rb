module AdminHelper

  def check_admin_badges_page
    return 'active' if current_page?(admin_badges_path(@admin))
  end
  def check_admin_creators_page
    return 'active' if current_page?(admin_creators_path(@admin))
  end
  def check_admin_users_page
    return 'active' if current_page?(admin_users_path(@admin))
  end
  def check_admin_games_page
    return 'active' if current_page?(admin_games_path(@admin))
  end
end