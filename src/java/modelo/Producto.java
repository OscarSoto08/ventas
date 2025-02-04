/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author oscar
 */
public class Producto {
    private int idProducto;
    private String Nombres;
    private double Precio;
    private int Stock;
    private String Estado;

    public Producto() {
    }

    public Producto(int idProducto, String Nombres, double Precio, int Stock, String Estado) {
        this.idProducto = idProducto;
        this.Nombres = Nombres;
        this.Precio = Precio;
        this.Stock = Stock;
        this.Estado = Estado;
    }

    public Producto(String Nombres, double Precio, int Stock, String Estado) {
        this.Nombres = Nombres;
        this.Precio = Precio;
        this.Stock = Stock;
        this.Estado = Estado;
    }
    public int getIdProducto() {
        return idProducto;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public String getNombres() {
        return Nombres;
    }

    public void setNombres(String Nombres) {
        this.Nombres = Nombres;
    }

    public double getPrecio() {
        return Precio;
    }

    public void setPrecio(double Precio) {
        this.Precio = Precio;
    }

    public int getStock() {
        return Stock;
    }

    public void setStock(int Stock) {
        this.Stock = Stock;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }
    
    
}
