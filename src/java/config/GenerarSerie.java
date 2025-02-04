package config;

/**
 *
 * @author oscar
 */
public class GenerarSerie {
    int dato;
    String numero;

    // Método principal que genera el número de serie según el intervalo
    public String NumeroSerie(int dato){
        this.dato = dato + 1; // Aumenta el valor de 'dato' en 1 antes de generar la serie
        int indice = obtenerIntervalo(dato); // Obtiene el índice del intervalo
        ejecutarMenu(indice); // Ejecuta las instrucciones para el intervalo encontrado
        return numero; // Devuelve el número generado
    }

    // Método para obtener el intervalo en el que se encuentra el número
    public int obtenerIntervalo(int numero){
        // Definimos los límites inferiores y superiores de los intervalos
        int[] limitesInferiores = {0, 10, 100, 1000, 10000, 100000, 1000000, 10000000};
        int[] limitesSuperiores = {10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000};

        // Verificamos en qué intervalo se encuentra el número
        for(int i = 0; i < limitesInferiores.length; i++){
            if(numero >= limitesInferiores[i] && numero < limitesSuperiores[i]){
                return i; // Devuelve el índice del intervalo
            }
        }
        return -1; // Si el número no está en ningún intervalo, retorna -1
    }

    // Método que ejecuta las instrucciones según el intervalo encontrado
    public void ejecutarMenu(int indice){
        // Dependiendo del índice del intervalo, formateamos el número
        switch(indice){
            case 0 -> this.numero = String.format("%08d", this.dato); // Formato con 8 dígitos
            case 1 -> this.numero = String.format("%07d", this.dato); // Formato con 7 dígitos
            case 2 -> this.numero = String.format("%06d", this.dato); // Formato con 6 dígitos
            case 3 -> this.numero = String.format("%05d", this.dato); // Formato con 5 dígitos
            case 4 -> this.numero = String.format("%04d", this.dato); // Formato con 4 dígitos
            case 5 -> this.numero = String.format("%03d", this.dato); // Formato con 3 dígitos
            case 6 -> this.numero = String.format("%02d", this.dato); // Formato con 2 dígitos
            case 7 -> this.numero = String.format("%1d", this.dato); // Formato con 1 dígito
            case 8 -> this.numero = Integer.toString(this.dato); // No tiene ceros a la izquierda
            case -1 -> this.numero = "No válido"; // Si el número no está en ningún intervalo
        }
    }
}
