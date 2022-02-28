Feature: TodoList App Testing

Scenario: Goto home page

Given I need to goto the homepage
When I am on the homepage
Then I should see "Todo Lists"

Scenario: Add new todolist

Given I am on the homepage
Then I should see "New Todo List"
Then fill out title as "Test Title - Capybara-Cucumber" and description as "Test description - Capybara-Cucumber" and click Add
Then I should see "Todolist successfully created"
Then I should see "Test Title - Capybara-Cucumber" and "Test description - Capybara-Cucumber" listed in todolist

