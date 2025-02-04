/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author oscar
 */
public class Cliente {
    private int idCliente;
    private String Dni;
    private String Nombres;
    private String Direccion;
    private String Estado;

    public Cliente() {
    }

    public Cliente(int idCliente, String Dni, String Nombres, String Direccion, String Estado) {
        this.idCliente = idCliente;
        this.Dni = Dni;
        this.Nombres = Nombres;
        this.Direccion = Direccion;
        this.Estado = Estado;
    }

    public Cliente(String Dni, String Nombres, String Direccion, String Estado) {
        this.Dni = Dni;
        this.Nombres = Nombres;
        this.Direccion = Direccion;
        this.Estado = Estado;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getDni() {
        return Dni;
    }

    public void setDni(String Dni) {
        this.Dni = Dni;
    }

    public String getNombres() {
        return Nombres;
    }

    public void setNombres(String Nombres) {
        this.Nombres = Nombres;
    }

    public String getDireccion() {
        return Direccion;
    }

    public void setDireccion(String Direccion) {
        this.Direccion = Direccion;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }
}
