/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.*;
/**
 *
 * @author oscar
 */
public class Seguridad {
    public static String Hash(String clave){
        String claveHash = null;
        try{
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] digest = md.digest(clave.getBytes(StandardCharsets.UTF_8));
            claveHash = Base64.getEncoder().encodeToString(digest);
        }catch(NoSuchAlgorithmException ex){
            System.err.println("No se pudo hashear: " + ex.getMessage());
        }
        return claveHash;
    }
}
    
