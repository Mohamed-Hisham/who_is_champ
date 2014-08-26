Given(/^I am a member with$/) do |table|
  # table is a Cucumber::Ast::Table
  @session_users ||= {}
  table.map_headers! do |cell|
    cell.downcase.gsub(/\s/, '_').to_sym
  end

  table.hashes.each do |user_hash|
    user = create_user(user_hash)
    @session_users[user.email] = user
    @user = user
  end
end

Given(/^A competition manager available$/) do |table|
  # table is a Cucumber::Ast::Table
  @session_creators ||= {}
  table.map_headers! do |cell|
    cell.downcase.gsub(/\s/, '_').to_sym
  end

  table.hashes.each do |creator_hash|
    creator = create_creator(creator_hash)
    @session_creators[creator.email] = creator
    @creator = creator
  end
end

When(/^I joined the manager competition with the following details$/) do |table|
  table.map_headers! do |cell|
    cell.downcase.gsub(/\s/, '_').to_sym
  end

  table.hashes.each do |competition_hash|
    @game = create_game(competition_hash)
  end
  @game.update_attribute(:creator_id, 2)
  @user.update_attribute(:game_id, 2)
  create_badges
end

When(/^the competition has the following rules$/) do |table|
  table.map_headers! do |cell|
    cell.downcase.gsub(/\s/, '_').to_sym
  end

  table.hashes.each do |rule_hash|
    @rule = create_rule(rule_hash)
  end
  @rule.update_attribute(:game_id, 2)
end

When(/^I sign in as member$/) do
  visit path_for('member login')
  fill_in 'Email', with: @user[:email]
  fill_in 'Password', with: "password"
  click_button 'Sign in'
end

Then(/^I see a rule with description "(.*?)"$/) do |arg1|
  page.text.scan(/(#{arg1})/)
end

Then(/^the competition manager signs in to his profile$/) do
  visit path_for('creator login')
  fill_in 'Email', with: @creator[:email]
  fill_in 'Password', with: "password"
  click_button 'Sign in'
end

Then(/^the competition manager checks the competition$/) do
  click_link_or_button 'View Competition'
end

Then(/^the competition manager should see "(.*?)"$/) do |pending_rule_title|
  page.text.scan(/(#{pending_rule_title})/)
end

Then(/^the competition manager approves the "(.*?)"$/) do |pending_rule|
  click_link_or_button 'Approve'
end

Then(/^I should receive (\d+) points$/) do |points|
  @user.reload
  expect(@user.pts).to eq(points.to_i)
end

Then(/^I should receive "(.*?)" rank$/) do |rank|
  expect(@user.rank).to eq(rank)
end

Then(/^I should receive "(.*?)" badge$/) do |arg1|
  @user_badge = UserBadge.first
  expect(@user_badge.achieved).to eql(true)
end