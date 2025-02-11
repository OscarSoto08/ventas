/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package config;

import java.util.List;
import java.sql.*;
/**
 *
 * @author oscar
 * @param <Objeto>
 */
public interface ContratoDAO <Objeto> {
    public boolean insertar(Objeto nuevo)throws SQLException ;
    public boolean eliminar(int id) throws SQLException;
    public List<Objeto> leerTodos() throws SQLException;
    public Objeto leer(int id) throws SQLException;
    public boolean editar(Objeto editado) throws SQLException;
}
