<%-- 
    Document   : Principal
    Created on : 17/01/2025, 12:22:59 p. m.
    Author     : oscar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.jsp.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema de Ventas</title>
        <link rel="icon" href="img/logo.png">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    </head>
    <%@ page import="modelo.Empleado" %>
    <%  
    Empleado empleado = (Empleado) request.getAttribute("empleado");
    %>
    <body>
    <nav class="navbar navbar-expand-lg bg-info">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Inicio</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        
      <ul class="navbar-nav">
        <li class="nav-item">
            <a style="margin-left: 10px; border: none;"  class="btn btn-outline-light"  href="Controlador?menu=producto&accion=Listar" target="myFrame">Producto</a>
        </li>
        <li class="nav-item">
          <a style="margin-left: 10px; border: none;"  class="btn btn-outline-light"  href="Controlador?menu=empleado&accion=Listar" target="myFrame">Empleado</a>
        </li>
        <li class="nav-item">
          <a style="margin-left: 10px; border: none;"  class="btn btn-outline-light" href="Controlador?menu=cliente&accion=Listar" target="myFrame">Clientes</a>
        </li>
        <li class="nav-item">
          <a style="margin-left: 10px; border: none;"  class="btn btn-outline-light" href="Controlador?menu=nuevaVenta" target="myFrame">Nueva Venta</a>
        </li>
      </ul>
       </form> 
    </div>
    <div class="dropdown-center">
        <button style="border-none" class="btn btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
            <%= empleado.getNombre() %>
        </button>
        <ul class="dropdown-menu text-center">
<!--          <li><a class="dropdown-item" href="#">Action</a>-->
              <img src="img/usuario.png" alt="" width="70px"/></li>
          <li><a class="dropdown-item" href="dashboard?accion=logout">Salir</a></li>
        </ul>
      </div>
  </div>
</nav>
    <div class="m-4" style="height: 550px;">
        <iframe name="myFrame" style="height: 100%; width: 100%"></iframe>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
