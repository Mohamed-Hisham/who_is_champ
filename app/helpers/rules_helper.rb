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
      status = true   if user_rule_selected.status == 'complete'
    else
      status = false
    end
    # row_class = 'label label-info' if user_rule_selected.status == 'low'
    return status
  end

  def rule_status(user, rule)
    user_rule_selected = UserRule.where(user_id: user.id,rule_id: rule.id).take
    unless user_rule_selected.nil?
      row_class = 'fa fa-square-o' if user_rule_selected.status == 'normal'
      row_class = 'fa fa-check-square-o'   if user_rule_selected.status == 'complete'
    else
      row_class = 'fa fa-square-o'
    end
    # row_class = 'label label-info' if user_rule_selected.status == 'low'
    return row_class
  end

  def rule_status_text(user, rule)
    user_rule_selected = UserRule.where(user_id: user.id,rule_id: rule.id).take
    unless user_rule_selected.nil?
      row_class = "Mark Complete" if user_rule_selected.status == 'normal'
      row_class = "Completed"   if user_rule_selected.status == 'complete'
    else
      row_class = "Mark Complete"
    end
    # row_class = 'label label-info' if user_rule_selected.status == 'low'
    return row_class
  end
end
