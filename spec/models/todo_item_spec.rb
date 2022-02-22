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

  context 'validation test' do
    it 'ensures name presence' do
      todolist =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    todoItem =  todolist.todo_items.create(isRecurring: true,created_at:"01-01-2020",updated_at:"01-01-2020")
    expect(todoItem.id).to eq (nil)
  end
  end

    context 'validation test' do
      it 'ensures isRecurring presence' do
        todolist =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
        todoItem =  todolist.todo_items.create(name: "foo",created_at:"01-01-2020",updated_at:"01-01-2020")
        p todoItem
        expect(todolist.todo_items.create(name: "foo",created_at:"01-01-2020",updated_at:"01-01-2020")).to raise_exception(ActiveRecord::NotNullViolation)
    end
  end
end
