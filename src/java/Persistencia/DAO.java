package Persistencia;

import config.ConexionMySQL;
import config.ContratoDAO;
import java.sql.*;

public abstract class DAO<T> implements ContratoDAO<T>{
    protected Connection cnn;
    protected ConexionMySQL instance;
    protected ResultSet rs;
    protected PreparedStatement st;
    protected String sql;
    protected String errorMessage;
    
    public DAO() {
        instance = ConexionMySQL.getInstance();
    }

    public Connection getCnn() {
        return instance.getCnn();
    }

    public void setCnn(Connection cnn) {
        this.cnn = cnn;
    }

    public ConexionMySQL getInstance() {
        return ConexionMySQL.getInstance();
    }

    public void setInstance(ConexionMySQL instance) {
        this.instance = instance;
    }

    public ResultSet getRs() {
        return rs;
    }

    public void setRs(ResultSet rs) {
        this.rs = rs;
    }

    public PreparedStatement getSt() {
        return st;
    }

    public void setSt(PreparedStatement st) {
        this.st = st;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }
}
