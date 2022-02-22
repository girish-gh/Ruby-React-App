
module Api::V1

  class TodoListsController < ApplicationController

    skip_before_action :verify_authenticity_token    
    before_action :set_todo_list, only: %i[ show edit update destroy ] 

        def index              
          @todo_lists = TodoList.all.includes(:todo_items).order(id: :asc)

          returnlist = []

          @todo_lists.each do |item|
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
              }
            returnlist << list
          end   
          render json: returnlist
        end

      def new
        @todo_list = TodoList.new
      end

      # GET /todolists/1/edit
      def edit
      end

      # POST /todolists or /todolists.json
      def create
        @todo_list = TodoList.new(todo_list_params)
        if @todo_list.save
              render json: {message: "New Todolist is created successfully. "}, status: :ok 
        else
          render json: { message: @todo_list.errors, status: :error}
        end

      end

      # PATCH/PUT /todolists/1 or /todolists/1.json
      def update          
          if @todo_list.update(todo_list_params)
            render json: {message: "Updated successfully."}, status: :ok 
          else
            render json: { message: @todo_list.errors}, status: :unprocessable_entity 
          end
      end
      

      # DELETE /todolists/1 or /todolists/1.json
      def destroy
        @todo_list_todelete = TodoList.find(params[:id])
        if @todo_list_todelete.destroy  
          render json: {message: "Deleted successfully -- \nTitle: #{@todo_list.title}"}, status: :ok
         else
          render json: { message: @todo_list.errors}, status: :unprocessable_entity 
        end  
      end

      def manualDelete
        @todo_list_todelete = TodoList.find(params[:todo_list_id])
        @todo_list_todelete.destroy
        redirect_to todolists_url 
      end


      private
          def set_todo_list
            @todo_list = TodoList.find(params[:id])
          end

          def todo_list_params
            params.require(:todo_list).permit( :title, :description)
          end
  end
end

