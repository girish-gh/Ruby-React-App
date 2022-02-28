require 'securerandom'

first_random = SecureRandom.hex.to_s
second_random = SecureRandom.hex.to_s

Given('I need to goto the homepage') do
end

When('I am on the homepage') do  
  visit 'http://localhost:3000/'
end

Then('I should see {string}') do |string|
  page.should have_content(string)  
end

Given('I am on the homepage again') do
  expect(page).to have_current_path("/todo_lists")
end
Then ('click on manage link')
Then('fill out Name as {string} and Tags as {string2} and IsRecurring as checked click Add') do |string, string2|
  fill_in 'name', :with => string
  fill_in 'isRecurring', :with =>  checked
  fill_in 'tags', :with =>  string2
  sleep(3)
  click_button("addtodo")  
end

Then('I should see {string} and {string}  listed in todoitems') do |string, string2|
  page.should have_content(string + " - " + first_random)
  page.should have_content(string2 + " - " + second_random)
  page.should have_content("New Todoitem is created successfully.")
  sleep(10)
end
