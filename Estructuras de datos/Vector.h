/**
  * @file vector_dinamico.h
  * @brief fichero cabecera del TDA vector dinamico.
  *
  * se crea un vector con capacidad de crecer y decrecer.
  *
  */

#ifndef _vectorDinamico_h
#define _vectorDinamico_h

class vector_dinamico{
private:


public:
  // ----------------------Constructores--------------------------

  /**
    * @brief constructor por defecto
    * @param n indica el número de componentes inicial reservados para el vector.
    *  reservados para el vector.
    * @note Este constructor tambien corresponde al de por defecto.
    */


  vector_dinamico(int n);
  vector_dinamico(const vector_dinamico& original);


  // ----------------------Destructor-----------------------------

  ~vector_dinamico();

  // ----------------------Funciones------------------------------

  int size();

  float& operator[] (int i);

    /**
      * @brief Acceso a un elemento de un vector constante.
      * @param i es la posicion del vector donde está el elemento.
      * @return Devuelve la referencia al elemento. Se supone que el vector no se puede moficidar y por tanto es acceso solo de lectura.
      */
  const float& operator[] (int i) const;
  /**
    * @brief Redimension del vector.
    * @param n es el nuevo tamaño del vector.
    * @post Los valores almacenados antes de la redimension no se pierden (excepto los que salen del nuevo rango de los indices).
    */
  void resize (int n);
  vector_dinamico& operator = (const vector_dinamico& original);


}
