class TodoListController < ApplicationController

  def index
       
    @todolists = TodoList.all.includes(:todo_items).order(id: :asc)

    returnlist = []

    @todolists.each do |item|
      tagList = []
      todo_items = item.todo_items.all
      todo_items.each do |tag|
        tagList = { 
          id:tag.id,
          name: tag.name,
          tags: tag.tags
         }
      end
        list = {
            id: item.id,
            title: item.title,
            description: item.description,
            todo_items: todo_items
            #  todo_items: item.todo_items,
            # tags: tagList
            #stags:""
        }
       returnlist << list
    end   
    render json: returnlist

    #render json: @todolists  
  end

  def new 
        
    @todolist = TodoList.new

end

def edit
end

def show
end

def create
    
    @todolist = TodoList.new(todolist_params)

    if @todolist.save
        
        #flash[:topnotice] = 'New todo list has been created successfully.'                
        #format.html { redirect_to todo_lists_path }
        render json: {message: 'Successfully created'}, status: :ok

    else
        # console.log(@todolist.errors)
        render json: @todolist.errors, status: :unprocessable_entity
        #format.html { render :new}

    end      

end

def destroy
  @todolist_todelete = Todolist.find(params[:todolist_id])
  @todolist_todelete.destroy    
  #redirect_to todolists_url    
end

  def update
  end
end
