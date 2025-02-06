<%-- 
    Document   : Principal
    Created on : 17/01/2025, 12:22:59 p. m.
    Author     : oscar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sistema de Ventas</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link rel="icon" href="img/logo.png">
    </head>
    <body>
        <div class="container col-lg-4 mt-4">
            <div class="card col-sm-10">
                <div class="card-body">
                    <form class="form-sign" action="dashboard" method="POST">
                        <div class="form-group my-3 text-center">
                            <h3>Login</h3>
                            <img src="img/logo.png" alt="Logo ventas" width="100"/>
                            <label>Bienvendos al sistema de ventas</label>
                        </div>
                        <div class="form-group my-3">
                            <label for="user">Usuario:</label>
                            <input id="user" type="email" class="form-control" name="user"/>
                        </div>
                        <div class="form-group my-3">
                            <label for="password">Contraseña</label>
                            <input id="password" type="password" class="form-control" name="password"/>
                        </div>
                        <input type="submit" class="btn btn-primary" name="accion" value="ingresar"/>
                    </form>
                </div>
            </div>
        </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
    </body>
</html>
