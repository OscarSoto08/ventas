<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.jsp.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestión de Clientes</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #6366f1;
            --secondary-color: #4f46e5;
            --success-color: #22c55e;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --info-color: #3b82f6;
            --dark-color: #1e293b;
            --light-color: #f8fafc;
        }

        body {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
        }

        .navbar-custom {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .card {
            border: none;
            border-radius: 16px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .stats-card {
            background: white;
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .stats-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        }

        .stats-icon {
            width: 48px;
            height: 48px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 1rem;
        }

        .table {
            border-radius: 16px;
            overflow: hidden;
        }

        .table thead th {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            color: white;
            font-weight: 500;
            border: none;
            padding: 1rem;
            font-size: 0.875rem;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(99, 102, 241, 0.05);
            transform: scale(1.01);
        }

        .client-avatar {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 500;
            font-size: 1.25rem;
        }

        .badge {
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-weight: 500;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .btn {
            border-radius: 10px;
            padding: 0.625rem 1.25rem;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .btn-primary {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border: none;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .search-box {
            background: white;
            border-radius: 12px;
            padding: 0.5rem 1rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .search-box input {
            border: none;
            padding: 0.5rem;
            width: 100%;
        }

        .search-box input:focus {
            outline: none;
        }

        .modal-content {
            border-radius: 16px;
            border: none;
        }

        .modal-header {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 16px 16px 0 0;
            padding: 1.5rem;
        }

        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1px solid #e2e8f0;
            transition: all 0.2s ease;
        }

        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            border-color: var(--primary-color);
        }
        
        .btn {
          display: flex; /* Para alinear icono y texto */
          align-items: center;
        }

        .btn-secondary {
          background-color: #ddd;
          color: #555;
          border: none;
          padding: 10px 20px;
          border-radius: 5px;
          margin-right: 10px;
          transition: background-color 0.3s ease;
        }

        .btn-secondary:hover {
          background-color: #ccc;
        }

        .btn-danger {
          background-color: #dc3545;
          color: #fff;
          border: none;
          padding: 10px 20px;
          border-radius: 5px;
          transition: background-color 0.3s ease;
        }

        .btn-danger:hover {
          background-color: #c30010;
        }

        /* Estilos específicos del botón de confirmar */
        .btn-confirmar {
          background-color: #d9534f; /* Rojo más oscuro */
        }

        .btn-confirmar:hover {
          background-color: #c0392b; /* Rojo aún más oscuro */
        }


    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark navbar-custom mb-4">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <i class="bi bi-people-fill fs-3 me-2"></i>
            <span class="fs-4">Gestión de Clientes</span>
        </a>
    </div>
</nav>

<div class="container">
    <!-- Stats Cards -->
    <div class="row animate__animated animate__fadeIn">
        <div class="col-md-6">
            <div class="stats-card">
                <div class="stats-icon bg-primary text-white">
                    <i class="bi bi-people"></i>
                </div>
                <h3 class="fw-bold">${total}</h3>
                <p class="text-muted mb-0">Total Clientes</p>
            </div>
        </div>
        <div class="col-md-6">
            <div class="stats-card">
                <div class="stats-icon bg-success text-white">
                    <i class="bi bi-person-check"></i>
                </div>
                <h3 class="fw-bold">${activos}</h3>
                <p class="text-muted mb-0">Clientes Activos</p>
            </div>
        </div>
    </div>

    <!-- Search and Actions -->
    <div class="card mb-4 animate__animated animate__fadeIn">
        <div class="card-body">
            <div class="row g-3 align-items-center">
                <div class="col-md-6">
                    <div class="search-box">
                        <i class="bi bi-search text-muted"></i>
                        <input type="text" id="searchInput" placeholder="Buscar clientes...">
                    </div>
                </div>
                <div class="col-md-3">
                    <select class="form-select" id="estadoFilter">
                        <option value="">Todos los estados</option>
                        <option value="1">Activo</option>
                        <option value="0">Inactivo</option>
                    </select>
                </div>
                <div class="col-md-3 text-end">
                    <button type="button" id="btn-nuevo" class="btn btn-primary">
                        <i class="bi bi-plus-lg me-2"></i>Nuevo Cliente
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Clients Table -->
    <div class="card animate__animated animate__fadeIn">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead>
                        <tr>
                            <th>Dni</th>
                            <th>ID</th>
                            <th>Cliente</th>
                            <th>Dirección</th>
                            <th>Estado</th>
                            <th class="text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cliente" items="${clientes}">
                            <tr class="align-middle">
                                <td>
                                    <div class="d-flex align-items-center">
                                        <h6 class="dni">${cliente.getDni()}</h6>
                                    </div>
                                </td>
                                <td>#<span class="idCliente">${cliente.getIdCliente()}</span></td>
                                <td>
                                    <div class="d-flex align-items-center">
                                            <h6 class="mb-0  nombres">${cliente.getNombres()}</h6>
                                    </div>
                                </td>
                                
                                <td>
                                    <div class="d-flex align-items-center">
                                        <h6 class="direccion">${cliente.getDireccion()}</h6>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-${cliente.getEstado() == 1 ? 'success' : 'danger'} bg-opacity-10 
                                                 text-${cliente.getEstado() == 1 ? 'success' : 'danger'}">
                                        <i class="bi bi-circle-fill me-1 small"></i>
                                        <span class="estado">${cliente.getEstado() == 1 ? 'Activo' : 'Inactivo'}</span>
                                    </span>
                                </td>
                                <td class="text-end">
                                    <button class="btn btn-light btn-sm me-2 btn-editar">
                                        <i class="bi bi-pencil text-primary"></i>
                                    </button>
                                    <button class="btn btn-light btn-sm" onclick="modalEliminar(${cliente.getIdCliente()})">
                                        <i class="bi bi-trash text-danger"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Modal para Agregar/Editar Cliente -->
<div class="modal fade" id="clienteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header border-0">
                <h5 class="modal-title" id="modalTitle">
                    <i class="bi bi-person-plus me-2"></i>
                    <span id="modalTitleText">Nuevo Cliente</span>
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" id="clienteForm">
                <div class="modal-body" id="modal-body">
                    <input type="hidden" name="id" id="clienteId">
                    
                    <div class="mb-4">
                        <label class="form-label">Nombres</label>
                        <div class="input-group">
                            <span class="input-group-text border-0 bg-light">
                                <i class="bi bi-person"></i>
                            </span>
                            <input type="text" 
                                   class="form-control" 
                                   name="nombres"
                                   id="nombres-form"
                                   required
                                   placeholder="Ingrese los nombres completos"
                                   minlength="3"
                                   maxlength="100">
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label">Dirección</label>
                        <div class="input-group">
                            <span class="input-group-text border-0 bg-light">
                                <i class="bi bi-geo-alt"></i>
                            </span>
                            <input type="text" 
                                   class="form-control" 
                                   name="direccion" 
                                   id="direccion-form"
                                   required
                                   placeholder="Ingrese la dirección completa">
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label">Dni</label>
                        <div class="input-group">
                            <span class="input-group-text border-0 bg-light">
                                <i class="bi bi-file-person-fill"></i>
                            </span>
                            <input type="number" 
                                   class="form-control" 
                                   name="dni" 
                                   id="dni-form"
                                   required
                                   placeholder="Ingrese el numero del dni">
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label d-block">Estado</label>
                        <div class="form-check form-switch">
                            <input class="form-check-input" 
                                   type="checkbox" 
                                   name="estado" 
                                   id="estado-form" 
                                   role="switch"
                                   checked />
                            <label class="form-check-label" for="estadoSwitch">
                                <span class="text-success">Activo</span>
                            </label>
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0 pt-0">
                    <button type="button" 
                            class="btn btn-light" 
                            data-bs-dismiss="modal">
                        <i class="bi bi-x-lg me-2"></i>Cancelar
                    </button>
                    <button type="submit" 
                            class="btn btn-primary" id="btn-submit-modal">
                        <i class="bi bi-check-lg me-2"></i><span id="txt-submit-modal">Guardar Cambios</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
<!--Modal para eliminar-->
<div class="modal fade" id="modalEliminar" tabindex="-1" aria-labelledby="modalEliminarLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="modalEliminarLabel">
            <i class="fas fa-exclamation-triangle mr-2"></i> Confirmar Eliminación
          </h5>
          <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body" id="modal-body-eliminar">
          ¿Estás seguro de que deseas eliminar este elemento? Esta acción no se puede deshacer.
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
            <i class="fas fa-times mr-2"></i> Cancelar
          </button>
          <button type="button" class="btn btn-danger btn-confirmar" onclick="deleteCliente()">
            <i class="fas fa-trash-alt mr-2"></i> Eliminar
          </button>
        </div>
      </div>
    </div>
  </div>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script>
$(document).ready(function() { // Wrap in document ready for best practice

    function modalEliminar(id) {
        const modalDelete = new bootstrap.Modal(document.getElementById('modalEliminar'));
        $("#modal-body-eliminar").attr("data-id", id);
        modalDelete.show();
    }

    function deleteCliente() {
        id = $("#modal-body-eliminar").attr("data-id");
        $.ajax({
            url: "Controlador",
            data: { id: id, menu: "cliente", accion: "Eliminar" },
            dataType: "JSON",
            type: "POST",
            success: function (response) {
                window.location.reload(); // Simplest: just reload the page
            },
            error: function (xhr, status, error) {
                console.error(error);
            }
        });
    }

    $("#btn-nuevo").on("click", function () {
        $("#clienteForm").attr("data-action", "agregar");
        $("#clienteForm")[0].reset();
        $("#txt-submit-modal").text("Guardar Cambios");
        const modal = new bootstrap.Modal(document.getElementById("clienteModal"));
        modal.show();
    });

    $(".btn-editar").on("click", function () {
        fila = $(this).closest("tr");
        id = fila.find(".idCliente").text();
        nombres = fila.find(".nombres").text();
        direccion = fila.find(".direccion").text();
        dni = fila.find(".dni").text();
        estado = fila.find(".estado").text() === "Activo" ? 1 : 0; // Store as 1 or 0

        $("#clienteForm").attr("data-action", "actualizar");
        $("#clienteId").val(id);
        $("#nombres-form").val(nombres);
        $("#direccion-form").val(direccion);
        $("#dni-form").val(dni);
        $("#estado-form").prop("checked", estado === 1); // Set checked based on 1 or 0
        $("#txt-submit-modal").text("Actualizar");
        const modal = new bootstrap.Modal(document.getElementById("clienteModal"));
        modal.show();
    });


    $("#clienteForm").on("submit", function (event) {  // Use form submit event
        event.preventDefault(); // Prevent default form submission

        id = $("#clienteId").val(); // Correctly get the id value
        nombres = $("#nombres-form").val();
        direccion = $("#direccion-form").val();
        dni = $("#dni-form").val();
        estado = ($("#estado-form").is(":checked")) ? "1" : "0";

        data = {};
        switch ($("#clienteForm").attr("data-action")) {
            case "actualizar":
                data = {
                    id: id,
                    nombres: nombres,
                    direccion: direccion,
                    dni: dni,
                    estado: estado,
                    accion: "Actualizar",
                    menu: "cliente"
                };
                break;
            case "agregar":
                data = {
                    nombres: nombres,
                    direccion: direccion,
                    dni: dni,   
                    estado: estado,
                    accion: "Agregar",
                    menu: "cliente"
                };
                break;
        }

        $.ajax({
            url: "Controlador",
            data: data,
            dataType: "JSON",
            type: "POST",
            success: function (response) {
                console.log("Success:", response); // Log the response for debugging
                    window.location.reload();
            },
            error: function (xhr, status, error) {
                console.error("Error:", error);
                // Handle errors, e.g., display an error message to the user
                alert("An error occurred: " + error);
            }
        });
    });
});
</script>
</body>
</html>