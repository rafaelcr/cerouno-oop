class Zoo
  attr_accessor :animals

  def initialize(animals)
    @animals = animals
  end

  def total_weight
    total = 0
    @animals.each do |animal|
      total += animal.weight
    end
    total
  end

  def mammals
    mammals = []
    @animals.each do |animal|
      mammals.push(animal) if animal.is_a?(Mammal)
    end
    mammals
  end

  def make_all_noises
    @animals.each do |animal|
      puts "Hi, I'm a #{animal.class.name} and my noise is #{animal.make_noise}"
    end
  end

  def has_birds?
    @animals.each do |animal|
      return true if animal.is_a?(Bird)
    end
    false
  end
end


class Animal
  attr_accessor :hair_color
  attr_accessor :weight
  attr_accessor :age

  def initialize
    @weight = 0.0
  end

  def make_noise
  end
end





class Bird < Animal
  def lay_eggs
  end
end

class Mammal < Animal
  attr_accessor :breed
end






class Duck < Bird
  def make_noise
    "quack"
  end
end

class Cat < Mammal
  def make_noise
    if @breed == "Persian"
      "meow"
    else
      "miau"
    end
  end
end

class Dog < Mammal
  def make_noise
    "woof"
  end
end
