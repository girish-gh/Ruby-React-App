import React, { useState } from "react";
import styles from "../components/TodoItem.module.css";
import axios from "axios";
import { Link } from "react-router-dom";
import Modal from "react-modal";

const TodoItem = (props) => {
  const [modalIsOpen, setIsOpen] = React.useState(false);
  const [todoItemId, setTodoItemId] = React.useState(0);
  const [todoItemName, setTodoItemName] = React.useState("");
  const [todoItemIsRecurring, setTodoItemIsRecurring] = React.useState(false);
  const [todoItemTags, setTodoItemTags] = useState(["To do"]);

  const deleteLink =
    "http://localhost:3000/api/v1/todo_lists/" +
    props.todolistid +
    "/todo_items/" +
    props.id;

  const moveItemLink =
    "http://localhost:3000/api/v1/todo_lists/" +
    props.todolistid +
    "/todo_items/" +
    props.id +
    "/move";

  let postLink =
    "http://localhost:3000/api/v1/todo_lists/" +
    props.todolistid +
    "/todo_items/" +
    props.id +
    "/complete";
  
  let completeLinkText = "Complete";
  if (props.completed === "Yes") {
    completeLinkText = "Incomplete";
    postLink =
      "http://localhost:3000/api/v1/todo_lists/" +
      props.todolistid +
      "/todo_items/" +
      props.id +
      "/incomplete";
  }

  const completeTodoItem = async () => {
    try {
      const response = await axios.post(postLink);
      if (!response.statusText === "OK") {
        throw new Error("An error has occured");
      } else {
        props.onCompleteToDoItem(response.data.message);
      }
    } catch (error) {
      props.onCompleteToDoItem(error.message);
    }
  };

  const deleteTodoItem = async () => {
    if (window.confirm("Deleting TodoItem, are you sure?") === true) {
      try {
        const response = await axios.delete(deleteLink);
        if (!response.statusText === "OK") {
          throw new Error("An error has occured");
        } else {
          props.onDeleteTodoItem(response.data.message);
        }
      } catch (error) {
        props.onDeleteTodoItem(error.message);
      }
    }
  };

  const moveTodoItem = async (event) => {
    if (window.confirm("Moving TodoItem, are you sure?") === true) {
      try {
        const response = await axios.post(moveItemLink, {
          newtodo: event.target.options[event.target.selectedIndex].id,
        });
        if (!response.statusText === "OK") {
          throw new Error("An error has occured");
        } else {
          props.onMoveTodoItem(response.data.message);
        }
      } catch (error) {
        props.onMoveTodoItem(error.message);
      }
    }
  };

  const openModal = (id, name, isRecurring, tags) => {
    setTodoItemId(id);
    setTodoItemName(name);

    if (isRecurring.toLowerCase() === "no") {
      isRecurring = false;
    } else {
      isRecurring = true;
    }

    setTodoItemIsRecurring(isRecurring);
    const temptags = tags.map((name) => name.tagname);
    setTodoItemTags(temptags.toString());
    setIsOpen(true);
  };

  const closeModal = () => {
    setIsOpen(false);
  };

  const nameChangeHandler = (event) => {
    setTodoItemName(event.target.value);
  };

  const isRecurringChangeHandler = (event) => {
    setTodoItemIsRecurring(event.target.checked);
  };

  const tagsChangeHandler = (event) => {
    setTodoItemTags(event.target.value);
  };

  const onUpdateTodoHander = async (id) => {

    const updateLink =
      "http://localhost:3000/api/v1/todo_lists/" +
      props.todolistid +
      "/todo_items/" +
      id;
    try {
      const todo_list_item = {
        name: todoItemName,
        isRecurring: todoItemIsRecurring,
        tagname: todoItemTags,
        todo_list_id: +props.todolistid,
        id: +id,
      };

      const response = await axios.patch(updateLink, todo_list_item);
      if (!response.statusText === "OK") {
        throw new Error("An error has occured");
      } else {
        props.onTodoItemUpdate(response.data.message);
        closeModal();
      }
    } catch (error) {
      props.onTodoItemUpdate("Update failed");
    }
    closeModal();
  };

  const customStyles = {
    content: {
      top: "50%",
      left: "50%",
      right: "auto",
      bottom: "auto",
      marginRight: "-50%",
      transform: "translate(-50%, -50%)",
      width: 800,
      height: 400,
    },
  };

  return (
    <React.Fragment>
      <div className={styles.row}>
        <div className={styles.cell}>{props.name}</div>
        <div className={styles.cell}>{props.isComplete}</div>
        <div className={styles.cell}>{props.isRecurring}</div>
        <div className={styles.cell}>{props.completedOn}</div>
        <div className={styles.cell}>
          {props.tags.map((item) => {
            return <div key={item.id}>{item.tagname}</div>;
          })}
        </div>
        <div className={styles.cell}>
          <Link to="#" onClick={completeTodoItem}>
            {completeLinkText}
          </Link>
        </div>
        <div className={styles.cell}>
          <select onChange={moveTodoItem}>
            <option key="0" id="0">
              Select
            </option>
            {props.todolists
              .filter(function (item) {
                return item.id != props.todolistid;
              })
              .map((item) => {
                return (
                  <option key={item.id} id={item.id}>
                    {item.title}
                  </option>
                );
              })}
          </select>
        </div>
        <div className={styles.cell}>
          <Link
            to="#"
            onClick={() =>
              openModal(props.id, props.name, props.isRecurring, props.tags)
            }
          >
            Edit
          </Link>
        </div>

        <div className={styles.cell}>
          <Link to="#" onClick={deleteTodoItem}>
            Delete
          </Link>
        </div>
      </div>

      <Modal
        isOpen={modalIsOpen}
        onRequestClose={closeModal}
        contentLabel="Edit Todo"
        style={customStyles}
        ariaHideApp={false}
      >
        Edit Todo Item
        <h1>{todoItemName}</h1>
        <div className={styles.table}>
          <div className={styles.row}>
            <div className={styles.tablecell}>
              <label>Name</label>
            </div>
            <div className={styles.tablecell}>
              <input
                type="text"
                value={todoItemName}
                onChange={nameChangeHandler}
                style={{ width: 400 }}
              ></input>
            </div>
          </div>
          <div className={styles.row}>
            <div className={styles.tablecell}>
              <label>isRecurring</label>
            </div>
            <div className={styles.tablecell}>
              <input
                type="checkbox"
                checked={todoItemIsRecurring}
                onChange={isRecurringChangeHandler}
              />
            </div>
          </div>
          <div className={styles.row}>
            <div className={styles.tablecell}>
              <label>Tags</label>
            </div>
            <div className={styles.tablecell}>
              <textarea
                value={todoItemTags}
                style={{ height: 50, width: 400 }}
                onChange={tagsChangeHandler}
              ></textarea>
            </div>
          </div>
        </div>
        <button onClick={() => onUpdateTodoHander(props.id)}>
          Update TodoItem
        </button>
        <button onClick={closeModal}>Cancel</button>
      </Modal>
    </React.Fragment>
  );
};

export default TodoItem;
