require 'rails_helper'

RSpec.describe Tag, :type => :model do  

  it "has none to begin with" do
    expect(Tag.count).to eq 0
  end

  it "has one after adding one" do
    todolist =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    todoItem =  todolist.todo_items.create(name: "foo",isRecurring: true,created_at:"01-01-2020",updated_at:"01-01-2020")
    tag =  todoItem.tags.create(tagname: "foo",created_at:"01-01-2020",updated_at:"01-01-2020")
    expect(Tag.count).to eq 1
  end

  it "has less by one after deleting one" do
    countb4Add = Tag.count
    todolist =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    todoItem =  todolist.todo_items.create(name: "foo",isRecurring: true,created_at:"01-01-2020",updated_at:"01-01-2020")
    tag =  todoItem.tags.create(tagname: "foo",created_at:"01-01-2020",updated_at:"01-01-2020")
    countAftAdd = Tag.count   
    todoItem.destroy   
    countb4Add = countAftAdd-1
    expect(Tag.count).to eq countb4Add
  end


  it "has none after one was created in a previous example" do
    expect(Tag.count).to eq 0
  end

  context 'validation test' do
    it 'ensures tagname presence' do
    todolist =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    todoItem =  todolist.todo_items.create(name: "foo",created_at:"01-01-2020",updated_at:"01-01-2020")
    tag =  todoItem.tags.create(created_at:"01-01-2020",updated_at:"01-01-2020")
    expect(tag).to raise_error("NotNullViolation")
  end
  end

      
end
