<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <%@ include file="vendor/bootstrapCDN.jsp"%>
        <title>Task Manager</title>
    </head>
    <body>
    <%@ include file="vendor/navbar.jsp"%>
    <div class="container">
        <form class="was-validated" action="/update">
            <div class="form-group" style="display: none">
                <input name="id" value="${task.id}" readonly>
            </div>
            <div class="form-group">
                <label>TASK NAME :</label>
                <input type="text" class="form-control" name="name" value="${task.name}" required>
                <div class="valid-feedback">Valid</div>
                <div class="invalid-feedback">Please fill out this field</div>
            </div>
            <div class="form-group">
                <label >DESCRIPTION :</label>
                <textarea class="form-control" name="description">${task.description}</textarea>
            </div>
            <div class="form-group">
                <label>TASK DEADLINE DATE :</label>
                <input type="date" class="form-control" name="deadline" value="${task.deadline}" required>
                <div class="valid-feedback">Valid</div>
                <div class="invalid-feedback">Please fill out this field.</div>
            </div>
            <div class="form-group">
                <label>COMPLETED :</label>
                <select class="form-control" name="compl">
                    <option>YES</option>
                    <option>NO</option>
                </select>
            </div>

            <div class="clearfix">
                <button class="btn btn-success text-light float-left" type="submit">SAVE</button>
                    <div class="clearfix">
                        <a class="btn btn-danger text-light float-right"
                       href="${pageContext.request.contextPath}/delete?id=${task.id}">DELETE</a>
                    </div>
            </div>
        </form>
    </div>

    </body>
</html>
