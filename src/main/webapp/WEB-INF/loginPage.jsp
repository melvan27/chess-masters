<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Login Page</title>
  </head>
  <body>
    <c:if test="${logoutMessage != null}">
      <c:out value="${logoutMessage}"></c:out>
    </c:if>


    <div class="container mt-4">
      <div class="mb-4">
        <h1 class="text-primary text-center">Welcome to Chess Masters!</h1>
      </div>
      <div class="row">
        <div class="col-6">
          <h2 class="text-center">Register</h2>
          <div class="card">
            <div class="card-body">
              <form:form action="/register" method="post" modelAttribute="user">
                <div class="mb-3">
                  <form:label path="firstName">First Name</form:label>
                  <form:input path="firstName" class="form-control ${hasUserNameError ? 'is-invalid' : ''}" />
                  <form:errors path="firstName" class="text-danger" />
                </div>
                <div class="mb-3">
                  <form:label path="lastName">Last Name</form:label>
                  <form:input path="lastName" class="form-control ${hasUserNameError ? 'is-invalid' : ''}" />
                  <form:errors path="lastName" class="text-danger" />
                </div>
                <div class="mb-3">
                  <form:label path="username">User Name</form:label>
                  <form:input path="username" class="form-control ${hasUserNameError ? 'is-invalid' : ''}" />
                  <form:errors path="username" class="text-danger" />
                </div>
                <div class="mb-3">
                  <form:label path="email">Email</form:label>
                  <form:input path="email" class="form-control ${hasEmailError ? 'is-invalid' : ''}" />
                  <form:errors path="email" class="text-danger" />
                </div>
                <div class="mb-3">
                  <form:label path="password">Password</form:label>
                  <form:input path="password" class="form-control ${hasPasswordError ? 'is-invalid' : ''}" type="password" />
                  <form:errors path="password" class="text-danger" />
                </div>
                <div class="mb-3">
                  <form:label path="passwordConfirmation">Confirm PW</form:label>
                  <form:input path="passwordConfirmation" class="form-control ${hasConfirmError ? 'is-invalid' : ''}" type="password" />
                  <form:errors path="passwordConfirmation" class="text-danger" />
                </div>
                <div class="d-flex justify-content-end">
                  <input class="btn btn-primary" type="submit" value="Register" />
                </div>
              </form:form>
            </div>
          </div>
        </div>
        <div class="col-6">
          <h2 class="text-center">Login</h2>
          <div class="card">
            <div class="card-body">
              <form:form action="/login" method="post" modelAttribute="user">
                <div class="mb-3">
                  <form:label path="email">Email</form:label>
                  <form:input path="email" class="form-control ${hasEmailError2 ? 'is-invalid' : ''}" />
                </div>
                <div class="mb-3">
                  <form:label path="password">Password</form:label>
                  <form:input path="password" class="form-control ${hasPasswordError2 ? 'is-invalid' : ''}" type="password" />
                </div>
                <c:if test="${errorMessage != null}">
                  <p class="text-danger"><c:out value="${errorMessage}"></c:out></p>
                </c:if>
                <div class="d-flex justify-content-end">
                  <input class="btn btn-primary" type="submit" value="Login" />
                </div>
              </form:form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
