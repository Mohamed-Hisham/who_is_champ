# Givens
Given /^I am a guest$/ do
  @guest ||= create_guest
  visit '/'
end

Given /^I am logged out$/ do
  step %q{I go to the sign out page}
end

Given /^I am logged in$/ do
  visit path_for('member login')

  fill_in 'Email', with: @user[:email]
  fill_in 'Password', with: @user[:password]
  click_button 'Sign in'
end

Given /^I am a confirmed creator$/ do
  @user.confirm!
end

Given(/^I have the following address as my default$/) do |address_table|
  address_table.map_headers! do |cell|
    cell.downcase.gsub(/\s/, '_').to_sym
  end

  address_table.hashes.each do |address_hash|
    @user.addresses.create!(address_hash)
  end
end

# Whens
When /^I fill in my details$/ do
  fill_in 'Name', with: @guest[:name]
  set_speed(:slow)
  fill_in 'Email', with: @guest[:email]
  set_speed(:slow)
  fill_in 'Password', with: @guest[:password], exact: true
  set_speed(:slow)
  fill_in 'Password Confirmation', with: @guest[:password]
end
