module RulesHelper
  def rule_priority(rule)
    row_class = 'label label-danger' if rule.priority == 'high'
    row_class = 'label label-warning'   if rule.priority == 'normal'
    row_class = 'label label-info' if rule.priority == 'low'
    return row_class
  end
end
