class TodoItem < ApplicationRecord
  belongs_to :todo_list
  validates :name, presence: true, length: { minimum: 2 }
  has_many :tags, :dependent => :destroy  

end
