require_relative 'modules'

class SuperZoo
  @@animals = []

  def self.animals
    @@animals
  end

  def self.total_weight
    total = 0
    @@animals.each do |animal|
      total += animal.weight
    end
    total
  end

  def self.mammals
    mammals = []
    @@animals.each do |animal|
      mammals.push(animal) if animal.is_a?(Mammal)
    end
    mammals
  end

  def self.make_all_noises
    @@animals.each do |animal|
      puts "Hi, I'm a #{animal.class.name} and my noise is #{animal.make_noise}"
    end
  end

  def self.has_birds?
    @@animals.each do |animal|
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
  include Speakable
  include Edible

  def initialize
    super
    @language = "Chinese"
    @meat_type = "White Meat"
    @alive = true
  end

  def make_noise
    "quack"
  end

  def eat_me
    @alive = false
    "Quack quack yum yum"
  end

  def speak
    return super if @alive
    "I'm dead x_x"
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
  include Speakable

  def initialize
    super
    @language = "Russian"
  end

  def make_noise
    "woof"
  end
end

class Cow < Mammal
  include Edible

  def initialize
    super
    @meat_type = "Red Meat"
  end

  def make_noise
    "moooooo"
  end
end
