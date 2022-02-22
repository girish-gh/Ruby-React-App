require "rails_helper"


RSpec.describe TodoList, :type => :model do

  it "has none to begin with" do
    expect(TodoList.count).to eq 0
  end

  it "has one after adding one" do
    todolist =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    expect(TodoList.count).to eq 1
  end

  it "has less by one after deleting one" do
    count = TodoList.count
    todolist =  TodoList.create(title: "wierd",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    count1 = TodoList.count   
    todolist.destroy   
    expect(TodoList.count).to eq count=count1-1
  end


  it "has none after one was created in a previous example" do
    expect(TodoList.count).to eq 0
  end

  context 'validation test' do
      it 'ensures title presence' do
        todolist =  TodoList.create(description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
        expect(todolist.id).to eq (nil)
    end
  end

  context 'validation test' do
    it 'ensures description presence' do
      todolist =  TodoList.create(title: "title",created_at:"01-01-2020",updated_at:"01-01-2020")    
      expect(todolist.id).to eq (nil)
  end
end

end