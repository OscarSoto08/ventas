<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Venta</title>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .btn {
            border-radius: 25px;
            transition: all 0.3s;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
        .table th {
            background-color: #0dcaf0;
            color: white;
            text-align: center;
        }
        .table-hover tbody tr:hover {
            background-color: #e3f2fd;
        }
        .input-group-text {
            background-color: #e9ecef;
            color: #495057;
            font-weight: bold;
        }
        .footer-total {
            font-size: 1.2em;
            font-weight: bold;
        }
        @media print {
            .parte-01, .btn {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <!-- Panel Izquierdo -->
            <div class="col-md-5 parte-01">
                <div class="card p-3">
                    <div class="card-body">
                        <h5 class="card-title text-primary"><i class="fas fa-user"></i> Datos del Cliente</h5>
                        <form action="Controlador?menu=nuevaVenta" method="post">
                            <div class="input-group mb-3">
                                <input type="text" name="codigoCliente" class="form-control" value="${cliente.getDni()}" placeholder="Código" required/>
                                <button type="submit" name="accion" value="Buscar Cliente" class="btn btn-outline-info"><i class="fas fa-search"></i></button>
                            </div>
                            <input type="text" name="nombresCliente" value="${cliente.getNombres()}" class="form-control mb-3" placeholder="Datos Cliente" readonly/>
                            
                            <h5 class="card-title text-success mt-4"><i class="fas fa-box"></i> Datos Producto</h5>
                            <div class="input-group mb-3">
                                <input type="text" name="codigoProducto" value="${producto.getIdProducto()}" class="form-control" placeholder="Código"/>
                                <button type="submit" name="accion" value="Buscar Producto" class="btn btn-outline-info"><i class="fas fa-search"></i></button>
                            </div>
                            <input type="text" name="nombreProducto" class="form-control mb-3" value="${producto.getNombres()}" placeholder="Datos Producto" readonly/>
                            
                            <div class="input-group mb-3">
                                <span class="input-group-text">Precio</span>
                                <input type="text" name="precio" class="form-control" value="${producto.getPrecio()}" readonly/>
                                <span class="input-group-text">Stock</span>
                                <input type="text" name="stock" class="form-control" value="${producto.getStock()}" readonly/>
                                <span class="input-group-text">Cantidad</span>
                                <input type="number" name="cantidad" class="form-control" value="1" min="1" max="10"/>
                            </div>
                            <button type="submit" name="accion" value="Agregar" class="btn btn-outline-info w-100"><i class="fas fa-plus"></i> Agregar</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Panel Derecho -->
            <div class="col-md-7">
                <div class="card p-3">
                    <div class="card-body">
                        <h5 class="card-title text-primary"><i class="fas fa-shopping-cart"></i> Detalles de la Venta</h5>
                        <div class="mb-3">
                            <label>Numero de serie</label>
                            <input type="text" name="NroSerie" value="${nSerie}" readonly class="form-control"/>
                        </div>
                        <table class="table table-hover text-center">
                            <thead>
                                <tr>
                                    <th>Nro</th>
                                    <th>Código</th>
                                    <th>Descripción</th>
                                    <th>Precio</th>
                                    <th>Cantidad</th>
                                    <th>Subtotal</th>
                                    <th class="parte-01">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="list" items="${lista}">
                                    <tr>
                                        <td>${list.getItem()}</td>
                                        <td>${list.getIdProducto()}</td>
                                        <td>${list.getDescripcion()}</td>
                                        <td>$${list.getPrecio()}</td>
                                        <td>${list.getCantidad()}</td>
                                        <td>$${list.getSubtotal()}</td>
                                        <td>
                                            <a href="Controlador?menu=nuevaVenta&accion=EditarProducto&idProducto=${list.getItem()}" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i></a>
                                            <a href="Controlador?menu=nuevaVenta&accion=EliminarProducto&item=${list.getItem()}&idProducto=${list.getIdProducto()}" class="btn btn-danger btn-sm"><i class="fas fa-trash"></i></a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="card-footer d-flex justify-content-between align-items-center">
                        <form action="Controlador?menu=nuevaVenta" method="post">
                            <button type="submit" name="accion" value="Generar Venta" class="btn btn-success" onclick="print()"><i class="fas fa-check"></i> Generar Venta</button>
                            <button type="submit" name="accion" value="Cancelar Venta" class="btn btn-danger"><i class="fas fa-times"></i> Cancelar</button>
                        </form>
                        <div class="footer-total">
                            Total: <input type="text" name="txtTotal" value="$./ ${total}" class="form-control" readonly style="width: 150px; display: inline-block;"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" crossorigin="anonymous"></script>
</body>
</html>
