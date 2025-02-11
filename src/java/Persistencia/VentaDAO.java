package Persistencia;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import modelo.Venta;



public class VentaDAO extends DAO<Venta>{
    
    public String[] IngresosActuales() throws SQLException{
        String[] datos = {"", ""};
        sql = "WITH VentasMes AS ( SELECT DATE_FORMAT(FechaVentas, '%Y-%m') AS Mes, SUM(Monto) AS Ingresos FROM Ventas WHERE Estado = '1' GROUP BY Mes ) SELECT   v1.Mes ,v1.Ingresos AS IngresosActual FROM VentasMes v1 LEFT JOIN VentasMes v2 ON DATE_SUB(v1.Mes, INTERVAL 1 MONTH) = v2.Mes WHERE v1.Mes = DATE_FORMAT(NOW(), '%Y-%m');";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()){
            datos[0] = rs.getString("Mes");
            datos[1] = rs.getString("IngresosActual");
        }
        return datos;
    }
    
    
    public int totalVentas() throws SQLException{
        sql = "SELECT COUNT(*) AS TotalVentas FROM ventas;";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()) return rs.getInt("TotalVentas");
        return 0;
    }
    
    public int ClientesFrecuentes() throws SQLException{
        // La cantidad de clientes que han realizado al menos 2 compras en el ultimo mes
        sql = "select count(c.idCliente) as totalClientes from cliente c where c.IdCliente in (SELECT c1.IdCliente FROM cliente c1 JOIN ventas v ON c1.IdCliente = v.IdCliente WHERE v.FechaVentas BETWEEN DATE_ADD(CURDATE(), INTERVAL -1 MONTH) AND CURDATE() GROUP BY c1.IdCliente HAVING COUNT(v.IdVentas) >= 2 );";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()) return rs.getInt("totalClientes");
        return 0;
    }
    
    public List<Map<String, Object>> obtenerIngresosPorMes() throws SQLException {
        sql = "SELECT DATE_FORMAT(FechaVentas, '%Y-%m') AS Mes, SUM(Monto) AS IngresosTotales FROM Ventas WHERE Estado = '1' GROUP BY Mes ORDER BY Mes;";
        List<Map<String, Object>> resultados = new ArrayList<>();
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        while(rs.next()){
             Map<String, Object> ingreso = new HashMap<>();
            ingreso.put("Mes", rs.getString("Mes"));
            ingreso.put("IngresosTotales", rs.getDouble("IngresosTotales"));

            resultados.add(ingreso);
        }
        return resultados;
    }
    
    public List<Map<String, Object>> VentasPorProducto() throws SQLException {
        sql = "SELECT p.Nombres AS ProductName, COUNT(dv.IdProducto) AS TotalSales FROM producto p JOIN detalle_ventas dv ON p.IdProducto = dv.IdProducto GROUP BY p.Nombres ORDER BY TotalSales DESC;";
        List<Map<String, Object>> resultados = new ArrayList<>();
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        while(rs.next()){
             Map<String, Object> ingreso = new HashMap<>();
            ingreso.put("Mes", rs.getString("ProductName"));
            ingreso.put("IngresosTotales", rs.getInt("TotalSales"));

            resultados.add(ingreso);
        }
        return resultados;
    }
    
    
    public String generarSerie() throws SQLException{
        st = getCnn().prepareStatement("SELECT MAX(NumeroSerie) as NumeroSerie FROM ventas ");
        rs = st.executeQuery();   
        if(rs.next()) return rs.getString("NumeroSerie");
        return "";
    }
    

    
    public int idVenta() throws SQLException{
        sql  = "SELECT MAX(idVentas) as id FROM ventas";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()) return rs.getInt("id"); 
        return 0;
    }
    
    public int numeroVentas() throws SQLException{
        sql  = "SELECT COUNT(idVentas) as id FROM ventas";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()) return rs.getInt("id"); 
        return 0;
    }
    
    public boolean insertarDetalleVentas(Venta v) throws SQLException{
        sql = "INSERT INTO `detalle_ventas`( `IdVentas`, `IdProducto`, `Cantidad`, `PrecioVenta`) VALUES (?,?,?,?)";
        boolean res = true;
        st = getCnn().prepareStatement(sql);
        st.setInt(1, v.getId());
        st.setInt(2, v.getIdProducto());
        st.setInt(3, v.getCantidad());
        st.setDouble(4, v.getPrecio());
        return st.executeUpdate() > 0;
    }

    @Override
    public boolean insertar(Venta nuevo) throws SQLException {
        sql = "INSERT INTO `ventas`(`IdCliente`, `IdEmpleado`, `NumeroSerie`, `FechaVentas`, `Monto`, `Estado`) VALUES (?,?,?,?,?,?)";
        boolean resultado = true;
        st = getCnn().prepareStatement(sql);
        st.setInt(1, nuevo.getIdCliente());
        st.setInt(2, nuevo.getIdEmpleado());
        st.setString(3, nuevo.getNumSerie());
        st.setString(4, nuevo.getFecha());
        st.setDouble(5, nuevo.getMonto());
        st.setString(6, nuevo.getEstado());

        System.out.println("idEmpleado: " + nuevo.getIdEmpleado());

        return st.executeUpdate() > 0;
    }

    @Override
    public boolean eliminar(int id) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Venta> leerTodos() throws SQLException{
        List<Venta> ventas = new ArrayList<>();
        sql = "select v.IdVentas as idVentas, c.Nombres as nombreCliente, e.Nombres as nombreEmpleado, DATE_FORMAT(v.FechaVentas, '%Y-%m') as fecha, v.Monto as monto, v.Estado as estado from cliente c join ventas v on c.IdCliente = v.IdCliente join empleado e on v.IdEmpleado = e.IdEmpleado ORDER BY v.IdVentas ASC;";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        while(rs.next()){
            Venta v = new Venta();
            v.setId(rs.getInt("idVentas"));
            v.getCliente().setNombres(rs.getString("nombreCliente"));
            v.getEmpleado().setNombre(rs.getString("nombreEmpleado"));
            v.setFecha(rs.getString("fecha"));
            v.setMonto(rs.getDouble("monto"));
            v.setEstado(rs.getString("estado"));
            
            ventas.add(v);
        }
        
        return ventas;
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
