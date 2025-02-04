/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package config;

import java.util.List;

/**
 *
 * @author oscar
 * @param <Objeto>
 */
public interface ContratoDAO <Objeto> {
    public boolean insertar(Objeto nuevo);
    public boolean eliminar(int id);
    public List<Objeto> leerTodos();
    public Objeto leer(int id);
    public boolean editar(Objeto editado);
}
