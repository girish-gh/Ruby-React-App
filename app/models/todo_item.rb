class TodoItem < ApplicationRecord
  belongs_to :todo_lists, class_name: "TodoList", optional: true
  validates :name, presence: true, length: { minimum: 2 }
  has_many :tags, class_name: "Tag", :dependent => :destroy  


  def TodoItem.to_taglist(todo_item)
    tag_array = todo_item.tag
    #tag_list.join(',')
    tag_list = ""
    for tag in tag_array
      tag_list = tag_list + tag.name.to_s  + ", "   
    end
    p "tag_list = #{tag_list}"
   tag_list
  end
  
end
