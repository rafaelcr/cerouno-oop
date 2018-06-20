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

  def eql?(other_polygon)
    @sides == other_polygon.sides and @color == other_polygon.color
  end

  def hash
    @sides.hash + @color.hash
  end
end

class Circle < Polygon
  attr_accessor :radius

  def self.pi
    3.14159265359
  end

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

  def eql?(other_circle)
    super and @radius == other_circle.radius
  end

  def hash
    super + @radius.hash
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

  def perimeter
    a = @base / 2
    b = @height
    h = Math.sqrt((a * a) + (b * b))

    @base + (2 * h)
  end

  def eql?(other_triangle)
    super and @base == other_triangle.base and @height == other_triangle.height
  end

  def hash
    super + @base.hash + @height.hash
  end
end

class SidesPolygon < Polygon
  attr_accessor :side_length

  def initialize(side_length, sides, color)
    super(sides, color)
    @side_length = side_length
  end

  def perimeter
    @side_length * @sides
  end

  def eql?(other_polygon)
    super and @side_length == other_polygon.side_length
  end

  def hash
    @side_length.hash + super
  end
end

class Square < SidesPolygon
  def initialize(side_length)
    super(side_length, 4, "red")
  end

  def area
    @side_length * @side_length
  end
end

class Pentagon < SidesPolygon
  def initialize(side_length, color)
    super(side_length, 5, color)
  end

  def area
    a = @side_length
    0.25 * Math.sqrt(5 * (5 + 2 * Math.sqrt(5))) * (a * a)
  end
end

class Hexagon < SidesPolygon
  def initialize(side_length, color)
    super(side_length, 6, color)
  end

  def area
    ((3 * Math.sqrt(3)) / 2) * @side_length * @side_length
  end
end
