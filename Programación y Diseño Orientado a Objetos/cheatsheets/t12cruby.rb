class NombreClase
  attr_accessor :var1, :var2
  @@class_variable

  private :metodo_clase
  
  def initialize(var1, var2)
    @var1 = var1
    @var2 = var2
  end

  def metodo_instancia
    puts @var1
  end

  def self.metodo_clase
      ...
  end
end

test = NombreClase.new(1,2)
test.metodo_1
