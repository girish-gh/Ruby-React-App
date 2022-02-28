require "rails_helper"

describe TodoList, type: :routing do
   
    it "routes to #todo_items/destroy" do
         expect(delete: "api/v1/todo_lists/1/todo_items/1").to route_to("api/v1/todo_items#destroy",todo_list_id: "1", id: "1")
     end

     it "routes to #todo_items/create" do
      expect(post: "api/v1/todo_lists/1/todo_items").to route_to("api/v1/todo_items#create", todo_list_id: "1")
     end

     it "routes to #todo_items/update" do
      expect(put: "api/v1/todo_lists/1/todo_items/1").to route_to("api/v1/todo_items#update",todo_list_id: "1", id: "1")
     end

     it "routes to #todo_items/show" do
      expect(get: "api/v1/todo_lists/1/todo_items/1").to route_to("api/v1/todo_items#show",todo_list_id: "1", id: "1")
     end

     it "routes to #todo_items/incomplete" do
        expect(post: "api/v1/todo_lists/1/todo_items/1/incomplete").to route_to("api/v1/todo_items#incomplete",todo_list_id: "1", id: "1")
     end
  
     it "routes to #todo_items/complete" do
        expect(post: "api/v1/todo_lists/1/todo_items/1/complete").to route_to("api/v1/todo_items#complete",todo_list_id: "1", id: "1")
     end

     it "routes to #todo_items/move" do
        expect(post: "api/v1/todo_lists/1/todo_items/1/move").to route_to("api/v1/todo_items#move",todo_list_id: "1", id: "1")
     end

end