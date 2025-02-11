<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jakarta.servlet.jsp.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales Insight Pro</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <!-- Feather Icons -->
    <script src="https://unpkg.com/feather-icons"></script>
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #6a11cb 0%, #2575fc 100%);
            --secondary-gradient: linear-gradient(to right, #25b8fc, #b266de);
        }
        body {
            background-color: #f4f6f9;
            font-family: 'Inter', sans-serif;   
        }
        .sidebar {
            background: var(--primary-gradient);
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }
        .stat-card {
            background: var(--secondary-gradient);
            color: white;
        }
        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Contenido principal -->
            <main class="col-md-12 p-4">
                <div class="row mb-4">
                    <!-- Tarjetas de estadï¿½sticas -->
                    <div class="col-md-3">
                        <div class="card stat-card text-white">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-2">Ventas Totales</h6>
                                    <h3>$${ingresosActuales}</h3>
                                    <small class="text-success font-bold">
                                        <i data-feather="arrow-up" class="me-1" style="width: 16px;"></i>
                                        Este mes (${fechaActual})
                                    </small>
                                </div>
                                <i data-feather="dollar-sign" class="text-white-50" style="width: 48px; height: 48px;"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card text-white">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-2">Número de Ventas</h6>
                                    <h3>${numeroVentas}</h3>
                                </div>
                                <i data-feather="shopping-bag" class="text-white-50" style="width: 48px; height: 48px;"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card text-white">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-2">Productos Vendidos</h6>
                                    <h3>${productosVendidos}</h3>
                                </div>
                                <i data-feather="package" class="text-white-50" style="width: 48px; height: 48px;"></i>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stat-card text-white">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="text-white-50 mb-2">Clientes Frecuentes</h6>
                                    <h3>${ClientesFrecuentes}</h3>
                                    <small class="text-success font-bold">
                                        <i data-feather="arrow-up" class="me-1" style="width: 16px;"></i>
                                        ${porcentajeClientesFrecuentes}% este mes
                                    </small>
                                </div>
                                <i data-feather="users" class="text-white-50" style="width: 48px; height: 48px;"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Secciï¿½n de Grï¿½ficos -->
                <div class="row">
                    <div class="col-md-8">
                        <div class="card chart-container h-100">
                            <div class="card-body">
                                <h5 class="card-title mb-4">Rendimiento de Ventas Mensual</h5>
                                <canvas id="monthlySalesChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card chart-container h-100">
                            <div class="card-body">
                                <h5 class="card-title mb-4">Distribución de Ventas por Producto</h5>
                                <canvas id="productSalesChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Tabla de ï¿½ltimas Ventas -->
                <div class="card mt-4">
                    <div class="card-body">
                        <h5 class="card-title mb-3">Últimas Transacciones</h5>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID Venta</th>
                                        <th>Cliente</th>
                                        <th>Empleado</th>
                                        <th>Fecha</th>
                                        <th>Monto</th>
                                        <th>Estado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="venta" items="${ventas}">
                                    <tr>
                                        <td>${venta.getId()}</td>
                                        <td>${venta.getCliente().getNombres()}</td>
                                        <td>${venta.getEmpleado().getNombre()}</td>
                                        <td>${venta.getFecha()}</td>
                                        <td>$${venta.getMonto()}</td>
                                        <td><span class="badge bg-success">Completado</span></td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </main>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- JQuery -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <script>       
        $(document).ready(function(){
    $.ajax({
        url: 'Controlador',
        method: 'GET',
        data: {menu: "panelVentas", accion: "IngresosPorMes"},
        success: function(data) {
            console.log(data)

            // Preparar arrays para labels y data del chart
            var labelsMeses = [];
            var ingresosData = [];

            // Iterar sobre los datos recibidos del backend
            for(var i = 0; i < data.length; i++) {
                var item = data[i];
                var mesAnio = item.Mes; // "YYYY-MM"
                var ingresos = item.IngresosTotales;

                // Formatear el label del mes (ej: "2024-01" a "Ene-24")
                var partesMes = mesAnio.split('-');
                var anio = partesMes[0].substring(2); // Obtener los dos últimos dígitos del año
                var numeroMes = parseInt(partesMes[1]); // Convertir el mes a número

                var nombreMeses = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
                var nombreMes = nombreMeses[numeroMes - 1]; // Meses en array son base 0

                labelsMeses.push(nombreMes + '-' + anio);
                ingresosData.push(ingresos);
            }

            // Crear el chart con los datos dinámicos
            new Chart(document.getElementById('monthlySalesChart'), {
                type: 'line',
                data: {
                    labels: labelsMeses, // Usar los labels de meses formateados
                    datasets: [{
                        label: 'Ventas',
                        data: ingresosData, // Usar los ingresos del backend
                        borderColor: '#2575fc',
                        backgroundColor: 'rgba(37, 117, 252, 0.1)',
                        tension: 0.4
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: false }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                callback: function(value) {
                                    return '$' + value;
                                }
                            }
                        }
                    }
                }
            });
        },
        error: function() {
            alert('Error al obtener los datos');
        }
    });
    
    $(document).ready(function(){
    $.ajax({
        url: 'Controlador',
        method: 'GET',
        data: {menu: "panelVentas", accion: "VentasPorProducto"},
        success: function(data) {
            console.log(data)

            // Preparar arrays para labels y data del chart de productos
            var labelsProductos = [];
            var ventasProductosData = [];
            var backgroundColors = [ // Array de colores para el doughnut chart
                '#6a11cb', '#2575fc', '#4BC0C0',
                '#9966FF', '#FF9F40', '#C71585',
                '#008080', '#FFA07A'
            ];

            // Iterar sobre los datos recibidos del backend
            for(var i = 0; i < data.length; i++) {
                var item = data[i];
                var producto = item.Mes; // "Mes" en este contexto es el nombre del producto
                var cantidadVentas = item.IngresosTotales; // "IngresosTotales" es la cantidad de ventas

                labelsProductos.push(producto);
                ventasProductosData.push(cantidadVentas);
            }

            // Crear el chart de doughnut con los datos dinámicos
            new Chart(document.getElementById('productSalesChart'), {
                type: 'doughnut',
                data: {
                    labels: labelsProductos, // Usar los nombres de productos como labels
                    datasets: [{
                        data: ventasProductosData, // Usar la cantidad de ventas por producto
                        backgroundColor: backgroundColors // Usar el array de colores
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                boxWidth: 20
                            }
                        }
                    }
                }
            });
        },
        error: function() {
            alert('Error al obtener los datos');
        }
    });
});
});
        
    </script>
</body>
</html>