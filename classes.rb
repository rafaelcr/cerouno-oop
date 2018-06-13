# Objetivos de aprendizaje:
#
# 1) Declarar una clase en Ruby
# 2) Agregar un constructor
# 3) Definir atributos y su acceso (reader, writer, accessor)
# 4) Agregar métodos
# 5) Controlar el acceso a métodos
# 6) Herencia de clases

class Polygon
  attr_reader :sides
  attr_accessor :color

  def initialize(sides, color = "black")
    @sides = sides
    @color = color
  end

  def area
  end

  def perimeter
  end
end

class Circle < Polygon
  attr_accessor :radius

  def initialize(radius)
    super(0)
    @radius = radius
  end

  def area
    pi * @radius * @radius
  end

  def perimeter
    2 * pi * @radius
  end

  protected

  def pi
    3.14159265359
  end
end

class BigCircle < Circle
  def initialize(radius)
    raise "Big circles have a radius bigger than 20" if radius < 20.0
    super(radius)
  end

  def perimeter
    4 * pi * @radius
  end
end

class Square < Polygon
  attr_accessor :side_length

  def initialize(side_length)
    super(4, "red")
    @side_length = side_length
  end

  def area
    @side_length * @side_length
  end

  def perimeter
    @side_length * @sides
  end
end

class Triangle < Polygon
  attr_accessor :base
  attr_accessor :height

  def initialize(base, height, color = nil)
    if color == nil
      super(3)
    else
      super(3, color)
    end
    @base = base
    @height = height
  end

  def area
    (@base * @height) / 2.0
  end
end
