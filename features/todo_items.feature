Feature: TodoItems App Testing

Scenario: Add new todoitem

Given I am on the homepage
Then I should see "New Todo List"
Then click on Manage link
Then fill out name as "Test todoitem name - Capybara-Cucumber" and  tags as "Test_tags_Capybara_Cucumber" and isRecurring as checked and click Add
Then I should see "Item Created successfully -- Name - Test todoitem name - Capybara-Cucumber"
Then I should see "Test todoitem name - Capybara-Cucumber" listed in todolist

