<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<title>Dashboard</title>
</head>
<body>

<div class="container mt-4">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <h2>Welcome, ${user.firstName}</h2>
    <form id="logoutForm" method="POST" action="/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input class="btn btn-danger" type="submit" value="Logout!" />
    </form>
  </div>
  <div class="row">
    <div class="d-flex flex-column col-3">
      <a href="/play/computer">Play Computer</a>
      <a href="/play/online">Play Online</a>
    </div>
    <div class="col-6">
      <p>Select an option on the left to get started.</p>
    </div>
    <div class="col-3">
      <h5>Friends</h5>
    </div>
  </div>
</div>

</body>
</html>