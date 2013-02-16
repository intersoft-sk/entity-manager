Feature: User can search for entity based on alias - i.e. local ID of some owner

  As a user from any stakeholder
  So that I can find the unique entity based on my local name
  I want to get all info about the IoT Entity

Background: Start from the Search form on the home page
  Given I am on the Entity Manager home page
  Then I should see "Get Identity by local alias"
  
Scenario: Try to find nonexistent entity (sad path)
  When I fill in "Search Terms" with "Entity That Does Not Exist"
  And I press "Search by Alias"
  Then I should be on the Entity Manager home page
  And I should see "No entity found for local alias: 'Entity That Does Not Exist'."

 
Scenario: Try to add existing entity (happy path)
 
  When I fill in "Search Terms" with "Sensor 1"
#  And I fill in "Owner" with "1" -> owner should be already logged in
  And I press "Search by Alias"
  Then I should be on the Search Results page
  And I should not see "not found"
  And I should see "Sensor 1"
