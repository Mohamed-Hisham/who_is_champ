module UsersHelper
  def check_achieved(badge)
    user_badge_entry = UserBadge.where(user_id: @user.id, game_id: @game.id, badge_id: badge.id).take
    # debugger
    unless user_badge_entry.nil?
      if user_badge_entry.achieved?
        badge_class = ''
      else
        badge_class = 'badge-lock'
      end
    else
      badge_class = 'badge-lock'
    end
    return badge_class
  end

  def badge_name(badge)
    name = t('badge.firstsignin') if badge.badge_type == "firstsignin"
    name = t('badge.early') if badge.badge_type == "early"
    name = t('badge.lastmonth') if badge.badge_type == "lastmonth"
    name = t('badge.signinl1') if badge.badge_type == "signinl1"
    name = t('badge.signinl2') if badge.badge_type == "signinl2"
    name = t('badge.signinl3') if badge.badge_type == "signinl3"
    name = t('badge.highl1') if badge.badge_type == "highl1"
    name = t('badge.highl2') if badge.badge_type == "highl2"
    name = t('badge.highl3') if badge.badge_type == "highl3"
    name = t('badge.normall1') if badge.badge_type == "normall1"
    name = t('badge.normall2') if badge.badge_type == "normall2"
    name = t('badge.normall3') if badge.badge_type == "normall3"
    name = t('badge.lowl1') if badge.badge_type == "lowl1"
    name = t('badge.lowl2') if badge.badge_type == "lowl2"
    name = t('badge.lowl3') if badge.badge_type == "lowl3"
    name = t('badge.firstsocial') if badge.badge_type == "firstsocial"
    name = t('badge.sociall1') if badge.badge_type == "sociall1"
    name = t('badge.sociall2') if badge.badge_type == "sociall2"
    name = t('badge.sociall3') if badge.badge_type == "sociall3"
    return name
  end
end
