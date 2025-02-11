    package Persistencia;

import java.util.List;
import modelo.Empleado;
import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class EmpleadoDAO extends DAO <Empleado>{
    
    public Empleado validar(String correo, String clave) throws SQLException{
        Empleado emp = null;
        sql = "SELECT idEmpleado, Dni, Nombres, correo, Telefono, Estado, User FROM empleado WHERE correo = ? AND clave = ?";

        st = getCnn().prepareStatement(sql);
        st.setString(1, correo);
        st.setString(2, clave);
        rs = st.executeQuery(); // Execute returns a boolean, while executeUpdate returns the number of affected rows
        
        if (rs.next()) {
            emp = new Empleado(
                    rs.getInt("idEmpleado"),
                    rs.getString("Dni"),
                    rs.getString("Nombres"),
                    rs.getString("Correo"),
                    rs.getString("Telefono"),
                    rs.getString("Estado"),
                    rs.getString("User")
            );
        }

        return emp;
    }
    
    @Override
    public boolean insertar(Empleado emp) throws SQLException{
        sql = "INSERT INTO `empleado`(`Dni`, `Nombres`, Correo, `Telefono`, `Estado`, `User`) VALUES (?,?,?,?,?,?)";
        st = getCnn().prepareStatement(sql);
        st.setString(1, emp.getDni());
        st.setString(2, emp.getNombre());
        st.setString(3, emp.getCorreo());
        st.setString(4, emp.getTelefono());
        st.setString(5, emp.getEstado());
        st.setString(6, emp.getUsuario());
        return st.executeUpdate() > 0;
    }

    @Override
    public boolean eliminar(int id) throws SQLException{
        sql = "DELETE FROM empleado WHERE idEmpleado = ?";
        st = getCnn().prepareStatement(sql);
        st.setInt(1, id);
        return st.executeUpdate() > 0;
    }

    @Override
    public List<Empleado> leerTodos() throws SQLException{
        List<Empleado> empleados = new ArrayList<>();
        sql = "SELECT idEmpleado, Dni, Nombres, Correo, Telefono, Estado, User FROM empleado";
        st = getCnn().prepareStatement(sql);
        rs = st.executeQuery();
        while(rs.next()){
            Empleado em = new Empleado();
            em.setId(rs.getInt("idEmpleado"));
            em.setDni(rs.getString("Dni"));
            em.setNombre(rs.getString("Nombres"));
            em.setCorreo(rs.getString("Correo"));
            em.setTelefono(rs.getString("Telefono"));
            em.setEstado(rs.getString("Estado"));
            em.setUsuario(rs.getString("User"));
            empleados.add(em);
        }
        return empleados;
    }

    @Override
    public Empleado leer(int id) throws SQLException{
        Empleado emp = null;
        sql = "SELECT Dni, Nombres, Correo, Telefono, Estado, User FROM empleado WHERE idEmpleado = ?";
        st = getCnn().prepareStatement(sql);
        st.setInt(1, id);
        rs = st.executeQuery();
        if(rs.next()){
            emp = new Empleado();
            emp.setId(id);
            emp.setDni(rs.getString("Dni"));
            emp.setNombre(rs.getString("Nombres"));
            emp.setCorreo(rs.getString("Correo"));
            emp.setTelefono(rs.getString("Telefono"));
            emp.setEstado(rs.getString("Estado"));
            emp.setUsuario(rs.getString("User"));
        }
        return emp;
    }

    @Override
    public boolean editar(Empleado emp) throws SQLException{
        sql = "UPDATE `empleado` SET `Dni`=?, `Nombres`=?, Correo = ?, Telefono=?, `Estado`=?, `User`=? WHERE idEmpleado=?;";
        st = getCnn().prepareStatement(sql);
        st.setString(1, emp.getDni());
        st.setString(2, emp.getNombre());
        st.setString(3, emp.getCorreo());
        st.setString(4, emp.getTelefono());
        st.setString(5, emp.getEstado());
        st.setString(6, emp.getUsuario());
        st.setInt(7, emp.getId());
        return st.executeUpdate() > 0;
    }
}
