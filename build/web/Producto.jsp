<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.jsp.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sistema de Gestión de Productos</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <script src="https://kit.fontawesome.com/14596e32cc.js" crossorigin="anonymous"></script>
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #4caf50;
            --danger-color: #f72585;
            --warning-color: #ff9800;
            --dark-color: #2b2d42;
        }

        body {
            background: linear-gradient(135deg, #f6f8fd 0%, #f1f4f9 100%);
            min-height: 100vh;
            font-family: 'Inter', sans-serif;
        }
        
        .navbar-custom {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            padding: 1rem 0;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 600;
        }

        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            background: white;
            overflow: hidden;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 25px rgba(0,0,0,0.1);
        }

        .stats-card {
            padding: 1.5rem;
            text-align: center;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
        }

        .stats-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin: 0 auto 1rem;
            background: linear-gradient(45deg, var(--primary-color), var(--secondary-color));
            color: white;
        }

        .stats-card h3 {
            font-size: 2rem;
            font-weight: 700;
            margin: 0.5rem 0;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .search-container {
            background: white;
            border-radius: 12px;
            padding: 0.75rem 1rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }

        .search-input {
            border: none;
            width: 100%;
            padding: 0.5rem;
            font-size: 1rem;
        }

        .search-input:focus {
            outline: none;
        }

        .table {
            margin: 0;
        }

        .table thead th {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            color: white;
            font-weight: 500;
            border: none;
            padding: 1rem;
            font-size: 0.9rem;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: rgba(67, 97, 238, 0.05);
            transform: scale(1.01);
        }

        .btn {
            border-radius: 10px;
            padding: 0.625rem 1.25rem;
            font-weight: 500;
            transition: all 0.3s ease;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }

        .btn-primary {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border: none;
            box-shadow: 0 2px 10px rgba(67, 97, 238, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.4);
        }

        .btn-warning {
            background: linear-gradient(90deg, #ff9800, #f57c00);
            border: none;
            color: white;
        }

        .btn-danger {
            background: linear-gradient(90deg, #f72585, #dc2f6c);
            border: none;
        }

        .modal-content {
            border-radius: 15px;
            border: none;
            overflow: hidden;
        }

        .modal-header {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            padding: 1.5rem;
        }

        .modal-body {
            padding: 2rem;
        }

        .form-control {
            border-radius: 10px;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
            border-color: var(--primary-color);
        }

        .form-label {
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: var(--dark-color);
        }
        
        .badge {
            padding: 0.5em 1em;
            border-radius: 6px;
            font-weight: 500;
        }
        
        .product-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.25rem;
            margin-right: 1rem;
            background: rgba(67, 97, 238, 0.1);
            color: var(--primary-color);
        }
        
        /* The switch - the box around the slider */
.switch {
  font-size: 17px;
  position: relative;
  display: inline-block;
  width: 3.5em;
  height: 2em;
}

/* Hide default HTML checkbox */
.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}

/* The slider */
.slider {
  position: absolute;
  cursor: pointer;
  inset: 0;
  border: 2px solid #383838;
  border-radius: 50px;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

.slider:before {
  position: absolute;
  content: "";
  height: 1.4em;
  width: 1.4em;
  left: 0.2em;
  bottom: 0.2em;
  background-color: rgb(0, 233, 116);
  border-radius: inherit;
  transition: all 0.4s cubic-bezier(0.23, 1, 0.32, 1);
}

.switch input:checked + .slider {
  box-shadow: 0 0 20px rgba(9, 241, 79, 0.8);
  border: 2px solid #04e763;
}

.switch input:checked + .slider:before {
  transform: translateX(1.5em);
}

    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
            <i class="bi bi-box-seam fs-3 me-2"></i>
            Sistema de Productos
        </a>
    </div>
</nav>

<div class="container py-4">
    <!-- Stats Cards -->
    <div class="row mb-4 animate__animated animate__fadeIn">
        <div class="col-md-4">
            <div class="stats-card">
                <div class="stats-icon">
                    <i class="bi bi-box-seam"></i>
                </div>
                <h5 class="text-muted mb-2">Total Productos</h5>
                <h3>${totalProductos != null ? totalProductos : 0}</h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card">
                <div class="stats-icon">
                    <i class="bi bi-check-circle"></i>
                </div>
                <h5 class="text-muted mb-2">Productos Activos</h5>
                <h3 id="productos_activos">${productosActivos != null ? productosActivos : 0}</h3>
            </div>
        </div>
        <div class="col-md-4">
            <div class="stats-card">
                <div class="stats-icon">
                    <i class="bi bi-graph-up"></i>
                </div>
                <h5 class="text-muted mb-2">Total Ventas</h5>
                <h3>$${totalVentas != null ? totalVentas : 0}</h3>
            </div>
        </div>
    </div>

    <!-- Search and Actions -->
    <div class="card mb-4 animate__animated animate__fadeIn">
        <div class="card-body">
            <div class="row g-3 align-items-center">
                <div class="col-md-8">
                    <div class="search-container">
                        <i class="bi bi-search text-muted me-2"></i>
                        <input type="text" class="search-input" id="busqueda" placeholder="Buscar productos...">
                    </div>
                </div>
                <div class="col-md-4 text-end">
                    <button class="btn btn-primary w-100 nuevo" data-bs-toggle="modal" data-bs-target="#modalProducto">
                        <i class="bi bi-plus-lg me-2"></i>Nuevo Producto
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Products Table -->
    <div class="card animate__animated animate__fadeIn">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Producto</th>
                        <th>Precio</th>
                        <th>Stock</th>
                        <th class="text-end">Acciones</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody id="table-body">
                    <c:forEach var="producto" items="${productos}">
                        <tr>
                            <td>#<span class="idProducto">${producto.getIdProducto()}</span></td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="product-icon">
                                        <i class="bi bi-box"></i>
                                    </div>
                                    <div>
                                        <h6 class="mb-0 nombres">${producto.getNombres()}</h6>
                                        <small class="text-muted">SKU: PRD-${producto.getIdProducto()}</small>
                                    </div>
                                </div>
                            </td>
                            <td>
                                <span class="fw-bold">$<span class="precio">${producto.getPrecio()}</span></span>
                            </td>
                            
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="progress flex-grow-1 me-2" style="height: 6px;">
                                        <div class="progress-bar bg-${producto.getStock() > 10 ? 'success' : 'warning'}" 
                                             style="width: ${producto.getStock() > 100 ? 100 : producto.getStock()}%">
                                        </div>
                                    </div>
                                    <span class="badge bg-${producto.getStock() > 10 ? 'success' : 'warning'} bg-opacity-10 
                                                 text-${producto.getStock() > 10 ? 'success' : 'warning'}">
                                        <span class="stock">${producto.getStock()}</span>
                                    </span>
                                </div>
                            </td>
                            <td class="text-end">
                                <button class="btn btn-warning btn-sm me-2 editar" data-bs-toggle="modal" data-bs-target="#modalProducto">
                                    <i class="bi bi-pencil"></i>
                                </button>
                                <button class="btn btn-danger btn-sm eliminar" data-bs-toggle="modal" data-bs-target="#modalProducto">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </td>
                            <td>
                                <label class="switch">
                                    <input type="checkbox" class="check-status" onchange="cambiarEstado(${producto.getIdProducto()})"
                                           <c:if test="${producto.getEstado() == 1}">checked</c:if>
                                    />
                                    <span class="slider"></span>
                                </label>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
            
<div class="modal fade" id="modalProducto" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="modalTitulo"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="modal-body">
                        <input type='hidden' id='productoId' name='productoId' >
                        <div id='modalMensaje'></div>
                    </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button id="modalBoton" class="btn btn-primary"></button>
                </div>
            </div>
        </div>
    </div>

<script>
    function cambiarEstado(id){
        $.ajax({
            url: "Controlador",
            type: "POST",
            dataType: 'JSON',
            data: {menu:"producto",accion:"CambiarEstado", idProducto: id},
            success: function(response){
                $("#productos_activos").html(response.activos);
            }, error: function(xhr, status, error){
                console.error(error);
            }
        });
    }
    
    $(document).ready(function(){
        let modal_form =  "<form id='modalFormulario'>" +
                            "<input type='hidden' id='productoId' name='productoId' >" +
                            "<div id='modalMensaje'></div>" +
                            "<div class='mb-3'>" +
                                "<label for='productoNombre' class='form-label'>Nombre</label>" +
                                "<input type='text' id='productoNombre' class='form-control'>" +
                            "</div>" +
                            "<div class='mb-3'>" +
                                "<label for='productoPrecio' class='form-label'>Precio</label>" +
                                "<input type='number' id='productoPrecio' class='form-control'>" +
                            "</div>" +
                            "<div class='mb-3'>" +
                                "<label for='productoStock' class='form-label'>Stock</label>" +
                                "<input type='number' id='productoStock' class='form-control'>" +
                            "</div>" +
                        "</form>";


        $(".nuevo").click(function () {
            $("#modalTitulo").text("Agregar Nuevo Producto");
            $("#modal-body").html(modal_form); // Corrected: Use modal-body ID
            $("#modalBoton").text("Guardar").removeClass("btn-danger").addClass("btn-primary");
            $("#modalFormulario").attr("data-action", "guardar"); // Set data-action attribute
        });

        $(".editar").click(function () {
            let id = $(this).closest("tr").find(".idProducto").text().replace("#",""); // Get ID from table row
            let nombre = $(this).closest("tr").find(".nombres").text(); // Get name from table row
            let precio = $(this).closest("tr").find(".precio").text().replace("$",""); // Get price from table row
            let stock = $(this).closest("tr").find(".stock").text(); // Get stock from table row

            $("#modal-body").html(modal_form); // Corrected: Use modal-body ID
            $("#modalTitulo").text("Editar Producto");
            $("#modalBoton").text("Actualizar").removeClass("btn-danger").addClass("btn-primary");
            $("#productoId").val(id);
            $("#productoNombre").val(nombre);
            $("#productoPrecio").val(precio);
            $("#productoStock").val(stock);
            $("#modalFormulario").attr("data-action", "actualizar"); // Set data-action attribute

        });

        $(".eliminar").click(function () {
            let id = $(this).closest("tr").find(".idProducto").text().replace("#",""); // Get ID from table row
            let nombre = $(this).closest("tr").find(".nombres").text(); // Get name from table row

            $("#modalTitulo").text("Eliminar Producto");
            $("#modalBoton").text("Eliminar").removeClass("btn-primary").addClass("btn-danger");

            html = "<form id='modalFormulario'><input type='hidden' id='productoId' /> <div id='modalMensaje'></div></form>";
            
            $("#modal-body").html(html);
            
            $("#productoId").val(id);
            $("#modalMensaje").text("¿Seguro que deseas eliminar el producto '" + nombre +"'?");
            $("#modalFormulario").attr("data-action", "eliminar"); // Set data-action attribute

        });

        $("#modalBoton").click(function() {
            let action = $("#modalFormulario").attr("data-action");
            let id = $("#productoId").val();
            let nombre = $("#productoNombre").val();
            let precio = $("#productoPrecio").val();
            let stock = $("#productoStock").val();

            if (action === "guardar" || action === "actualizar") {
                $.ajax({
                    url: "Controlador",
                    type: "POST", // Use POST for form submissions
                    data: {
                        menu: "producto",
                        accion: action === "guardar" ? "Insertar" : "Actualizar",
                        productoId: id,
                        nombres: nombre,
                        precio: precio,
                        stock: stock
                    },
                    success: function(response) {
                        // Handle success, e.g., reload the page or update the table
                        console.log("Success:", response);
                        window.location.reload(); // Reload the page to reflect changes

                    },
                    error: function(error) {
                        console.error("Error:", error);
                        alert("Ocurrió un error al procesar la solicitud.");
                    }
                });
            } else if (action === "eliminar") {
                $.ajax({
                    url: "Controlador",
                    type: "POST",
                    data: {
                        menu: "producto",
                        accion: "Eliminar",
                        idProducto: id
                    },
                    success: function(response) {
                        console.log("Success:", response);
                        window.location.reload(); // Reload the page
                    },
                    error: function(error) {
                        console.error("Error:", error);
                        alert("Ocurrió un error al eliminar el producto.");
                    }
                });
            }
             $("#modalProducto").modal('hide'); 
        });
        
        let busqueda = $("#busqueda").keyup(function(){
        let filtro = busqueda.val(); // Get the filter value
        if (filtro.length >= 3 || filtro.length === 0) { // Search if at least 3 characters or empty
            $.ajax({
                url: "Controlador",
                type: "GET",
                data: {menu: "producto", accion: "Filtrar", filtro: filtro},
                dataType: "JSON",
                success: function (response){
                    let html = "";
                    if(response.length > 0){
                        response.forEach(function(producto){
                            html += generateTableRow(producto); // Use a function to generate rows
                        });
                    }else{
                        html += "<tr><td colspan='5'>No se encontraron resultados.</td></tr>";
                    }

                    $("#table-body").html(html);
                },
                error: function(xhr, status, error){
                    console.error("Error en la petición Ajax:", error);
                    $("#table-body").html("<tr><td colspan='5'>Error al cargar los productos.</td></tr>"); // Display error message
                }
            });
        }
    });
    
    function generateTableRow(producto) {
        isChecked = (producto.estado === "1") ? "checked" : "";
    return "<tr>" +
        "<td>#<span class='idProducto'>" + producto.idProducto + "</span></td>" +
        "<td>" +
            "<div class='d-flex align-items-center'>" +
                "<div class='product-icon'>" +
                    "<i class='bi bi-box'></i>" +
                "</div>" +
                "<div>" +
                    "<h6 class='mb-0 nombres'>" + producto.nombres + "</h6>" +
                    "<small class='text-muted'>SKU: PRD-" + producto.idProducto + "</small>" +
                "</div>" +
            "</div>" +
        "</td>" +
        "<td><span class='fw-bold'>$<span class='precio'>" + producto.precio + "</span></span></td>" +
        "<td>" +
            "<div class='d-flex align-items-center'>" +
                "<div class='progress flex-grow-1 me-2' style='height: 6px;'>" +
                    "<div class='progress-bar bg-" + (producto.stock > 10 ? 'success' : 'warning') + "' style='width: " + (producto.stock > 100 ? 100 : producto.stock) + "%'></div>" +
                "</div>" +
                "<span class='badge bg-" + (producto.stock > 10 ? 'success' : 'warning') + " bg-opacity-10 text-" + (producto.stock > 10 ? 'success' : 'warning') + "'>" +
                    "<span class='stock'>" + producto.stock + "</span>" +
                "</span>" +
            "</div>" +
        "</td>" +
        "<td class='text-end'>" +
            "<button class='btn btn-warning btn-sm me-2 editar' data-bs-toggle='modal' data-bs-target='#modalProducto'>" + // data-target corrected
                "<i class='bi bi-pencil'></i>" +
            "</button>" +
            "<button class='btn btn-danger btn-sm eliminar' data-bs-toggle='modal' data-bs-target='#modalProducto'>" + // data-target corrected
                "<i class='bi bi-trash'></i>" +
            "</button>" +
        "</td>" +
        "<td>" +
            "<label class='switch'>" +
                "<input type='checkbox' class='check-status' onchange='cambiarEstado(" +producto.idProducto+")' " + isChecked +
                " />" +
                "<span class='slider'></span>" +
            "</label>" +
        "</td>"+
    "</tr>";
}

    
    
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>