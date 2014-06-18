module FlashMessagesHelper

  # def explain_errors(model)
  #   if model.present? && model.errors.any?
  #     html = ""
  #     html << content_tag(:h4) do
  #       <<-HERE_DOC
  #         #{pluralize( model.errors.count, "error")} prohibited this
  #         #{ model.class } from being saved:
  #       HERE_DOC
  #     end
  #     html << content_tag(:ul) do
  #       model.errors.full_messages.each {|msg|
  #         concat(content_tag(:li, msg, class: 'text-error'))
  #       }
  #     end
  #     html.html_safe
  #   end
  # end

end