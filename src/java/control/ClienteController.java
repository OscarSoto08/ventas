/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import Persistencia.ClienteDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import modelo.Cliente;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author oscar
 */
public class ClienteController {
    ClienteDAO cDao = new ClienteDAO();
    
    public void listarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        List<Cliente> clientes = cDao.leerTodos();
        request.setAttribute("clientes", clientes);
        request.setAttribute("activos", cDao.clientesActivos());
        request.setAttribute("total", cDao.totalClientes());
        request.getRequestDispatcher("Clientes.jsp").forward(request, response);
    }
    
    public void agregarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        JSONObject jsonResp = new JSONObject();
        String nombres = request.getParameter("nombres");
        String dni = request.getParameter("dni");
        String direccion = request.getParameter("direccion");
        String estado = request.getParameter("estado");
        cDao.insertar(new Cliente(dni, nombres, direccion, estado));
        jsonResp.put("success", true);
        PrintWriter out = response.getWriter();
        out.print(jsonResp.toString());
        out.flush();
    }
    
    public void eliminarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        JSONObject jsonResp = new JSONObject();
        if(cDao.eliminar(Integer.parseInt(request.getParameter("id"))) == true){
            jsonResp.put("success", true);
        }else{
            jsonResp.put("success", false);
            jsonResp.put("ErrorMessage", "El cliente que está tratando de eliminar está vinculado al historial de ventas, no es posible eliminarlo");
        }
        PrintWriter out = response.getWriter();
        out.print(jsonResp.toString());
        out.flush();
    }
    
    public void actualizarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        int id = Integer.parseInt(request.getParameter("id"));
        String nombres = request.getParameter("nombres");
        String dni = request.getParameter("dni");
        String direccion = request.getParameter("direccion");
        String estado = request.getParameter("estado");

        JSONObject jsonResp = new JSONObject();
        cDao.editar(new Cliente( id, dni, nombres, direccion, estado));
        jsonResp.put("success", true);
        PrintWriter out = response.getWriter();
        out.print(jsonResp.toString());
        out.flush();
    }
    
    public void filtrarCliente(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        JSONArray jsArr = new JSONArray();
        List<Cliente> clientes = cDao.filtrar(request.getParameter("filtro"));
        for (Cliente cliente1 : clientes) {
            JSONObject jsObj = new JSONObject();
            jsObj.put("id", cliente1.getIdCliente());
            jsObj.put("dni", cliente1.getDni());
            jsObj.put("nombres", cliente1.getNombres());
            jsObj.put("direccion", cliente1.getDireccion());
            jsObj.put("estado", cliente1.getEstado());
            jsArr.put(jsObj);
        }
        out.print(jsArr.toString());
        out.flush();
    }
}
