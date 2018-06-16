class Person
  attr_accessor :name
  attr_accessor :middle_name
  attr_accessor :last_name
  attr_reader :date_of_birth
  attr_accessor :nationality

  def initialize(name, last_name, nationality = "Mexican")
    @name = name
    @last_name = last_name
    @nationality = nationality
  end

  def full_name
    names = []
    names.push(@name)
    names.push(@middle_name) if @middle_name != nil
    names.push(@last_name)
    names.join(" ")
  end
end

p = Person.new("Juan", "Gonzalez")
p.middle_name = "José"
puts p.full_name
