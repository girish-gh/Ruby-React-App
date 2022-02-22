require 'rails_helper'
#RSpec.describe TodoList, driver: :selenium_chrome, js: true do
# describe 'the create TodoList process' do
#     it 'should create new TodoList' do
#       visit "/"
      
#       fill_in 'titleInputRef', with: 'Post title'
#       fill_in 'desctitleInputRef', with: 'Post content'
  
#       click_button 'Create Todo'
#       expect(page).to have_content 'New Todolist is created successfully.'
#     end
#  end

RSpec.feature "User sees app", :type=> :feature do
  scenario "and sees that it says 'hello world'" do
    visit "/"

    expect(page).to have_text("Todo Lists")
  end
end
# end