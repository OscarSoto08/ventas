/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import Persistencia.ProductoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import modelo.Producto;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author oscar
 */
public class ProductoController {
    ProductoDAO pDao;

    public ProductoController(ProductoDAO pDao) {
        this.pDao = pDao;
    }

    public ProductoController() {
        this.pDao = new ProductoDAO();
    }
    
    public void listarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        List<Producto> productos = pDao.leerTodos();
        request.setAttribute("productos", productos);
        request.setAttribute("productosActivos", pDao.activos());
        request.setAttribute("totalProductos", pDao.totalProductos());
        request.setAttribute("productoMasRentable", pDao.productoMasRentable());
        
        // No necesitas setear totalVentas aquí, parece que pertenece al Panel de Ventas
        request.getRequestDispatcher("Producto.jsp").forward(request, response);
    }
    
    public void insertarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String nombre = request.getParameter("nombres");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        pDao.insertar(new Producto(nombre, precio, stock, "1"));
        response.sendRedirect("Controlador?menu=producto&accion=Listar");
    }
    
    public void actualizarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        int id = Integer.parseInt(request.getParameter("productoId"));
        String nombre = request.getParameter("nombres");
        double precio = Double.parseDouble(request.getParameter("precio"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        JSONObject jsonResponse = new JSONObject();
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        pDao.editar(new Producto(id, nombre, precio, stock, "1"));
        jsonResponse.put("success", true);
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    public void eliminarProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResponse = new JSONObject();
        int id = Integer.parseInt(request.getParameter("idProducto"));
        if (pDao.eliminar(id)) {
            jsonResponse.put("success", true);
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("ErrorMessage", "No es posible eliminar el articulo con id: " + id + " porque hay ventas asociadas en el inventario");
        }

        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
    
    
    public void filtrarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONArray jsonArray = new JSONArray();
        List<Producto> productos = pDao.filtrar(request.getParameter("filtro"));

        for (Producto p : productos) {
            JSONObject jsonResponse = new JSONObject();
            jsonResponse.put("idProducto", p.getIdProducto());
            jsonResponse.put("nombres", p.getNombres());
            jsonResponse.put("precio", p.getPrecio());
            jsonResponse.put("stock", p.getStock());
            jsonResponse.put("estado", p.getEstado());
            jsonArray.put(jsonResponse);
        }
        PrintWriter out = response.getWriter();
        out.print(jsonArray.toString());
        out.flush();
    }

    public void cambiarEstadoProducto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResp = new JSONObject();
        int id = Integer.parseInt(request.getParameter("idProducto"));
        Producto p = pDao.leer(id);
        String estadoNuevo = ("1".equals(p.getEstado())) ? "0" : "1";
        pDao.cambiarEstado(estadoNuevo, id);
        jsonResp.put("success", true);
        jsonResp.put("activos", pDao.activos());
        PrintWriter out = response.getWriter();
        out.print(jsonResp.toString());
        out.flush();
    }
}
