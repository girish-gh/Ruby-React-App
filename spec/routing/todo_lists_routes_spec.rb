require "rails_helper"

describe TodoList, type: :routing do
   
    # it "routes to the Todo controller" do
    #     expect(get: "/").to route_to("todos#index")
    # end

    it "routes to #destroy" do
         expect(delete: "api/v1/todo_lists/1").to route_to("api/v1/todo_lists#destroy", id: "1")
     end

     it "routes to #create" do
      expect(post: "api/v1/todo_lists").to route_to("api/v1/todo_lists#create")
     end

     it "routes to #update" do
      expect(PATCH: "api/v1/todo_lists/1").to route_to("api/v1/todo_lists#update", id: "1")
     end

     it "routes to #show" do
      expect(get: "api/v1/todo_lists/1").to route_to("api/v1/todo_lists#show", id: "1")
     end

end