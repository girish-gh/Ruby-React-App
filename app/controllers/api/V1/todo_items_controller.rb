require 'date'

module Api::V1

    class TodoItemsController < ApplicationController

        before_action :set_todo_list
        before_action :set_todo_item, except: [:index, :create]
        skip_before_action :verify_authenticity_token

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
                if @todo_item.update!(todo_items_params_edit[:todo_item])
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
                if @todo_item.update(todo_item_toupdate)
                    @todo_item.tags.destroy_all
                    tags = params[:tagname].split(',').map(&:strip)
                    for tagname in tags do
                        @todo_item.tags.create({tagname: tagname})
                    end               
                if @todo_item != nil
                        render json: {message: "Item Updated successfully -- Name - #{@todo_item.name}", status: :ok}
                else
                    render json: {message: "Item Update failed -- Name - #{@todo_item.name}", status: :error}
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
            else
                render json: {message: "Item Update failed -- Name - #{@todo_item.name}", status: :error}
            end        
        end     
    

        def destroy        
            @todo_item.destroy!
            render json: {message: 'Deleted successfully '}, status: :ok
        end

        def move
            params.permit(:newtodo,:todo_list_id,:id,todo_item: {})
            if @todo_item.update!(todo_list_id: params[:newtodo])
                render json: {message: "Moved successfully from #{@todo_list.title}", status: :ok}
            else
                render json: {message: @todo_item.errors.messages,  status: :error}
            end
        end

        def complete            
            @todo_item.update!(isComplete: true, completedOn: DateTime.now)
            render json: {message: 'Status has changed', status: :ok}
        end

        def incomplete            
            @todo_item.update!(isComplete: false, completedOn: nil)
            render json: {message: 'Status has changed'}, status: :ok
        end
        
      private
        def set_todo_list    
            @todo_list = TodoList.find(params[:todo_list_id])
        end

        def set_todo_item        
            @todo_item = @todo_list.todo_items.find(params[:id])
        end

        def todo_items_params
            params.permit(:todo_list_id,:name,:isRecurring)
        end

        def todo_items_params_edit        
            params.permit(:tagname, todo_item: {})
        end   
    end

end
