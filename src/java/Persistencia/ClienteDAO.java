package Persistencia;

import java.util.List;
import modelo.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ClienteDAO extends DAO<Cliente>{

    public Cliente buscarPorDni(String Dni){
        Cliente cliente = null;
        sql = "SELECT idCliente, Nombres, Direccion, Estado FROM  cliente WHERE Dni = ?";
        try{
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
        } catch (SQLException ex) {
        errorMessage = String.format(
            "Error al encontrar al cliente con el dni: " , Dni,  ex.getMessage()
        );
        Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
    } finally {
        instance.cerrarConexion();
    }
        return cliente;
    }

    public int clientesActivos(){
        sql = "SELECT COUNT(idCliente) as activos FROM cliente WHERE Estado = 1";
        int activos = 0;
        try{
            st = getCnn().prepareStatement(sql);
            rs = st.executeQuery();
            if(rs.next()){
                activos = rs.getInt("activos");
            }
        } catch (SQLException ex) {
        errorMessage = String.format(
            "Error no se pudieron contar los clientes activos, mensaje: '%s' ", ex.getMessage()
            );
        Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        } finally {
            instance.cerrarConexion();
        }
        return activos;
    }
    
    public int totalClientes(){
        sql = "SELECT COUNT(idCliente) as total FROM cliente";
        int total = 0;
        try{
            st = getCnn().prepareStatement(sql);
            rs = st.executeQuery();
            if(rs.next()){
                total = rs.getInt("total");
            }
        } catch (SQLException ex) {
        errorMessage = String.format(
            "Error no se pudieron contar el total de clientes, mensaje: '%s' ", ex.getMessage()
            );
        Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        } finally {
            instance.cerrarConexion();
        }
        return total;
    }
    
    @Override
    public List<Cliente> leerTodos() {
        List<Cliente> clientes = new ArrayList<>();
        sql = "SELECT idCliente, Dni, Nombres, Direccion, Estado FROM cliente ORDER BY Dni ASC";
        try{
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
        }catch(SQLException ex){
            errorMessage = String.format("No se pudo consultar a los clientes, mensaje: '%s' ", ex.getMessage());
            Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        }
        return clientes;
    }
    
    @Override
    public boolean editar(Cliente editado) {
        sql = "UPDATE cliente SET Nombres = ?, Direccion = ?, Estado = ? WHERE idCliente = ?";
        try {
            st = getCnn().prepareStatement(sql);
            st.setString(1, editado.getNombres());
            st.setString(2, editado.getDireccion());
            st.setString(3, editado.getEstado());
            st.setInt(4, editado.getIdCliente());

            int filasActualizadas = st.executeUpdate();
            return filasActualizadas > 0; // Devuelve true si se actualizó al menos una fila
        } catch (SQLException ex) {
            errorMessage = String.format(
                    "Error al editar el cliente con ID: %d, mensaje: '%s'", editado.getIdCliente(), ex.getMessage()
            );
            Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
            return false; // Devuelve false si hubo un error
        } finally {
            instance.cerrarConexion();
        }
    }


    @Override
    public boolean eliminar(int id) {
        sql = "DELETE FROM cliente WHERE idCliente = ?";
        try {
            st = getCnn().prepareStatement(sql);
            st.setInt(1, id);
            int filasEliminadas = st.executeUpdate();
            return filasEliminadas > 0; // Devuelve true si se eliminó al menos una fila
        } catch (SQLException ex) {
            errorMessage = String.format(
                    "Error al eliminar el cliente con ID: %d, mensaje: '%s'", id, ex.getMessage()
            );
            Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
            return false; // Devuelve false si hubo un error
        } finally {
            instance.cerrarConexion();
        }
    }


    @Override
    public Cliente leer(int id) {
        Cliente cliente = null;
        sql = "SELECT idCliente, Dni, Nombres, Direccion, Estado FROM cliente WHERE idCliente = ?";
        try {
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
        } catch (SQLException ex) {
            errorMessage = String.format(
                    "Error al leer el cliente con ID: %d, mensaje: '%s'", id, ex.getMessage()
            );
            Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
        } finally {
            instance.cerrarConexion();
        }
        return cliente;
    }


    @Override
    public boolean insertar(Cliente nuevo) {
        sql = "INSERT INTO cliente (Dni, Nombres, Direccion, Estado) VALUES (?, ?, ?, ?)";
        try {
            st = getCnn().prepareStatement(sql);
            st.setString(1, nuevo.getDni());
            st.setString(2, nuevo.getNombres());
            st.setString(3, nuevo.getDireccion());
            st.setString(4, nuevo.getEstado()); // Asegúrate de que el estado se maneje correctamente (ej: "1" para activo, "0" para inactivo)
            int filasInsertadas = st.executeUpdate();
            return filasInsertadas > 0;
        } catch (SQLException ex) {
            errorMessage = String.format(
                    "Error al insertar el nuevo cliente, mensaje: '%s'", ex.getMessage()
            );
            Logger.getLogger(ClienteDAO.class.getName()).log(Level.SEVERE, errorMessage, ex);
            return false;
        } finally {
            instance.cerrarConexion();
        }
    }
    
}
