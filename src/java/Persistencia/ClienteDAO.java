package Persistencia;

import java.util.List;
import modelo.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ClienteDAO extends DAO<Cliente>{

    public Cliente buscarPorDni(String Dni) throws SQLException{
        Cliente cliente = null;
        sql = "SELECT idCliente, Nombres, Direccion, Estado FROM  cliente WHERE Dni = ?";
        st = getCnn().prepareStatement(sql);
        st.setString(1, Dni);
        rs = st.executeQuery();
        if(rs.next()){
            int idCliente = rs.getInt("idCliente");
            String Nombres = rs.getString("Nombres");
            String Direccion = rs.getString("Direccion");
            String Estado = rs.getString("Estado");
            cliente = new Cliente(idCliente, Dni, Nombres, Direccion, Estado);
        }
        return cliente;
    }

    public int clientesActivos() throws SQLException{
        sql = "SELECT COUNT(idCliente) as activos FROM cliente WHERE Estado = 1";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()) return rs.getInt("activos");
        return 0;
    }
    
    public int totalClientes() throws SQLException{
        sql = "SELECT COUNT(idCliente) as total FROM cliente";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        if(rs.next()) return rs.getInt("total");
        return 0;
    }
    
    @Override
    public List<Cliente> leerTodos() throws SQLException{
        List<Cliente> clientes = new ArrayList<>();
        sql = "SELECT idCliente, Dni, Nombres, Direccion, Estado FROM cliente ORDER BY Dni ASC";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        while(rs.next()){
            int idCliente = rs.getInt("idCliente");
            String Dni = rs.getString("Dni");
            String Nombres = rs.getString("Nombres");
            String Direccion = rs.getString("Direccion");
            String Estado = rs.getString("Estado");
            Cliente c = new Cliente();
            c.setIdCliente(idCliente);
            c.setDni(Dni);
            c.setNombres(Nombres);
            c.setDireccion(Direccion);
            c.setEstado(Estado);
            clientes.add(c);
        }
        return clientes;
    }
    
    @Override
    public boolean editar(Cliente editado) throws SQLException{
        sql = "UPDATE cliente SET Nombres = ?, Direccion = ?, Estado = ?, Dni = ? WHERE idCliente = ?";
        
        st = getCnn().prepareStatement(sql);
        st.setString(1, editado.getNombres());
        st.setString(2, editado.getDireccion());
        st.setString(3, editado.getEstado());
        st.setString(4, editado.getDni());
        st.setInt(5, editado.getIdCliente());

        return st.executeUpdate() > 0; // Devuelve true si se actualizó al menos una fila
    }
    
    @Override
    public boolean eliminar(int id) throws SQLException{
        sql = "DELETE FROM cliente WHERE idCliente = ?";
        st = getCnn().prepareStatement(sql);
        st.setInt(1, id);
        return st.executeUpdate() > 0;
    }
    
    @Override
    public Cliente leer(int id) throws SQLException{
        Cliente cliente = null;
        sql = "SELECT idCliente, Dni, Nombres, Direccion, Estado FROM cliente WHERE idCliente = ?";
        st = getCnn().prepareStatement(sql);
        st.setInt(1, id);
        rs = st.executeQuery();
        if (rs.next()) {
            String Dni = rs.getString("Dni");
            String Nombres = rs.getString("Nombres");
            String Direccion = rs.getString("Direccion");
            String Estado = rs.getString("Estado");
            cliente = new Cliente(id, Dni, Nombres, Direccion, Estado);
        }
        return cliente;
    }
    
    @Override
    public boolean insertar(Cliente nuevo) throws SQLException{
        sql = "INSERT INTO cliente (Dni, Nombres, Direccion, Estado) VALUES (?, ?, ?, ?)";
        st = getCnn().prepareStatement(sql);
        st.setString(1, nuevo.getDni());
        st.setString(2, nuevo.getNombres());
        st.setString(3, nuevo.getDireccion());
        st.setString(4, nuevo.getEstado()); // Asegúrate de que el estado se maneje correctamente (ej: "1" para activo, "0" para inactivo)
        return st.executeUpdate() > 0;
    }
    
    public List<Cliente> filtrar(String filtro) throws SQLException {
        List<Cliente> clientes = new ArrayList<>();
        sql = "SELECT idCliente, Dni, Nombres, Direccion, Estado FROM cliente WHERE Nombres LIKE ? ORDER BY Dni ASC;";
        st = getCnn().prepareStatement(sql);
        st.setString(1, "%"+filtro+"%");
        rs = st.executeQuery();
        while(rs.next()){
            int id = rs.getInt("idCliente");
            String Dni = rs.getString("Dni");
            String Nombres = rs.getString("Nombres");
            String Direccion = rs.getString("Direccion");
            String Estado = rs.getString("Estado");
            clientes.add(new Cliente(id, Dni, Nombres, Direccion, Estado));
        }
        return clientes;
    }
}
