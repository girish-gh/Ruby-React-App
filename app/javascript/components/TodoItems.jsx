import React, { useState, useEffect } from "react";
import styles from "../components/TodoItems.module.css";
import { useParams } from "react-router-dom";
import TodoItem from "../components/TodoItem";
import axios from "axios";
import { Link } from "react-router-dom";
import TableHead from "../components/TableHead";
import TodoItemForm from "../components/TodoItemForm";

const TodoItems = () => {
  const params = useParams();

  const todosLink = "http://localhost:3000/api/v1/todo_lists";
  const todoItemsLink =
    "http://localhost:3000/api/v1/todo_lists/" +
    params.todoListId +
    "/todo_items";

  const [topMessage, setTopMessage] = useState("");
  const [todoitems, setTodoItems] = useState([]);
  const [tag, setTags] = useState([]);
  const [todolists, setTodoLists] = useState([]);

  let defaultList = <p>No records found.</p>;

  useEffect(() => {
    fetchItemsDataHandler();
    fetchAllTodoLists();
  }, []);

  const fetchAllTodoLists = async () => {
    try {
      const response = await axios.get(todosLink);
      if (!response.statusText === "OK") {
        throw new Error("An error has occured");
      } else {
        setTodoLists(response.data);
      }
    } catch (error) {
      console.log(error.message);
    }
  };

  const fetchItemsDataHandler = async () => {
    try {
      const response = await axios.get(todoItemsLink);
      if (!response.statusText === "OK") {
        throw new Error("An error has occured");
      } else {
        setTodoItems(response.data);
      }
    } catch (error) {
      console.log(error.message);
    }
  };

  const Refresh = (message) => {
    fetchItemsDataHandler();
    setTopMessage(message);
  };

  const onCompleteTodoHandler = (message) => {
    Refresh(message);
  };

  const onDeleteTodoHandler = (message) => {
    Refresh(message);
  };

  const onMoveTodoHandler = (message) => {
    Refresh(message);
  };

  const onAddTodoItemHandler = (message) => {
    fetchItemsDataHandler();
    setTopMessage(message);
  };

  const onTodoItemUpdatedHandler = (message) => {
    fetchItemsDataHandler();
    setTopMessage(message);
  };

  if (todoitems.length > 0) {
    defaultList = todoitems.map((list) => (
      <TodoItem
        key={list.id}
        id={list.id}
        todolistid={params.todoListId}
        name={list.name}
        isComplete={list.isComplete ? "Yes" : "No"}
        completedOn={list.completedOn ? list.completedOn : "Incomplete"}
        isRecurring={list.isRecurring}
        tags={list.tags}
        todolists={todolists}
        onTodoItemUpdate={onTodoItemUpdatedHandler}
        onCompleteToDoItem={onCompleteTodoHandler}
        onDeleteTodoItem={onDeleteTodoHandler}
        onMoveTodoItem={onMoveTodoHandler}
      ></TodoItem>
    ));
  }

  return (
    <React.Fragment>      
      <div>
        <h1>Todo Items for --{params.title}</h1>
        <p className={styles.notice}>{topMessage}</p>
        <div className={styles}>
          <TableHead type="2"></TableHead>
          {defaultList}
          <Link to="/">Back</Link>
        </div>
        <br />
        <br />
        <div className={styles.bottombox}>
          <TodoItemForm
            todolistid={params.todoListId}
            onAddTodoItem={onAddTodoItemHandler}
            onTodoItemUpdate={onTodoItemUpdatedHandler}
          ></TodoItemForm>
        </div>
      </div>
    </React.Fragment>
  );
};

export default TodoItems;
