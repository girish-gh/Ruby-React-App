require 'rails_helper'


RSpec.describe TodoItem, :type => :model do

  it "has none to begin with" do
    expect(TodoItem.count).to eq 0
  end

  it "has one after adding one" do
    todolist =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    todoItem =  todolist.todo_items.create(name: "foo",isRecurring: true,created_at:"01-01-2020",updated_at:"01-01-2020")
    expect(TodoItem.count).to eq 1
  end

  it "has less by one after deleting one" do
    countb4Add = TodoItem.count
    todolist =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    todoItem =  todolist.todo_items.create(name: "foo",isRecurring: true,created_at:"01-01-2020",updated_at:"01-01-2020")
    countAftAdd = TodoItem.count   
    todoItem.destroy   
    countb4Add = countAftAdd-1
    expect(TodoItem.count).to eq countb4Add
  end


  it "has none after one was created in a previous example" do
    expect(TodoItem.count).to eq 0
  end

  describe "structure" do
    it "has its columns" do
      is_expected.to have_db_column(:name)
      is_expected.to have_db_column(:isRecurring)
    end
  end

  describe "associations" do
    it do
      is_expected.to belong_to(:todo_list)
    end
  end

  describe 'validations' do
    subject { Fabricate(:todo_item) }

    it 'validate presence of fields' do
      expect(subject).to validate_presence_of(:name)
      expect(subject).to validate_presence_of(:isRecurring)
    end
  end
end
