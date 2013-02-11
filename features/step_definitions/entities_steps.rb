Given /^I log in as "(.*?)" with "(.*?)"$/ do |username, password|
  steps %Q{
    Given I am on the Logging page for Entity Manager
    Then  I should see "Log in page for Entity Manager"
    When  I fill in "username" with "#{username}"
    And   I fill in "password" with "#{password}"
    And   I press "Log in"
  }
end

Given /I have added "(.*)" with description "(.*)"/ do |localID, description|
  steps %Q{
    Given I am on the Register New Entity page
    When  I fill in "LocalID" with "#{localID}"
    And   I fill in "Description" with "#{description}"
    And   I press "Save Changes"
  }
end

Then /I should see "(.*)" before "(.*)" on (.*)/ do |string1, string2, path|
  step "I am on #{path}"
  regexp = /#{string1}.*#{string2}/m #  /m means match across newlines
  page.body.should =~ regexp
end

Given /the following entities exist/ do |entities_table|
  entities_table.hashes.each do |entity|
    entity.store("uuid", SecureRandom.uuid)
    Entity.create!(entity)
  end
  #flunk "Unimplemented"
end
