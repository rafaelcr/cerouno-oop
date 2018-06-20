module Speakable
  attr_accessor :language

  def speak
    "Hi! I'm a #{self.class} and I can speak #{@language}!!!"
  end
end

module Edible
  attr_accessor :meat_type

  def eat_me
    "Yum yum"
  end
end
