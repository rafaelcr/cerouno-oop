require_relative 'animals'

d = Duck.new
p = Dog.new
c = Cat.new

z = Zoo.new([d, p, c])
z.make_all_noises
puts z.has_birds?
