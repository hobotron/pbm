Feature: add a high score for a machine
  In order to add high scores to machines
  As a guest
  I want to be able to add high scores to machines

  @javascript
  Scenario: Add a new high score to a machine
    Given there is a location machine xref
    And today is "05/02/2011"
    And I am on "Portland"'s home page
    And I press the "location" search button
    And I click on the add scores link for "Test Location Name"
    And I fill in a score of "1234" and rank "GC" and initials "cap"
    And I press "Add Score"
    And I wait for 1 seconds
    Then "Test Location Name"'s "Test Machine Name" should have a score with score "1234" and rank "1" and initials "cap"

  @javascript
  Scenario: Add a new high score to a machine, should remove non-digit characters
    Given there is a location machine xref
    And today is "05/02/2011"
    And I am on "Portland"'s home page
    And I press the "location" search button
    And I click on the add scores link for "Test Location Name"
    And I fill in a score of "1,234" and rank "GC" and initials "cap"
    And I press "Add Score"
    And I wait for 1 seconds
    Then "Test Location Name"'s "Test Machine Name" should have a score with score "1234" and rank "1" and initials "cap"
