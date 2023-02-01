JS_DRIVER = :selenium_chrome_headless

Capybara.default_driver = :rack_test
Capybara.javascript_driver = :selenium_chrome_headless
Capybara.default_max_wait_time = 2
Capybara.server = :puma

RSpec.configure do |config|
  config.before(:each) do |example|
    Capybara.current_driver = :selenium_chrome_headless if example.metadata[:js]
  end

  config.after(:each) do
    Capybara.use_default_driver
  end
end
