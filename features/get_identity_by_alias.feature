Feature: User can search for entity based on alias - i.e. local ID of some owner

  As a user from any stakeholder
  So that I can find the unique entity based on my local name
  I want to get all info about the IoT Entity

Background: Start from the Search form on the home page
  Given the following entities exist:
  | description             | schema        |
  | Temperature sensor 1    | urn:entity_id:|
  | Temperature sensor 2    | urn:entity_id:|
  | Temperature sensor 3    | urn:entity_id:|
  | Temperature sensor 4    | urn:entity_id:|
          
  Given I am on the Entity Manager home page
  Then I should see "Get Identity by local alias"
  
Scenario: Try to find nonexistent entity (sad path)
  When I fill in "Search Terms" with "Entity That Does Not Exist"
  And I press "Search by Alias"
  Then I should be on the Entity Manager home page
  And I should see "Entity with local alias 'Entity That Does Not Exist' does not exist!"

 
Scenario: Try to add existing entity (happy path)
 
  Given I have added "Sensor 1" with description "Temperature sensor 1"
  When I fill in "Search Terms" with "Sensor 1"
  And I press "Search by Alias"  
# TODO: authentication! without this the tests does not work fully
#  And I fill in "Owner" with "1" -> owner should be already logged in
  Then I should be on the Entity page
  And I should see "Sensor 1"
