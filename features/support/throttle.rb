require 'selenium-webdriver'

module ::Selenium::WebDriver::Firefox
  class Bridge
    attr_accessor :speed

    def execute(*args)
      result = raw_execute(*args)['value']
      case speed
        when :slow
          sleep 10
        when :medium
          sleep 0.1
      end
      result
    end
  end
end

def set_speed(speed)
  begin
    Capybara.current_session.driver.browser.send(:bridge).speed=speed
  rescue
  end
end
