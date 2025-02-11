package Persistencia;


import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import modelo.Producto;

public class ProductoDAO extends DAO<Producto>{

    public void cambiarEstado(String estadoNuevo, int id) throws SQLException{
        sql = "UPDATE producto SET Estado=? WHERE idProducto = ?";
        st = getCnn().prepareStatement(sql);
        st.setString(1, estadoNuevo);
        st.setInt(2, id);
        st.execute();
    }
    
    public boolean ActualizarStock(int id, int nuevoStock)throws SQLException{
        sql = "UPDATE producto SET Stock=? WHERE idProducto = ?";
        st = getCnn().prepareStatement(sql);
        st.setInt(1, nuevoStock);
        st.setInt(2, id);
        return st.executeUpdate() > 0;
    }
    
    public int totalProductos() throws SQLException{
        sql = "SELECT COUNT(idProducto) AS total FROM producto";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()) return rs.getInt("total");
        return 0;
    }
    
    public int productosVendidos() throws SQLException{
        sql = "SELECT SUM(Cantidad) AS TotalProductosVendidos FROM detalle_ventas;";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()) return rs.getInt("TotalProductosVendidos");
        return 0;
    }
    
    
    public Map<String, Object> productoMasRentable() throws SQLException{
        sql = "SELECT p.Nombres AS ProductName, SUM(dv.Cantidad * dv.PrecioVenta) AS TotalRevenue FROM producto p JOIN detalle_ventas dv ON p.IdProducto = dv.IdProducto GROUP BY p.Nombres ORDER BY TotalRevenue DESC LIMIT 1;";
        st = getCnn().prepareStatement(sql);
        Map<String, Object> resultado = new HashMap<>();
        rs = st.executeQuery();
        while(rs.next()){
            resultado.put("NombreProducto", rs.getString("ProductName"));
            resultado.put("Total", rs.getString("TotalRevenue"));
        }
        
        return resultado;
    }
    
    
    public int activos() throws SQLException {
        sql = "SELECT COUNT(idProducto) AS total FROM producto WHERE Estado = 1";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()) return rs.getInt("total");
        return 0;
    }
    
   public List<Producto> filtrar(String filtro) throws SQLException {
        List<Producto> productos = new ArrayList<>();
        String sql = "SELECT IdProducto, Nombres, Precio, Stock, Estado FROM producto WHERE Nombres LIKE ? OR Precio LIKE ?";
        String filtroLike = "%" + filtro + "%";
        st.setString(1, filtroLike);
        st.setString(2, filtroLike);

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
        return productos;
    }

   
   
   
// CRUD
    
    @Override
    public boolean insertar(Producto nuevo) throws SQLException {
        sql = "INSERT INTO `producto`(`Nombres`, `Precio`, `Stock`, `Estado`) VALUES (?,?,?,?)";
        boolean resultado = true;
        st = getCnn().prepareStatement(sql);
        st.setString(1, nuevo.getNombres());
        st.setDouble(2, nuevo.getPrecio());
        st.setInt(3, nuevo.getStock());
        st.setString(4, nuevo.getEstado());
        return st.executeUpdate() > 0;
    }

    @Override
    public boolean eliminar(int id) throws SQLException{
        sql = "DELETE FROM producto WHERE IdProducto = ?";
        boolean resultado = true;
        st = getCnn().prepareStatement(sql);
        st.setInt(1, id);
        return st.executeUpdate() > 0;
    }

    @Override
    public List<Producto> leerTodos() throws SQLException{
         List<Producto> productos = new ArrayList<>();
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
        return productos;
    }

    @Override
    public Producto leer(int id) throws SQLException{
        Producto producto = null;
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
        return producto;
    }

    @Override
    public boolean editar(Producto editado) throws SQLException{
        sql = "UPDATE `producto` SET `Nombres`=?,`Precio`=?,`Stock`=?,`Estado`=? WHERE IdProducto = ?";
        boolean resultado = false;
        st = getCnn().prepareStatement(sql);
         st.setString(1, editado.getNombres());
         st.setDouble(2, editado.getPrecio());
         st.setInt(3, editado.getStock());
         st.setString(4, editado.getEstado());
         st.setInt(5, editado.getIdProducto());
        return st.executeUpdate() > 0;
    }
}
