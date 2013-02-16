Feature: User can manually link to Entity another Entity as a part

  As an authenticated user
  So that I can link two entities by the part_of relation
  I want to link active entity (set) by selecting another entity (element)

Scenario: Link two existing entities by the part_of relation (happy path)

#  Given I log in as "User1" with "Password1"
  Given I am on the Entity Manager home page
  When I follow "Link an element" on "Entity 1"
  Then I should be on the Select Entity page
  When I select "Entity 2"
  And press "Link as an element" 
  Then I should be on the "Entity 1" detail page
  And I should see "Entity 2" in elements list

