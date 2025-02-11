/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import Persistencia.EmpleadoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import modelo.Empleado;

/**
 *
 * @author oscar
 */
public class EmpleadoController {
    EmpleadoDAO edao = new EmpleadoDAO();
    
    public void ListarEmpleado(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        List<Empleado> lista = edao.leerTodos();
        request.setAttribute("empleados", lista);
        request.getRequestDispatcher("Empleado.jsp").forward(request, response);
    }
}
