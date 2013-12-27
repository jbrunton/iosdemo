Then /^I should be on the '(.*?)' screen$/ do |screen|
  check_element_exists "view view:'UINavigationItemView' marked:'#{screen}'"
end

Given /^I have a task '(.*?)'$/ do |description|
  task = FactoryGirl.create(:task, :description => description)
  puts "*** task: #{task.to_yaml}"
  puts "*** task.new_record?: #{task.new_record?}"
  touch "button marked:'Refresh'"
  # wait_for_element_to_exist "tableViewCell label marked:'#{description}'"
end

Given /^I am on the Tasks screen$/ do
  
end

Then /^the task '(.*?)' should be visible$/ do |description|
  check_element_exists "tableViewCell label marked:'#{description}'"
  # wait_for_element_to_exist "tableViewCell label marked:#{description}"
end
