/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import Persistencia.ClienteDAO;
import Persistencia.EmpleadoDAO;
import Persistencia.ProductoDAO;
import Persistencia.VentaDAO;
import config.GenerarSerie;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.*;
import java.text.DecimalFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.Cliente;
import modelo.Empleado;
import modelo.Producto;
import modelo.Venta;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 *
 * @author oscar
 */
public class Controlador extends HttpServlet {
public static long serialVersionUID = 1L;

    ProductoController productoController = new ProductoController();
    ClienteController clienteController = new ClienteController();
    EmpleadoController empleadoController = new EmpleadoController();
    VentaController ventaController = new VentaController();
    
    int item = 0;
    double total = 0.0;
    
    Cliente cliente; 
    Producto producto;
    String numeroSerie = "";
    Empleado empleado;
    Venta venta;
    
    List<Venta> listaProductos;
    
    EmpleadoDAO eDao;
    VentaDAO vDao;
    ProductoDAO pDao;
    ClienteDAO cDao;
    
    String menu;
    String accion;
    
    HttpSession session;
    DecimalFormat df;
    
    
    public Controlador() {
        this.listaProductos = new ArrayList<>();
        vDao = new VentaDAO();
        cDao = new ClienteDAO();
        pDao = new ProductoDAO();
        eDao = new EmpleadoDAO();
        df = new DecimalFormat("#.00");
    }
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        
            menu = request.getParameter("menu");    
            accion = request.getParameter("accion");
            
            session = request.getSession(false);
            if(session != null){
                if(empleado == null){
                    empleado = (Empleado) session.getAttribute("empleado");
                }
            }else{
                response.sendRedirect("index.jsp");
            }
            
