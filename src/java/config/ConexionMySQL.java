package config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionMySQL {
    private static ConexionMySQL instance;
    private Connection cnn;
    private final String driver = "com.mysql.cj.jdbc.Driver";
    private final String user = "root";
    private final String pss = "";
    private final String nom_bd = "db_ventas";
    private final String url = "jdbc:mysql://localhost:3306/" + nom_bd + "?zeroDateTimeBehavior=CONVERT_TO_NULL&autoReconnect=true";

    // Constructor privado para evitar instanciación directa
    private ConexionMySQL() {
        try {
            Class.forName(driver);
            cnn = DriverManager.getConnection(this.url, this.user, this.pss);
            System.out.println("Conexión exitosa");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: El driver JDBC no se encontró.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Error: No se pudo establecer la conexión con la base de datos.");
            System.err.println("Detalles: " + e.getMessage());
            e.printStackTrace();
        }
    }

    // Método para obtener la instancia Singleton (thread-safe)
    public static synchronized ConexionMySQL getInstance() {
        if (instance == null) {
            instance = new ConexionMySQL();
        }
        return instance;
    }

    // Método para obtener la conexión y reabrirla si está cerrada
    public Connection getCnn() {
        try {
            if (cnn == null || cnn.isClosed()) {
                cnn = DriverManager.getConnection(this.url, this.user, this.pss);
                System.out.println("Conexión exitosa");
            }
        } catch (SQLException e) {
            System.err.println("Error al reabrir la conexión: " + e.getMessage());
            e.printStackTrace();
        }
        return cnn;
    }

    // Método para cerrar la conexión
    public void cerrarConexion() {
        try {
            if (cnn != null && !cnn.isClosed()) {
                cnn.close();
                System.out.println("Conexión cerrada correctamente.");
            }
        } catch (SQLException e) {
            System.err.println("Error al cerrar la conexión: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
