require "rails_helper"

RSpec.feature "todo_lists management", :type => :feature do
  scenario "User creates a new todo_list" do
    visit "/"
    fill_in 'todo_title', :with => "todo_title"
    fill_in 'todo_desc', :with => "todo_desc"
    sleep(3)
    click_button "Create todo"

    expect(page).to have_text("Widget was successfully created.")
  end
end