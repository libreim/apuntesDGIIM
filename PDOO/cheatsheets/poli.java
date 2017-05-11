Hijo1 h1 = new Hijo1();
Padre p = new Hijo1();
        
p.doSomething(); // "hijo1" (tipo dinámico)
h1.doSomething(); // "hijo1"

// UPCAST: automático. Innecesario
((Padre) p).doSomething(); // "hijo1"
((Padre) h1).doSomething(); // "hijo1"
        
// DOWNCAST: Evita errores de compilación.
//p.doHijo1(); // No compila
((Hijo1) p).doHijo1(); // Compila, y funciona
p = new Hijo2();
//((Hijo1) p).doHijo1(); // Compila, pero runtime error.
        
Padre pp = new Padre();
//Hijo1 hh1 = pp; // Un Hijo1 no puede apuntar a Padre
//Hijo1 hh1 = (Hijo1) pp; // Compila, pero al ejecutar explota

pp = new Hijo1();
//Hijo1 hh1 = pp; // No compila, misma razón que antes
Hijo1 hh1 = (Hijo1) pp; // Compila, y ejecuta bien (downcast)
hh1.doSomething();

//Hijo2 h2 = new Hijo1();
Hijo1 hhh1;
//Hijo2 h2 = hhh1;
//Hijo2 h2 = (Hijo2) hhh1;
Padre ppp = new Hijo1();
//Hijo2 h2 = (Hijo2) ppp; // Compila, pero explota
        
