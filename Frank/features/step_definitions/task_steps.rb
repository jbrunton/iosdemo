Then /^I should be on the '(.*?)' screen$/ do |screen|
  check_element_exists "view view:'UINavigationItemView' marked:'#{screen}'"
end

Given /^I have a task '(.*?)'$/ do |description|
  FactoryGirl.create(:task, :description => description)
end

Given /^I am on the Tasks screen$/ do
  
end

Then /^the task '(.*?)' should be visible$/ do |description|
  check_element_exists "tableViewCell label marked:'#{description}'"
end