            if(menu.equals("Principal")){
                request.getRequestDispatcher("Principal.jsp").forward(request, response);
            }
            if(menu.equals("producto")){
                handleProducto(request, response);
            }
            if(menu.equals("empleado")){
                handleEmpleado(request, response);
            }
            if(menu.equals("cliente")){
                handleCliente(request, response);
            }
            if(menu.equals("nuevaVenta")){
                handleNuevaVenta(request, response);
            }
            if(menu.equals("panelVentas")){
                handlePanelVentas(request, response);
            }
    }
    
    public void handlePanelVentas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException{
        if(accion != null){
            switch (accion) {
                case "Listar" -> ventaController.ListarVentas(request, response);
                case "IngresosPorMes" -> ventaController.IngresosPorMes(request, response);
                case "VentasPorProducto" -> ventaController.VentasPorProducto(request, response);
            }
        }
    }
    
    public void handleNuevaVenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException{
         if(accion != null) {
                    switch(accion){
                    case "Buscar Cliente" -> {
                        String Dni = request.getParameter("codigoCliente");
                        ClienteDAO cDao = new ClienteDAO();
                        setCliente(cDao.buscarPorDni(Dni));
                        
                        request.getRequestDispatcher("Controlador?menu=nuevaVenta");
                    }
                    case "Buscar Producto" -> {
                        int id = Integer.parseInt(request.getParameter("codigoProducto"));
                        pDao = new ProductoDAO();
                        setProducto(pDao.leer(id));
                        request.getRequestDispatcher("Controlador?menu=nuevaVenta");
                    }
                    case "Agregar" -> {
                        venta = new Venta();
                        
                        setItem(getItem() + 1);
                        int codigo = Integer.parseInt(request.getParameter("codigoProducto"));
                        String descripcion = request.getParameter("nombreProducto");
                        double precio = Double.parseDouble(request.getParameter("precio"));
                        int cantidad = Integer.parseInt(request.getParameter("cantidad"));
                        double subtotal = precio * cantidad;
                        venta.setItem(getItem());
                        venta.setIdProducto(codigo);
                        venta.setDescripcion(descripcion);
                        venta.setPrecio(precio);
                        venta.setCantidad(cantidad);
                        venta.setSubtotal(subtotal);
                        getListaProductos().add(venta);
                        total = 0;
                        for (Venta listaProducto : getListaProductos()) {
                            total += listaProducto.getPrecio() * listaProducto.getCantidad();
                        }
                        request.getRequestDispatcher("Controlador?menu=nuevaVenta");
                    }
                    case "EliminarProducto" -> {
                        int itemId = Integer.parseInt(request.getParameter("item"));

                        // Ordena la lista de productos por el atributo item si no está ya ordenada.
                        listaProductos.sort(Comparator.comparingInt(Venta::getItem));

                        // Búsqueda binaria para encontrar el índice del producto.
                        int index = Collections.binarySearch(listaProductos, new Venta(itemId), Comparator.comparingInt(Venta::getItem));

                        // Si el índice es válido (elemento encontrado), eliminarlo.
                        if (index >= 0) {
                            Venta productoAEliminar = listaProductos.get(index);
                             total -= productoAEliminar.getSubtotal();
                            listaProductos.remove(index);
                        }

                    }
                    case "Generar Venta" -> {
                        if(cliente != null && !listaProductos.isEmpty()){
                                    for(Venta listaProducto: listaProductos){
                                    // stock
                                    int cantidad = listaProducto.getCantidad();
                                    int idProducto = listaProducto.getIdProducto();
                                    producto = pDao.leer(idProducto);
                                    int stockActual = producto.getStock() - cantidad;
                                    pDao.ActualizarStock(idProducto, stockActual);
                                }

                                venta.setIdCliente(cliente.getIdCliente());
                                venta.setIdEmpleado(empleado.getId());
                                venta.setNumSerie(numeroSerie);
                                venta.setFecha("" + LocalDate.now());
                                venta.setMonto(total);
                                venta.setEstado("1");
                                vDao.insertar(venta);

                                int idVenta = vDao.idVenta();
                                for (Venta listaProducto : listaProductos) {                         
                                    //detalle ventas
                                    venta = new Venta();
                                    venta.setId(idVenta);
                                    venta.setIdProducto(listaProducto.getIdProducto());
                                    venta.setCantidad(listaProducto.getCantidad());
                                    venta.setPrecio(listaProducto.getPrecio());
                                    vDao.insertarDetalleVentas(venta);
                                }

                                listaProductos = new ArrayList<>();
                                total = 0.0;
                            }else {
                            request.getRequestDispatcher("Controlador?menu=nuevaVenta");
                        }
                        
                    }
                    
                    case "CancelarVenta" -> {
                        if(!listaProductos.isEmpty()){
                            listaProductos = new ArrayList<>();
                            total = 0;
                        }
                        request.getRequestDispatcher("Controlador?menu=nuevaVenta");
                    }
                        
                    }
                }
                
                numeroSerie = vDao.generarSerie();
                if("".equals(numeroSerie) || numeroSerie == null){
                    numeroSerie = "00000001";
                } else {
                    int incrementar = Integer.parseInt(numeroSerie);
                    GenerarSerie gs = new GenerarSerie();
                    numeroSerie = gs.NumeroSerie(incrementar);
                }
                request.setAttribute("nSerie", numeroSerie);
                request.setAttribute("producto", getProducto());
                request.setAttribute("cliente", getCliente());
                request.setAttribute("total", getTotal());
                request.setAttribute("lista", getListaProductos());
                request.getRequestDispatcher("RegistrarVenta.jsp").forward(request, response);
    }
    
    public void handleEmpleado(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException{
        EmpleadoDAO edao = new EmpleadoDAO();
                int id;
                String dni, nombre, correo, usuario, estado, telefono;
                Empleado emp;
                switch(accion){
                    case "Listar" -> empleadoController.ListarEmpleado(request, response);
                    case "Editar" -> {
                        emp = edao.leer(Integer.parseInt(request.getParameter("idEmpleado")));
                        request.setAttribute("empleado", emp);
                        request.getRequestDispatcher("Controlador?menu=empleado&accion=Listar").forward(request, response);
                        break;
                    }
                    case "Actualizar" -> {
                        id = Integer.parseInt(request.getParameter("txtId"));
                        dni = request.getParameter("txtDni");
                        nombre = request.getParameter("txtNombre");
                        correo = request.getParameter("txtCorreo");
                        telefono = request.getParameter("txtTelefono");
                        estado = request.getParameter("txtEstado");
                        usuario = request.getParameter("txtUsuario");
                        edao.editar( new Empleado(id, dni, nombre, correo, telefono, estado, usuario));
                        request.getRequestDispatcher("Controlador?menu=empleado&accion=Listar").forward(request, response);
                        break;
                    }
                    case "Agregar" -> {
                        dni = request.getParameter("txtDni");
                        nombre = request.getParameter("txtNombre");
                        correo = request.getParameter("txtCorreo");
                        telefono = request.getParameter("txtTelefono");
                        estado = request.getParameter("txtEstado");
                        usuario = request.getParameter("txtUsuario");
                        edao.insertar(new Empleado(dni, nombre, correo, telefono, estado, usuario));
                        request.getRequestDispatcher("Controlador?menu=empleado&accion=Listar").forward(request, response);
                        break;
                    }
                    case "Eliminar" -> {
                        id = Integer.parseInt(request.getParameter("idEmpleado"));
                        edao.eliminar(id);
                        request.getRequestDispatcher("Controlador?menu=empleado&accion=Listar").forward(request, response);
                        break;
                    }
                }
    }
    
    public void handleCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException{
        if(accion != null){
            switch(accion){
                case "Listar" -> clienteController.listarProductos(request, response);
                case "Agregar" -> clienteController.agregarCliente(request, response);
                case "Eliminar" -> clienteController.eliminarCliente(request, response);
                case "Actualizar" -> clienteController.actualizarCliente(request, response);
                case "Filtrar" -> clienteController.filtrarCliente(request, response);
            }    
        }
    }
    
    public void handleProducto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException{
        if (accion != null) {
            switch (accion) {
                case "Listar" -> productoController.listarProductos(request, response);
                case "Insertar" -> productoController.insertarProducto(request, response);
                case "Actualizar" -> productoController.actualizarProducto(request, response);
                case "Eliminar" -> productoController.eliminarProducto(request, response);
                case "Filtrar" -> productoController.filtrarProductos(request, response);
                case "CambiarEstado" -> productoController.cambiarEstadoProducto(request, response);
            }
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    try {
        processRequest(request, response);
    } catch(SQLIntegrityConstraintViolationException ex1){
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResp = new JSONObject();
        jsonResp.put("success", false);
        jsonResp.put("ErrorMessage", "El elemento que está tratando de eliminar está vinculado al historial de ventas, no es posible eliminarlo");
        PrintWriter out = response.getWriter();
        out.print(jsonResp.toString());
        out.flush();
    } catch (SQLException ex) {
        Logger.getLogger(Controlador.class.getName()).log(Level.SEVERE, null, ex);
    }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    try {
        processRequest(request, response);
    } catch(SQLIntegrityConstraintViolationException ex1){
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject jsonResp = new JSONObject();
        jsonResp.put("success", false);
        jsonResp.put("ErrorMessage", "El elemento que está tratando de eliminar está vinculado al historial de ventas, no es posible eliminarlo");
        PrintWriter out = response.getWriter();
        out.print(jsonResp.toString());
        out.flush();
    }catch (SQLException ex) {
        Logger.getLogger(Controlador.class.getName()).log(Level.SEVERE, null, ex);
    }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public static long getSerialVersionUID() { return serialVersionUID;    }
    public static void setSerialVersionUID(long aSerialVersionUID) { serialVersionUID = aSerialVersionUID; }
    public int getItem() { return item; }
    public void setItem(int item) { this.item = item; }
    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }
    public Cliente getCliente() { return cliente; }
    public void setCliente(Cliente cliente) { this.cliente = cliente; }
    public Producto getProducto() { return producto;  }
    public void setProducto(Producto producto) { this.producto = producto; }
    public List<Venta> getListaProductos() { return listaProductos;}
    public void setListaProductos(List<Venta> listaProductos) { this.listaProductos = listaProductos; }
    public String getNumeroSerie() { return numeroSerie; }
    public void setNumeroSerie(String numeroSerie) { this.numeroSerie = numeroSerie; }
}