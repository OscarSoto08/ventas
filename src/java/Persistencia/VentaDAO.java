package Persistencia;

import java.sql.*;
import java.util.List;
import modelo.Venta;
import java.util.logging.Level;
import java.util.logging.Logger;

public class VentaDAO extends DAO<Venta>{
    public String generarSerie(){
        String serie = "";
        try{
            st = getCnn().prepareStatement("SELECT MAX(NumeroSerie) as NumeroSerie FROM ventas ");
            rs = st.executeQuery();   
            if(rs.next()){
                serie = rs.getString("NumeroSerie");
            }
        }catch (SQLException ex) {
        errorMessage = String.format(
            "Error al leer numero de serie", ex.getMessage()
        );
        Logger.getLogger(VentaDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
    } finally {
        instance.cerrarConexion();
    }
        return serie;
    }
    
    public int totalVentas(){
        int total = 0;
        sql = "select sum(Cantidad * PrecioVenta) as total from detalle_ventas;";
        try{
            st = getCnn().prepareStatement(sql);
            rs = st.executeQuery();
            if(rs.next()){
                total = rs.getInt("total");
            }
        }catch(SQLException ex){
            errorMessage = String.format(
                    "No se pudo leer la cantidad total de productos ACTIVOS, mensaje '%s': ", ex.getMessage()
            );
            Logger.getLogger(VentaDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        }
        finally{
            instance.cerrarConexion();
        }
        
        return total;
    }

    public int idVenta(){
        sql  = "SELECT MAX(idVentas) as id FROM ventas";
        int id = 0; // 0 significa que no hay
        try{
            st = getCnn().prepareStatement(sql);
            rs = st.executeQuery();
            if(rs.next()){
                id = rs.getInt("id");
            }
        }catch(SQLException ex){
            errorMessage = String.format("Error al leer el id maximo de ventas, mensaje: '%s' ", ex.getMessage());
            Logger.getLogger(VentaDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        }finally{
            instance.cerrarConexion();
        }
        
        return id;
    }
    
    public boolean insertarDetalleVentas(Venta v){
        sql = "INSERT INTO `detalle_ventas`( `IdVentas`, `IdProducto`, `Cantidad`, `PrecioVenta`) VALUES (?,?,?,?)";
        boolean res = true;
        try{
            st = getCnn().prepareStatement(sql);
            st.setInt(1, v.getId());
            st.setInt(2, v.getIdProducto());
            st.setInt(3, v.getCantidad());
            st.setDouble(4, v.getPrecio());
            res = st.execute();
        }catch(SQLException ex){
            errorMessage = String.format("No se pudieron insertar los detalles de ventas a la base de datos con id venta: '%s', idProducto: '%s', cantidad: '%s', Precioventa:'%s', mensaje: '%s' ",v.getId(), v.getIdProducto(), v.getCantidad(), v.getPrecio(), ex.getMessage());
            Logger.getLogger(VentaDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        }finally{
            instance.cerrarConexion();
        }
        
        return res;
    }

    @Override
    public boolean insertar(Venta nuevo) {
        sql = "INSERT INTO `ventas`(`IdCliente`, `IdEmpleado`, `NumeroSerie`, `FechaVentas`, `Monto`, `Estado`) VALUES (?,?,?,?,?,?)";
        boolean resultado = true;
        try{
            st = getCnn().prepareStatement(sql);
            st.setInt(1, nuevo.getIdCliente());
            st.setInt(2, nuevo.getIdEmpleado());
            st.setString(3, nuevo.getNumSerie());
            st.setString(4, nuevo.getFecha());
            st.setDouble(5, nuevo.getMonto());
            st.setString(6, nuevo.getEstado());
            
            System.out.println("idEmpleado: " + nuevo.getIdEmpleado());
            resultado  = st.execute();
        }catch(SQLException ex){
            errorMessage = String.format("Error al insertar una venta con los valores idCliente: '%s', idEmpleado: '%s', NumeroSerie: '%s', Fecha: '%s', Monto: '%s', Estado: '%s', Mensaje: '%s' ", nuevo.getIdCliente(), nuevo.getIdEmpleado(), nuevo.getNumSerie(), nuevo.getFecha(), nuevo.getMonto(), nuevo.getEstado(), ex.getMessage());
            
            Logger.getLogger(VentaDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        }finally{
            instance.cerrarConexion();
        }
        return resultado;
    }

    @Override
    public boolean eliminar(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Venta> leerTodos() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Venta leer(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public boolean editar(Venta editado) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
