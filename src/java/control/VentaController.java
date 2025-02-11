/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package control;

import Persistencia.ClienteDAO;
import Persistencia.ProductoDAO;
import Persistencia.VentaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author oscar
 */
public class VentaController {
    private VentaDAO vDao;
    private ClienteDAO cDao;
    private ProductoDAO pDao;
    private DecimalFormat df;

    public VentaController() {
        this.pDao = new ProductoDAO();
        this.vDao = new VentaDAO();
        this.cDao = new ClienteDAO();
        this.df = new DecimalFormat("#.00");
    }
    
    public void ListarVentas(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException{
        int clientesFrecuentes = vDao.ClientesFrecuentes();
        int totalClientes = cDao.totalClientes();
        double porcentajeClientesFrecuentes = ((double)clientesFrecuentes / totalClientes) *100;
        String[] datosIngresosActuales = vDao.IngresosActuales();
        String fechaActual = datosIngresosActuales[0];
        double ingresosActuales = Double.parseDouble(datosIngresosActuales[1]);
        
        
        request.setAttribute("ClientesFrecuentes", clientesFrecuentes);
        request.setAttribute("porcentajeClientesFrecuentes", df.format(porcentajeClientesFrecuentes));
        request.setAttribute("productosVendidos", pDao.productosVendidos());
        request.setAttribute("fechaActual", fechaActual);
        request.setAttribute("ingresosActuales", df.format(ingresosActuales));
        request.setAttribute("numeroVentas", vDao.numeroVentas());
        request.setAttribute("ventas", vDao.leerTodos());
        
        request.getRequestDispatcher("PanelVentas.jsp").forward(request, response);
    }
    
    public void VentasPorProducto(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException{
        // Obtener los ingresos por mes en una lista de mapas
        List<Map<String, Object>> ventasPorProducto = vDao.VentasPorProducto();

        // Convertir la lista de mapas a un JSONArray
        JSONArray jsonArray = new JSONArray();
        for (Map<String, Object> v : ventasPorProducto) {
            JSONObject jsonIngreso = new JSONObject(v);
            jsonArray.put(jsonIngreso);  // Añadir el JSONObject al JSONArray
        }

        // Establecer el tipo de contenido como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el JSON como respuesta
        PrintWriter out = response.getWriter();
        out.print(jsonArray.toString());
        out.flush();
    }
    
    public void IngresosPorMes(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException{
        // Obtener los ingresos por mes en una lista de mapas
        List<Map<String, Object>> ingresosPorMes = vDao.obtenerIngresosPorMes();

        // Convertir la lista de mapas a un JSONArray
        JSONArray jsonArray = new JSONArray();
        for (Map<String, Object> ingreso : ingresosPorMes) {
            JSONObject jsonIngreso = new JSONObject(ingreso);
            jsonArray.put(jsonIngreso);  // Añadir el JSONObject al JSONArray
        }

        // Establecer el tipo de contenido como JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Enviar el JSON como respuesta
        PrintWriter out = response.getWriter();
        out.print(jsonArray.toString());
        out.flush();
    }
}
