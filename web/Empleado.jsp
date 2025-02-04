<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jakarta.servlet.jsp.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Empleados</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
    <style>
        body {
            background: #f0f4f8;
            font-family: 'Inter', sans-serif;
        }
        .header {
            background: #4f46e5;
            color: white;
            padding: 20px;
            border-radius: 0 0 20px 20px;
            text-align: center;
        }
        .card {
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
        }
        .table {
            border-radius: 16px;
            overflow: hidden;
        }
        .table thead th {
            background: linear-gradient(90deg, #4f46e5, #6366f1);
            color: white;
            font-weight: bold;
        }
        .table tbody tr:hover {
            background-color: rgba(99, 102, 241, 0.1);
        }
        .btn {
            border-radius: 10px;
            transition: all 0.2s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .form-control {
            border-radius: 10px;
            transition: all 0.2s ease;
        }
        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.2);
            border-color: #6366f1;
        }
        .header-title {
            font-size: 1.5rem;
            font-weight: bold;
            color: #ffffff;
        }
        .form-section {
            background: #ffffff;
            padding: 20px;
            border-radius: 16px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .table-section {
            background: #ffffff;
            padding: 20px;
            border-radius: 16px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .footer {
            text-align: center;
            padding: 10px;
            font-size: 0.9rem;
            color: #666;
        }
    </style>
</head>
<body>

<div class="container my-5">
    <div class="header">
        <h1 class="header-title">Gestión de Empleados</h1>
    </div>
    <div class="row mt-4">
        <div class="col-sm-4">
            <div class="form-section mb-4">
                <h5 class="header-title">Formulario de Empleado</h5>
                <form action="Controlador?menu=empleado" method="post">
                    <input type="hidden" name="txtId" value="${empleado.getId()}" />
                    <div class="form-group my-3">
                        <label for="txtDni">DNI</label>
                        <input type="text" id="txtDni" name="txtDni" value="${empleado.getDni()}" class="form-control" required/>
                    </div>
                    <div class="form-group my-3">
                        <label for="txtNombres">Nombres</label>
                        <input type="text" id="txtNombres" name="txtNombre" value="${empleado.getNombre()}" class="form-control"/>
                    </div>
                    <div class="form-group my-3">
                        <label for="txtNombres">Correo</label>
                        <input type="text" id="txtCorreo" name="txtCorreo" value="${empleado.getCorreo()}" class="form-control"/>
                    </div>
                    <div class="form-group my-3">
                        <label for="txtTelefono">Teléfono</label>
                        <input type="text" id="txtTelefono" name="txtTelefono" value="${empleado.getTelefono()}" class="form-control"/>
                    </div>
                    <div class="form-group my-3">
                        <label for="txtEstado">Estado</label>
                        <input type="text" id="txtEstado" name="txtEstado" value="${empleado.getEstado()}" class="form-control" required maxlength="1" pattern=".{1}"/>
                    </div>
                    <div class="form-group my-3">
                        <label for="txtUsuario">Usuario</label>
                        <input type="text" id="txtUsuario" name="txtUsuario" value="${empleado.getUsuario()}" class="form-control"/>
                    </div>
                    <div class="d-flex justify-content-between">
                        <input type="submit" class="btn btn-primary" name="accion" value="Agregar"/>
                        <input type="submit" class="btn btn-success" name="accion" value="Actualizar"/>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-sm-8">
            <div class="table-section">
                <h5 class="header-title">Lista de Empleados</h5>
                <table class="table">
                    <thead>
                        <tr>    
                            <th>ID</th>
                            <th>DNI</th>
                            <th>NOMBRES</th>
                            <th>CORREO</th>
                            <th>TELEFONO</th>
                            <th>ESTADO</th>
                            <th>USER</th>
                            <th>ACCIONES</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="em" items="${empleados}">
                            <tr>
                                <td>${em.getId()}</td>
                                <td>${em.getDni()}</td>
                                <td>${em.getNombre()}</td>
                                <td>${em.getCorreo()}</td>
                                <td>${em.getTelefono()}</td>
                                <td>${em.getEstado()}</td>
                                <td>${em.getUsuario()}</td>
                                <td>
                                    <a class="btn btn-warning" href="Controlador?menu=empleado&accion=Editar&idEmpleado=${em.getId()}">Editar</a>
                                    <a class="btn btn-danger" href="Controlador?menu=empleado&accion=Eliminar&idEmpleado=${em.getId()}">Eliminar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>