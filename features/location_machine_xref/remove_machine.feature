Feature: Remove Machine for Location
  In order to remove machines from locations
  As a guest
  I want to be able to remove machines from locations

  @javascript
  Scenario: Remove machine from location
    Given there is a location machine xref
    And I am on "Portland"'s home page
    And I press the "location" search button
    And I press "remove"
    And I wait for 1 seconds
    Then location_machine_xref should not exist