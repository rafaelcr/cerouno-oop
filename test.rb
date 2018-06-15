require_relative 'animals'

duck = Duck.new
dog = Dog.new
cat = Cat.new

z = Zoo.new([duck, dog, cat])

cat2 = Cat.new
cat2.breed = "Persian"

z.animals.push(cat2)

puts z.total_weight
