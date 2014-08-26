Feature: Sign up
  In order to use the system
  As a creator
  I should be able to sign up

Background:
  Given I am a guest

@javascript
Scenario: Successful sign up
  When I go to home page
    And I click the Sign Up button
    And I go to the registration page
  Then I fill in my details
    And I click the Sign up button
    And I should see this message "A message with a confirmation link has been sent to your email address. Please open the link to activate your account."
    And I should receive a message with the subject "Confirmation instructions"
    And the message should contain "You can confirm your account email through the link below:"

@javascript
Scenario: Failing to sign up due to missing fields
  When I go to the registration page
    And I click the Sign up button
  Then I should see this message "Name can't be blank"
  And I should see this message "Email can't be blank"
  And I should see this message "Password can't be blank"