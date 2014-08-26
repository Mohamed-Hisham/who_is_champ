Feature: Gamification
  In order to benefit from gamification
  As a member
  I should mark rule as accomplished
  And receive its corresponding points
  And receive its corresponding rank

Background:
  Given I am a member with
    | Name    | Email         | Password |
    | Mohamed | mohamed@m.com | password |
    And A competition manager available
    | Name | Email   | Password |
    | H    | h@m.com | password |

@javascript
Scenario: Mark Rule as complete. Points, and Rank Awarded
  When I joined the manager competition with the following details
    | Name              | Description                 | Pts Per Rule |
    | Sales Competition | This is a sales competition |     300      |
    And the competition has the following rules
    | Description    | Priority |
    | Sell 100 items | high     |
  When I sign in as member
  Then I should receive "First Sign in" badge
    And I should be on member profile page
    And I see a rule with description "Sell 100 items"
  When I click Mark as Complete link
  Then I should stay on member profile page
    And I should see this message "Rule Sell 100 items was marked as pending. Awaiting Creator to approve."
    And I should see "Pending Approval"
    And I should see "1 Pending Rule"
  Then the competition manager signs in to his profile
    And the competition manager checks the competition
    And the competition manager should see "Sell 100 items"
    And the competition manager approves the "Sell 100 items rule"
    And I should receive 450 points
    And I should receive "Starter" rank