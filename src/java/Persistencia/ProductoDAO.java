package Persistencia;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.Producto;

public class ProductoDAO extends DAO<Producto>{

    public void cambiarEstado(String estadoNuevo, int id){
        sql = "UPDATE producto SET Estado=? WHERE idProducto = ?";
        try{
            st = getCnn().prepareStatement(sql);
            st.setString(1, estadoNuevo);
            st.setInt(2, id);
            st.execute();
        }catch(SQLException ex){
            errorMessage = String.format("Error al cambiar el estado del producto id: '%s', mensaje: '%s'", id, ex.getMessage());
            System.err.println(errorMessage);
        } finally {
            instance.cerrarConexion();
        }
    }
    
    public boolean ActualizarStock(int id, int nuevoStock){
        boolean res = true;
        sql = "UPDATE producto SET Stock=? WHERE idProducto = ?";
        
        try{
            st = getCnn().prepareStatement(sql);
            st.setInt(1, nuevoStock);
            st.setInt(2, id);
            res = st.execute();
        }catch(SQLException ex){
            errorMessage = String.format("Error al actualizar el stock del producto con id: '%s', mensaje: '%s' ", id, ex.getMessage());
            Logger.getLogger(ProductoDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        }finally{
            instance.cerrarConexion();
        }
        
        return res;
    }
    
    public int totalProductos(){
        int total = 0;
        sql = "SELECT COUNT(idProducto) AS total FROM producto";
        try{
            st = getCnn().prepareStatement(sql);
            rs = st.executeQuery();
            if(rs.next()){
                total = rs.getInt("total");
            }
        }catch(SQLException ex){
            errorMessage = String.format(
                    "No se pudo leer la cantidad total de productos, mensaje '%s': ", ex.getMessage()
            );
            Logger.getLogger(ProductoDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        }
        finally{
            instance.cerrarConexion();
        }
        
        return total;
    }
    
    
    public int activos(){
        int total = 0;
        sql = "SELECT COUNT(idProducto) AS total FROM producto WHERE Estado = 1";
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
            Logger.getLogger(ProductoDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        }
        finally{
            instance.cerrarConexion();
        }
        
        return total;
    }
    
   public List<Producto> filtrar(String filtro) {
    List<Producto> productos = new ArrayList<>();
    String sql = "SELECT IdProducto, Nombres, Precio, Stock, Estado FROM producto WHERE Nombres LIKE ? OR Precio LIKE ?";
    
    try (PreparedStatement st = getCnn().prepareStatement(sql)) {
        String filtroLike = "%" + filtro + "%";
        st.setString(1, filtroLike);
        st.setString(2, filtroLike);
        
        try (ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Producto p = new Producto(
                    rs.getInt("IdProducto"), 
                    rs.getString("Nombres"), 
                    rs.getDouble("Precio"), 
                    rs.getInt("Stock"),  // Corregido: era "Cantidad" en el código original
                    rs.getString("Estado")
                );
                productos.add(p);
            }
        }
    } catch (SQLException ex) {
        String errorMessage = String.format("No se pudo realizar la consulta de productos por filtro, búsqueda: '%s', mensaje: '%s'", filtro, ex.getMessage());
        System.err.println(errorMessage);
        ex.printStackTrace();
    } finally {
        instance.cerrarConexion();
    }
    
    return productos;
}

// CRUD
    
    @Override
    public boolean insertar(Producto nuevo) {
        sql = "INSERT INTO `producto`(`Nombres`, `Precio`, `Stock`, `Estado`) VALUES (?,?,?,?)";
        boolean resultado = true;
        try{
            st = getCnn().prepareStatement(sql);
            st.setString(1, nuevo.getNombres());
            st.setDouble(2, nuevo.getPrecio());
            st.setInt(3, nuevo.getStock());
            st.setString(4, nuevo.getEstado());
            resultado = st.execute();
        } catch(SQLException ex){
            errorMessage = String.format("Error al insertar un nuevo producto, valores: nombre: '%s', precio: '%s', stock: '%s', estado: '%s', mensaje: '%s'", nuevo.getNombres(), nuevo.getPrecio(), nuevo.getStock(), nuevo.getEstado(), ex.getMessage());
            System.err.println(errorMessage);
        } finally{
            instance.cerrarConexion();
        }
        return resultado;
    }

    @Override
    public boolean eliminar(int id) {
        sql = "DELETE FROM producto WHERE IdProducto = ?";
        boolean resultado = true;
        try{
            st = getCnn().prepareStatement(sql);
            st.setInt(1, id);
            resultado = st.execute();
        } catch (SQLException ex){
            errorMessage = String.format("No se pudo eliminar al producto con id: '%s', mensaje: '%s'", id, ex.getMessage());
            System.err.println(errorMessage);
            return false;
        } finally {
            instance.cerrarConexion();
        }
        return resultado;
    }

    @Override
    public List<Producto> leerTodos() {
         List<Producto> productos = new ArrayList<>();
        try{
            st = getCnn().prepareStatement("SELECT IdProducto, Nombres, Precio, Stock, Estado FROM producto");
            rs = st.executeQuery();
            while(rs.next()){
                int idProducto = rs.getInt("IdProducto");
                String Nombres = rs.getString("Nombres");
                double Precio = rs.getDouble("Precio");
                int Stock = rs.getInt("Stock");
                String Estado = rs.getString("Estado");
                Producto producto = new Producto(idProducto, Nombres, Precio, Stock, Estado);
                productos.add(producto);
            }
        } catch (SQLException ex) {
        errorMessage = String.format(
            "Error al leer productos, mensaje: '%s' ", ex.getMessage()
        );
        Logger.getLogger(ProductoDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
    } finally {
        instance.cerrarConexion();
    }
        return productos;
    }

    @Override
    public Producto leer(int id) {
        Producto producto = null;
        try{
            st = getCnn().prepareStatement("SELECT Nombres, Precio, Stock, Estado FROM producto WHERE idProducto = ?");
            st.setInt(1, id);
            rs = st.executeQuery();
            if(rs.next()){
                String Nombres = rs.getString("Nombres");
                double Precio = rs.getDouble("Precio");
                int Stock = rs.getInt("Stock");
                String Estado = rs.getString("Estado");
                producto = new Producto(id, Nombres, Precio, Stock, Estado);
            }
        } catch (SQLException ex) {
        errorMessage = String.format(
            "Error al leer el empleado con id '%s'  Detalle: %s",
            id, ex.getMessage()
        );
        Logger.getLogger(ProductoDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
    } finally {
        instance.cerrarConexion();
    }
        return producto;
    }

    @Override
    public boolean editar(Producto editado) {
        sql = "UPDATE `producto` SET `Nombres`=?,`Precio`=?,`Stock`=?,`Estado`=? WHERE IdProducto = ?";
        boolean resultado = false;
        try{
            st = getCnn().prepareStatement(sql);
            st.setString(1, editado.getNombres());
            st.setDouble(2, editado.getPrecio());
            st.setInt(3, editado.getStock());
            st.setString(4, editado.getEstado());
            st.setInt(5, editado.getIdProducto());
            resultado = st.execute();
        } catch(SQLException ex) {
            errorMessage = String.format("Error al editar el producto con id: '%s' \n Valores -> nombre: '%s', precio: '%s', stock: '%s', estado: '%s' \n Mensaje: '%s'",editado.getIdProducto(), editado.getNombres(), editado.getPrecio(), editado.getStock(), editado.getEstado(), ex.getMessage());
        } finally {
            instance.cerrarConexion();
        }
        
        return resultado;
    }
}
