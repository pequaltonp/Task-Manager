<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
      <%@ include file="vendor/bootstrapCDN.jsp"%>
      <title>Task Manager</title>
  </head>
  <body>
  <%@ include file="vendor/navbar.jsp"%>
  <!-- FOR FILTERING -->
  <nav class="navbar navbar-expand-sm bg-light">
      <form class="form-inline" action="/filter" method="get">
          <label for="name1" class="mb-2 mr-sm-4">Name:</label>
          <input type="text" class="form-control mb-2 mr-sm-5" id="name1" placeholder="Enter Name" name="name">
          <label for="from1" class="mb-2 mr-sm-4">Deadline from:</label>
          <input type="date" class="form-control mb-2 mr-sm-5" id="from1" placeholder="Enter Surname" name="from">
          <label for="to1" class="mb-2 mr-sm-4">Deadline to:</label>
          <input type="date" class="form-control mb-2 mr-sm-5" id="to1" name="to">
          <div class="form-group">
              <label for ="select" class="mb-2 mr-sm-4">Completed:</label>
              <select class="form-control mb-2 mr-sm-5" id="select" name="is comp">
                  <option>YES</option>
                  <option>NO</option>
              </select>
          </div>
          <button type="submit" class="btn text-light bg-info mb-2">Filter</button>
      </form>

  </nav>

  <!-- FOR MODAL -->
  <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">New Task</h5>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                  </button>
              </div>
              <div class="modal-body">
                  <form action="/add" class="was-validated">
                      <div class="form-group">
                          <label for="task-name" class="col-form-label">Task Name:</label>
                          <input type="text" class="form-control is-invalid" id="task-name"
                          name="name" placeholder = "Task name..." required>
                      </div>
                      <div class="form-group">
                          <label for="task-des" class="col-form-label" >Task Description:</label>
                          <textarea class="form-control" id="task-des" name="description"
                                    placeholder="Description..."></textarea>
                          <label for="task-date" class="col-form-label">Deadline Date:</label>
                          <input type="date" class="form-control is-invalid" id="task-date"
                                 name="deadline" required>
                      </div>
                      <div class="modal-footer">
                      <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                      <input type="submit" class="btn btn-primary" value="Add Task" />
                      </div>
                  </form>
              </div>

          </div>

      </div>
  </div>

  <div class="container">
      <br>
      <button type="button" class="btn btn-info" data-toggle="modal" data-target="#exampleModal" data-whatever="@mdo">
          + ADD NEW TASK</button>
      <br><br>
      <table class="table table-hover">
          <thead>
          <tr>
              <th>ID</th>
              <th>NAME</th>
              <th>DESCRIPTION</th>
              <th>DEADLINE</th>
              <th>IS COMPLETED</th>
              <th>DETAILS</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="temp" items="${taskList}">
          <tr>
                  <td>${temp.id}</td>
                  <td>${temp.name}</td>
                  <td>${temp.description}</td>
                  <td>${temp.deadline}</td>
                  <td>${temp.completed}</td>
                  <td><a class="btn text-light bg-info" href="/processTask?id=${temp.id}">UPDATE</a></td>
          </tr>
          </c:forEach>
          </tbody>
      </table>
  </div>


  </body>
</html>
