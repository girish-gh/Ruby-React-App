require 'rails_helper'

RSpec.describe TodoList, driver: :selenium_chrome, js: true do
  describe 'the create TodoList process' do
      it 'should create new TodoList' do
        visit "/"
        
        fill_in 'titleInputRef', with: 'Post title'
        fill_in 'desctitleInputRef', with: 'Post content'
    
        click_button 'Create Todo'
        expect(page).to have_content 'New Todolist is created successfully.'
      end
  end

  RSpec.feature "User sees app", :type=> :feature do
    scenario "and sees that it says 'hello world'" do
      visit "/"

      expect(page).to have_text("Todo Lists")
    end
  end

  require "rails_helper"

  RSpec.describe "Todolist app", :type => :request do

      it "creates a Todolist " do
        headers = { "ACCEPT" => "application/json" }
        post "/api/v1/todo_lists", :params => { :todo_list => {:title => "My Todolist",:description => "Desc"} }, :headers => headers

        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(response).to have_http_status(:ok)
      end
        

end