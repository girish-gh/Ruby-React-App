import React from "react";
import ReactDOM from "react-dom";
import PropTypes from "prop-types";
import TodoLists from "../components/TodoLists";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import TodoItems from "../components/TodoItems";
import Search from "../components/Search";

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <>
      <React.StrictMode>
        <BrowserRouter>
          <Routes>
            <Route path="/" element={<TodoLists />} exact />
            <Route
              path="/:todoListId/todo-items"
              element={<TodoItems />}
              exact
            />
            <Route path="/search" element={<Search />} exact />
          </Routes>
        </BrowserRouter>
      </React.StrictMode>
    </>,
    document.body.appendChild(document.createElement("div"))
  );
});
