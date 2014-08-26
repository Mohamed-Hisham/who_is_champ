module Capybara
  module Node
    class Element < Base
      def append(value)
        wait_until { base.append(value) }
      end
    end

    # the following method ain't working right now
    module Actions
      def append(locator, options={})
        msg = "cannot fill in, no text field, text area or password field with id, name, or label '#{locator}' found"
        raise "Must pass a hash containing 'with'" if not options.is_a?(Hash) or not options.has_key?(:with)
        find(:xpath, XPath::HTML.fillable_field(locator), :message => msg).append(options[:with])
      end
    end
  end
end

class Capybara::Selenium::Node < Capybara::Driver::Node
  def append(value)
    resynchronize do
      click
      native.send_keys(:end, value.to_s)
    end
  end
end
