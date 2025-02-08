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
                                    <h3>$45,230</h3>
                                    <small class="text-success font-bold">
                                        <i data-feather="arrow-up" class="me-1" style="width: 16px;"></i>
                                        12.5% este mes
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
                                    <h3>127</h3>
                                    <small class="text-success font-bold">
                                        <i data-feather="arrow-up" class="me-1" style="width: 16px;"></i>
                                        8.2% este mes
                                    </small>
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
                                    <h3>346</h3>
                                    <small class="text-danger font-bold">
                                        <i data-feather="arrow-down" class="me-1" style="width: 16px;"></i>
                                        3.7% este mes
                                    </small>
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
                                        <th>Fecha</th>
                                        <th>Monto</th>
                                        <th>Estado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>#00007</td>
                                        <td>Maria Rosas</td>
                                        <td>06/02/2025</td>
                                        <td>$1,000</td>
                                        <td><span class="badge bg-success">Completado</span></td>
                                    </tr>
                                    <tr>
                                        <td>#00006</td>
                                        <td>Andres Casanare</td>
                                        <td>06/02/2025</td>
                                        <td>$600</td>
                                        <td><span class="badge bg-success">Completado</span></td>
                                    </tr>
                                    <!-- Mï¿½s filas de ejemplo -->
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
    <script>
        // Inicializar iconos
        feather.replace();

        // Grï¿½fico de Ventas Mensuales
        new Chart(document.getElementById('monthlySalesChart'), {
            type: 'line',
            data: {
                labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'],
                datasets: [{
                    label: 'Ventas',
                    data: [12000, 19000, 15000, 22000, 18000, 25000],
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

        // Grï¿½fico de Distribuciï¿½n de Ventas por Producto
        new Chart(document.getElementById('productSalesChart'), {
            type: 'doughnut',
            data: {
                labels: ['Laptop', 'Auriculares', 'Mouse', 'Celular', 'Teclado'],
                datasets: [{
                    data: [30, 20, 15, 25, 10],
                    backgroundColor: [
                        '#6a11cb', '#2575fc', '#4BC0C0', 
                        '#9966FF', '#FF9F40'
                    ]
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
    </script>
</body>
</html>