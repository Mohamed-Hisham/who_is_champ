module RulesHelper
  def rule_priority(rule)
    row_class = 'label label-danger' if rule.priority == 'high'
    row_class = 'label label-warning'   if rule.priority == 'normal'
    row_class = 'label label-info' if rule.priority == 'low'
    return row_class
  end

  def check_status(user, rule)
    user_rule_selected = UserRule.where(user_id: user.id,rule_id: rule.id).take
    unless user_rule_selected.nil?
      status = false if user_rule_selected.status == 'normal'
      status = true   if user_rule_selected.status == 'complete' || user_rule_selected.status == 'pending'
    else
      status = false
    end
    return status
  end

  def rule_status(user, rule)
    user_rule_selected = UserRule.where(user_id: user.id,rule_id: rule.id).take
    unless user_rule_selected.nil?
      @row_class = 'fa fa-square-o' if user_rule_selected.status == 'normal'
      @row_class = 'fa fa-check-square-o'   if user_rule_selected.status == 'complete'
      @row_class = 'fa fa-spinner fa-spin'   if user_rule_selected.status == 'pending'
    else
      @row_class = 'fa fa-square-o'
    end
    return @row_class
  end
  def rule_status_color
    return 'color:orange;' if @row_class == "fa fa-spinner fa-spin"
  end
  def rule_status_text(user, rule)
    user_rule_selected = UserRule.where(user_id: user.id,rule_id: rule.id).take
    unless user_rule_selected.nil?
      row_class = t('views.home.mark_as_complete') if user_rule_selected.status == 'normal'
      row_class = t('views.home.complete')   if user_rule_selected.status == 'complete'
      row_class = t('views.home.pending_approval')   if user_rule_selected.status == 'pending'
    else
      row_class = t('views.home.mark_as_complete')
    end
    # row_class = 'label label-info' if user_rule_selected.status == 'low'
    return row_class
  end

  def rule_priority_text(rule)
    pri_text =t('views.home.high') if rule.priority == 'high'
    pri_text =t('views.home.normal') if rule.priority == 'normal'
    pri_text =t('views.home.low') if rule.priority == 'low'
    return pri_text
  end

  def get_rule_user(rule)
    @pending_user= UserRule.find_by(rule_id: rule.id, status: UserRule.statuses[:pending]).user
  end
end
