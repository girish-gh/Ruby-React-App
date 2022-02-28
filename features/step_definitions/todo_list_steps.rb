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

Then('fill out title as {string} and description as {string} and click Add') do |string, string2|
  fill_in 'todo_title', :with => string + " - " + first_random
  fill_in 'todo_desc', :with => string2 + " - " + second_random
  sleep(3)
  click_button("addtodo")  
end

Then('I should see {string} and {string}  listed in todolist') do |string, string2|
  page.should have_content(string + " - " + first_random)
  page.should have_content(string2 + " - " + second_random)
  page.should have_content("New Todolist is created successfully.")
  sleep(10)
end
