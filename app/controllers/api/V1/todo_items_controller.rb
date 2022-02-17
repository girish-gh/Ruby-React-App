# class TodoItemsController < ApplicationController
  
# end



require 'date'

module Api::V1

class TodoItemsController < ApplicationController

    before_action :set_todo_list
    before_action :set_todo_item, except: [:index, :create]
    skip_before_action :verify_authenticity_token

   
   
    def show
    end

    def index        
             
        @todo_items = @todo_list.todo_items.all.includes(:tags)

         returnlist = []

        @todo_items.each do |item|
           list = {
               id: item.id,
               name: item.name,
               isComplete: item.isComplete == true ? 'Yes' : 'No' ,
               completedOn: item.completedOn,
               isRecurring: item.isRecurring == true ? 'Yes' : 'No',
               tags: item.tags
           }
           returnlist << list
        end       
        render json:returnlist
    end

    def edit
        
        if request.patch?
   
            if @todo_item.update(todo_items_params_edit[:todo_item])

                TodoItemManager.SaveTags(@todo_item, todo_items_params_edit)    
                flash[:topnotice] = 'Updated successully.'
                redirect_to todo_list_todo_items_path(@todo_list)
                
            else
                render 'edit'
            end    
        end             
    end

    def update
        
        if request.patch?
                params.permit(:id,:name,:isRecurring, :tagname, :todo_list_id,todo_item: {})                
                todo_item_toupdate = {id: params[:id],name: params[:name], isRecurring: params[:isRecurring], todo_list_id: params[:todo_list_id]}
               # p params[:name, :isRecurring, :tags, :todo_list_id]
                #p params[:

            if @todo_item.update(todo_item_toupdate)

                @todo_item.tags.destroy_all
                tags = params[:tagname].split(',').map(&:strip)
                for tagname in tags do
                    @todo_item.tags.create({tagname: tagname})
                end  
             
               if @todo_item != nil
                    render json: {message: "Item Updated successfully -- Name - #{@todo_item.name}", status: :ok}
                  #format.html { redirect_to todolist_todoitems_path(@todo_list), notice: "Todoitem was successfully Created." }          
               else
                   p Rails.logger.info(@todo_item.errors.messages.inspect)
               end        
            end    
        end         
    end
    
    def create    
        params.permit(:name, :isRecurring, :isComplete, :completedOn, :todo_list_id)
        hsg = {name: params[:name], isRecurring: params[:isRecurring], isComplete: params[:isComplete], completedOn: params[:completedOn]}
        @todo_item = @todo_list.todo_items.create(hsg)   
        params.permit(:tagname)  
        tags = params[:tagname].split(',').map(&:strip)
    
         for tagname in tags do
             @todo_item.tags.create({tagname: tagname})
         end  
           
         if @todo_item != nil
            render json: {message: "Item Created successfully -- Name - #{@todo_item.name}", status: :ok}
          #format.html { redirect_to todolist_todoitems_path(@todo_list), notice: "Todoitem was successfully Created." }          
            else
           p Rails.logger.info(@todo_item.errors.messages.inspect)
        end        
      end
  
    # def create

    #     #params.permit(:todo_list_id,:name,:tagname,:isRecurring, todo_item: {})
    #     unless todo_items_params[:name].empty?
    #         p  todo_items_params
    #         @todo_item = @todo_list.todo_items.create(todo_items_params)
           
    #         if @todo_item.id !=nil && @todo_item.id > 0
    #             p "@todo_item = #{@todo_item}"
    #             #TodoItemManager.SaveTags(@todo_item, params.permit(:tagname))
    #             params.permit(:tagname)  
    #             tags = params[:tags].split(',').map(&:strip)

    #             for tag in tags do
    #                 @todo_item.tag.create({name: tag})
    #             end  
                
    #             render json: {message: 'Created successfully '}, status: :ok
    #         else
    #             render json: {message: 'Unable to save'}, status: :unprocessable_entity
    #         end            
    #     else            
    #         render json: {message: 'Unable to save'}, status: :unprocessable_entity
    #     end

    # end

    def destroy
        
        @todo_item.destroy
        render json: {message: 'Deleted successfully '}, status: :ok
    end

    def move
        params.permit(:newtodo,:todo_list_id,:id,todo_item: {})
        p @todo_item.id
        p "Moving from #{params[:todo_list_id]} to #{params[:newtodo]}"
        if @todo_item.update(todo_list_id: params[:newtodo])
            p "@todo_item = #{@todo_item.name} #{@todo_item.todo_list_id}"
            render json: {message: "Moved successfully from #{@todo_list.title}"}, status: :ok
        else
           p Rails.logger.info(@todo_item.errors.messages.inspect)
        end

    end

    def complete
        
        @todo_item.update(isComplete: true, completedOn: DateTime.now)
        render json: {message: 'Status has changed'}, status: :ok

    end

    def incomplete
        
        @todo_item.update(isComplete: false, completedOn: nil)
        render json: {message: 'Status has changed'}, status: :ok

    end
    
    private

    def set_todo_list
        #params.permit(:todo_list_id,:name,:tagname,:isRecurring, todo_item: {})
        #params.permit(:tagname)        
        @todo_list = TodoList.find(params[:todo_list_id])
        p "@todo_list = #{@todo_list.title}"
    end

    def set_todo_item        
        @todo_item = @todo_list.todo_items.find(params[:id])
        p "@todo_item.name = #{@todo_item.name}"
    end

    def todo_items_params
        params.permit(:todo_list_id,:name,:isRecurring)
       # params.permit(:name,:isRecurring)

    end

    def todo_items_params_edit
        
        params.permit(:tagname, todo_item: {})

    end    


end

end
