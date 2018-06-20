require_relative 'animals'

duck = Duck.new
dog = Dog.new
cat = Cat.new
cow = Cow.new

SuperZoo.animals.push(duck)
SuperZoo.animals.push(dog)
SuperZoo.animals.push(cat)

cat2 = Cat.new
cat2.breed = "Persian"

SuperZoo.animals.push(cat2)

puts cow.eat_me
puts cow.meat_type
puts
# puts duck.eat_me
puts duck.meat_type
puts duck.speak
