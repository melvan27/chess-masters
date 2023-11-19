<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true"%>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
  <head>
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Profile Page</title>
    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-divider {
        width: 100%;
        height: 3rem;
        background-color: rgba(0, 0, 0, 0.1);
        border: solid rgba(0, 0, 0, 0.15);
        border-width: 1px 0;
        box-shadow: inset 0 0.5em 1.5em rgba(0, 0, 0, 0.1),
          inset 0 0.125em 0.5em rgba(0, 0, 0, 0.15);
      }

      .b-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -0.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }

      .btn-bd-primary {
        --bd-violet-bg: #712cf9;
        --bd-violet-rgb: 112.520718, 44.062154, 249.437846;

        --bs-btn-font-weight: 600;
        --bs-btn-color: var(--bs-white);
        --bs-btn-bg: var(--bd-violet-bg);
        --bs-btn-border-color: var(--bd-violet-bg);
        --bs-btn-hover-color: var(--bs-white);
        --bs-btn-hover-bg: #6528e0;
        --bs-btn-hover-border-color: #6528e0;
        --bs-btn-focus-shadow-rgb: var(--bd-violet-rgb);
        --bs-btn-active-color: var(--bs-btn-hover-color);
        --bs-btn-active-bg: #5a23c8;
        --bs-btn-active-border-color: #5a23c8;
      }

      .bd-mode-toggle {
        z-index: 1500;
      }

      .bd-mode-toggle .dropdown-menu .active .bi {
        display: block !important;
      }
    </style>
  </head>
  <body>
    <svg xmlns="http://www.w3.org/2000/svg" class="d-none">
      <symbol id="bootstrap" viewBox="0 0 118 94">
        <path fill-rule="evenodd" clip-rule="evenodd" d="M24.509 0c-6.733 0-11.715 5.893-11.492 12.284.214 6.14-.064 14.092-2.066 20.577C8.943 39.365 5.547 43.485 0 44.014v5.972c5.547.529 8.943 4.649 10.951 11.153 2.002 6.485 2.28 14.437 2.066 20.577C12.794 88.106 17.776 94 24.51 94H93.5c6.733 0 11.714-5.893 11.491-12.284-.214-6.14.064-14.092 2.066-20.577 2.009-6.504 5.396-10.624 10.943-11.153v-5.972c-5.547-.529-8.934-4.649-10.943-11.153-2.002-6.484-2.28-14.437-2.066-20.577C105.214 5.894 100.233 0 93.5 0H24.508zM80 57.863C80 66.663 73.436 72 62.543 72H44a2 2 0 01-2-2V24a2 2 0 012-2h18.437c9.083 0 15.044 4.92 15.044 12.474 0 5.302-4.01 10.049-9.119 10.88v.277C75.317 46.394 80 51.21 80 57.863zM60.521 28.34H49.948v14.934h8.905c6.884 0 10.68-2.772 10.68-7.727 0-4.643-3.264-7.207-9.012-7.207zM49.948 49.2v16.458H60.91c7.167 0 10.964-2.876 10.964-8.281 0-5.406-3.903-8.178-11.425-8.178H49.948z"></path>
      </symbol>
      <symbol id="logo" viewBox="0 0 300 300">
        <g transform="translate(0,300) scale(0.1,-0.1)" fill="#000000" stroke="none">
          <path d="M2183 2159 c-116 -22 -210 -97 -261 -207 -22 -48 -26 -70 -25 -137 1
          -44 3 -91 5 -105 3 -23 0 -25 -90 -38 -92 -14 -93 -15 -107 -49 -8 -20 -15
          -61 -15 -93 l0 -58 65 -31 c36 -16 65 -34 65 -39 0 -22 -130 -140 -190 -172
          -55 -29 -75 -35 -130 -34 -54 0 -76 6 -130 33 -65 34 -190 147 -190 173 0 7
          28 27 63 43 l62 30 0 60 c-1 88 -19 118 -78 127 -147 24 -142 23 -137 43 3 11
          5 61 5 110 0 76 -4 99 -26 145 -32 69 -95 132 -168 168 -49 24 -67 27 -151 27
          -84 0 -102 -4 -152 -29 -70 -34 -131 -98 -166 -174 -23 -48 -27 -71 -27 -142
          0 -71 4 -94 26 -140 34 -74 81 -125 146 -162 29 -16 53 -32 53 -36 0 -3 -21
          -39 -46 -79 -34 -54 -44 -80 -40 -98 7 -28 47 -77 86 -105 l28 -20 63 30 c59
          27 64 28 74 12 5 -9 10 -71 10 -137 -1 -108 -3 -126 -28 -185 -15 -36 -44 -92
          -63 -124 -74 -125 -82 -255 -23 -406 17 -44 35 -80 40 -80 5 0 178 79 385 175
          206 96 378 175 380 175 3 0 176 -79 383 -175 208 -96 383 -175 388 -175 13 0
          58 100 74 163 6 27 10 84 7 132 -4 80 -7 90 -70 213 -37 72 -71 155 -78 188
          -13 61 -8 230 7 245 4 4 37 -6 72 -22 l64 -29 33 25 c44 34 84 87 84 112 0 11
          -10 35 -23 54 -27 40 -67 109 -67 114 0 2 17 12 38 22 20 9 59 39 85 65 177
          176 122 471 -107 573 -58 26 -141 36 -203 24z m-1308 -79 c144 -69 207 -217
          156 -369 -12 -35 -21 -65 -19 -66 2 -1 55 -11 118 -21 l115 -19 3 -51 3 -51
          -76 -33 c-41 -18 -75 -36 -75 -40 0 -18 75 -118 118 -159 85 -79 173 -119 333
          -151 115 -23 169 -50 232 -115 43 -44 95 -130 86 -140 -17 -17 -1103 -515
          -1114 -511 -15 5 -44 97 -52 165 -7 62 19 161 61 232 74 124 114 273 101 374
          -10 76 -36 175 -47 175 -5 0 -31 -11 -59 -25 -91 -46 -95 -47 -129 -19 -16 14
          -30 34 -30 45 0 10 25 60 56 110 30 50 52 95 47 99 -4 4 -26 12 -49 18 -88 25
          -166 108 -191 204 -17 67 -17 103 2 165 52 175 246 261 410 183z"/>
        </g>
      </symbol>
      <symbol id="home" viewBox="0 0 16 16">
        <path d="M8.354 1.146a.5.5 0 0 0-.708 0l-6 6A.5.5 0 0 0 1.5 7.5v7a.5.5 0 0 0 .5.5h4.5a.5.5 0 0 0 .5-.5v-4h2v4a.5.5 0 0 0 .5.5H14a.5.5 0 0 0 .5-.5v-7a.5.5 0 0 0-.146-.354L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.354 1.146zM2.5 14V7.707l5.5-5.5 5.5 5.5V14H10v-4a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v4H2.5z"></path>
      </symbol>
      <symbol id="cpu" viewBox="0 0 16 16">
        <path d="M5 0a.5.5 0 0 1 .5.5V2h1V.5a.5.5 0 0 1 1 0V2h1V.5a.5.5 0 0 1 1 0V2h1V.5a.5.5 0 0 1 1 0V2A2.5 2.5 0 0 1 14 4.5h1.5a.5.5 0 0 1 0 1H14v1h1.5a.5.5 0 0 1 0 1H14v1h1.5a.5.5 0 0 1 0 1H14v1h1.5a.5.5 0 0 1 0 1H14a2.5 2.5 0 0 1-2.5 2.5v1.5a.5.5 0 0 1-1 0V14h-1v1.5a.5.5 0 0 1-1 0V14h-1v1.5a.5.5 0 0 1-1 0V14h-1v1.5a.5.5 0 0 1-1 0V14A2.5 2.5 0 0 1 2 11.5H.5a.5.5 0 0 1 0-1H2v-1H.5a.5.5 0 0 1 0-1H2v-1H.5a.5.5 0 0 1 0-1H2v-1H.5a.5.5 0 0 1 0-1H2A2.5 2.5 0 0 1 4.5 2V.5A.5.5 0 0 1 5 0zm-.5 3A1.5 1.5 0 0 0 3 4.5v7A1.5 1.5 0 0 0 4.5 13h7a1.5 1.5 0 0 0 1.5-1.5v-7A1.5 1.5 0 0 0 11.5 3h-7zM5 6.5A1.5 1.5 0 0 1 6.5 5h3A1.5 1.5 0 0 1 11 6.5v3A1.5 1.5 0 0 1 9.5 11h-3A1.5 1.5 0 0 1 5 9.5v-3zM6.5 6a.5.5 0 0 0-.5.5v3a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5v-3a.5.5 0 0 0-.5-.5h-3z"/>
      </symbol>
      <symbol id="globe" viewBox="0 0 16 16">
        <path d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm7.5-6.923c-.67.204-1.335.82-1.887 1.855A7.97 7.97 0 0 0 5.145 4H7.5V1.077zM4.09 4a9.267 9.267 0 0 1 .64-1.539 6.7 6.7 0 0 1 .597-.933A7.025 7.025 0 0 0 2.255 4H4.09zm-.582 3.5c.03-.877.138-1.718.312-2.5H1.674a6.958 6.958 0 0 0-.656 2.5h2.49zM4.847 5a12.5 12.5 0 0 0-.338 2.5H7.5V5H4.847zM8.5 5v2.5h2.99a12.495 12.495 0 0 0-.337-2.5H8.5zM4.51 8.5a12.5 12.5 0 0 0 .337 2.5H7.5V8.5H4.51zm3.99 0V11h2.653c.187-.765.306-1.608.338-2.5H8.5zM5.145 12c.138.386.295.744.468 1.068.552 1.035 1.218 1.65 1.887 1.855V12H5.145zm.182 2.472a6.696 6.696 0 0 1-.597-.933A9.268 9.268 0 0 1 4.09 12H2.255a7.024 7.024 0 0 0 3.072 2.472zM3.82 11a13.652 13.652 0 0 1-.312-2.5h-2.49c.062.89.291 1.733.656 2.5H3.82zm6.853 3.472A7.024 7.024 0 0 0 13.745 12H11.91a9.27 9.27 0 0 1-.64 1.539 6.688 6.688 0 0 1-.597.933zM8.5 12v2.923c.67-.204 1.335-.82 1.887-1.855.173-.324.33-.682.468-1.068H8.5zm3.68-1h2.146c.365-.767.594-1.61.656-2.5h-2.49a13.65 13.65 0 0 1-.312 2.5zm2.802-3.5a6.959 6.959 0 0 0-.656-2.5H12.18c.174.782.282 1.623.312 2.5h2.49zM11.27 2.461c.247.464.462.98.64 1.539h1.835a7.024 7.024 0 0 0-3.072-2.472c.218.284.418.598.597.933zM10.855 4a7.966 7.966 0 0 0-.468-1.068C9.835 1.897 9.17 1.282 8.5 1.077V4h2.355z"/>
      </symbol>
      <symbol id="people-fill" viewBox="0 0 16 16">
        <path d="M7 14s-1 0-1-1 1-4 5-4 5 3 5 4-1 1-1 1H7Zm4-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm-5.784 6A2.238 2.238 0 0 1 5 13c0-1.355.68-2.75 1.936-3.72A6.325 6.325 0 0 0 5 9c-4 0-5 3-5 4s1 1 1 1h4.216ZM4.5 8a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
      </symbol>
    </svg>
    <div class="d-flex flex-nowrap">
      <div class="d-flex flex-column flex-shrink-0 p-3 bg-body-tertiary" style="width: 280px">
        <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
          <svg class="bi pe-none me-2" width="40" height="40"><use xlink:href="#logo"></use></svg>
          <span class="fs-4">Chess Masters</span>
        </a>
        <hr />
        <ul class="nav nav-pills flex-column mb-auto">
          <li class="nav-item">
            <a href="/home" class="nav-link active" aria-current="page">
              <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#home"></use></svg>
              Home
            </a>
          </li>
          <li>
            <a href="/play/computer" class="nav-link link-body-emphasis">
              <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#cpu"></use></svg>
              Play vs Computer
            </a>
          </li>
          <li>
            <a href="/play/online" class="nav-link link-body-emphasis">
              <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#globe"></use></svg>
              Play Online
            </a>
          </li>
          <li>
            <a href="/friends" class="nav-link link-body-emphasis">
              <svg class="bi pe-none me-2" width="16" height="16"><use xlink:href="#people-fill"></use></svg>
              Friends
              <c:if test="${requestCount > 0}">
              <span class="badge bg-danger">${requestCount}</span>
            </c:if>
            </a>
          </li>
        </ul>
        <hr />
        <div class="dropdown">
          <a href="#" class="d-flex align-items-center link-body-emphasis text-decoration-none dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
            <img src="data:image/*;base64,${base64ProfilePicture}" alt="" width="32" height="32" class="rounded-circle me-2"/>
            <strong>${username}</strong>
          </a>
          <ul class="dropdown-menu text-small shadow">
            <li><a class="dropdown-item" href="/settings">Settings</a></li>
            <li><a class="dropdown-item" href="/profile">Profile</a></li>
            <li><hr class="dropdown-divider" /></li>
            <li>
              <form id="logoutForm" method="POST" action="/logout">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <input class="dropdown-item" type="submit" value="Logout!" />
              </form>
            </li>
          </ul>
        </div>
      </div>

      <div class="b-divider b-vr"></div>
      <div class="container mt-4">
        <h1>Edit Profile</h1>
        <div class="card w-50 mx-auto">
          <div class="card-body">
            <form:form action="/profile" method="PUT" modelAttribute="user" enctype="multipart/form-data">
              <form:hidden path="id" />
              <img src="data:image/*;base64,${base64ProfilePicture}" class="rounded-circle mx-auto d-block" width="200" height="200" />
              <div class="form-group mb-3">
                <label for="pictureFile">Profile Picture:</label>
                <form:input path="pictureFile" id="pictureFile" class="form-control" type="file" />
                <form:errors path="pictureFile" class="text-danger" />
              </div>
              <div class="form-group mb-3">
                <label for="firstName">First Name:</label>
                <form:input path="firstName" id="firstName" class="form-control" />
                <form:errors path="firstName" class="text-danger" />
              </div>
              <div class="form-group mb-3">
                <label for="lastName">Last Name:</label>
                <form:input path="lastName" id="lastName" class="form-control" />
                <form:errors path="lastName" class="text-danger" />
              </div>
              <div class="form-group mb-3">
                <label for="username">Username:</label>
                <form:input path="username" id="username" class="form-control" />
                <form:errors path="username" class="text-danger" />
              </div>
              <div class="form-group mb-3">
                <label for="email">Email:</label>
                <form:input path="email" id="email" class="form-control" />
                <form:errors path="email" class="text-danger" />
              </div>
              <button type="submit" class="btn btn-primary">Save Changes</button>
            </form:form>
          </div>
        </div>
      </div>
    </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
