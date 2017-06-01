package paquete;
import java.util.ArrayList;

public class NombreClase extends OtraClase {
    private static int varPrivadaClase;
    public int varPublicaInstancia;

    // Constructor
    public NombreClase(...) {
        super(...);
        ...
    }

    public tipo metodoPublicoInstancia() {}
    public static tipo metodoPublicoClase() {}

    @Override
    public tipo metodoRedefinido() {
        super.metodoRedefinido(...);
        ...
    }
}

NombreClase test = new NombreClase(...);
ArrayList<int> miArrayList = new ArrayList<int>();
