require "rails_helper"

RSpec.describe TodoList, :type => :model do

  it "has none to begin with" do
    expect(TodoList.count).to eq 0
  end

  it "has one more after creating one" do
    initCount = TodoList.count
    todolist =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    expect(TodoList.count).to eq initCount+1
  end

  it "has less by one after deleting one" do
    initCount = TodoList.count
    todolist1 =  TodoList.create(title: "title",description: "description",created_at:"01-01-2020",updated_at:"01-01-2020")
    todolist =  TodoList.last
    todolist.destroy   
    expect(TodoList.count).to eq initCount-1
  end


  it "has none after one was created in a previous example" do
    expect(TodoList.count).to eq 0
  end

  
  describe 'structure' do
    describe 'has its columns' do
      it {is_expected.to have_db_column(:title)}
      it {is_expected.to have_db_column(:description)}
    end
  end 

  context 'structure and validation' do
     it 'has its columns' do
       expect(subject).to have_db_column(:title)
     end
  end
 

  describe "associations" do
    it "Has many associations" do
      is_expected.to has_many(:todo_items)
    end
  end

  describe 'validations' do
    subject { Fabricate(:todo_list) }

    it 'validate presence of fields' do
      expect(subject).to validate_presence_of(:title)
    end

    it 'validate presence of fields' do
      expect(subject).to validate_presence_of(:description)
    end
  end

end