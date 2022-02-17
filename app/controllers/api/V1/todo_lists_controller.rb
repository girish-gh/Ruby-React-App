
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
                  #  todo_items: item.todo_items,
                  # tags: tagList
                  #stags:""
              }
            returnlist << list
          end   
          render json: returnlist

          #render json: @todo_lists  
        end

      def show
      end


      # GET /todolists/new
      def new
        @todo_list = TodoList.new
      end

      # GET /todolists/1/edit
      def edit
      end

      # POST /todolists or /todolists.json
      def create
        @todo_list = TodoList.new(todo_list_params)#
        #@todo_list = Todolist.new(todo_list_params)
        if @todo_list.save
            #flash[:topnotice] = 'New todo list has been created successfully.'                
              #format.html { redirect_to todo_lists_path }
              render json: {message: "New Todolist is created successfully. ", status: :ok }
        else
              format.json { render json: @todo_list.errors.to_json, status: :error}
        end

      end

      # PATCH/PUT /todolists/1 or /todolists/1.json
      def update
        respond_to do |format|
          
          if @todo_list.update(todo_list_params)
            render json: {message: "Updated successfully.", status: :ok }
            # format.html { redirect_to todolist_url(@todo_list), notice:  }
            # format.json { render :show, status: :ok, location: @todo_list }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @todo_list.errors, status: :unprocessable_entity }
          end
        end
      end

      # DELETE /todolists/1 or /todolists/1.json
      def destroy
        p "deleting id = #{params[:id]}"
        @todo_list_todelete = TodoList.find(params[:id])
        p @todo_list_todelete.title
        if @todo_list_todelete.destroy  
          render json: {message: "Deleted successfully -- \nTitle: #{@todo_list.title}"}, status: :ok
        else
           p Rails.logger.info(@todo_item.errors.messages.inspect)
        end  
        #redirect_to todolists_url    
      end

      def manualDelete
        @todo_list_todelete = TodoList.find(params[:todo_list_id])
        @todo_list_todelete.destroy
        redirect_to todolists_url 
      end


      private
          # Use callbacks to share common setup or constraints between actions.
          def set_todo_list
            @todo_list = TodoList.find(params[:id])
          end

          # Only allow a list of trusted parameters through.
          def todo_list_params
            params.require(:todo_list).permit( :title, :description)
          end
  end
end

