# Crear una aplicación pequeña que simule una conversación de WhatsApp entre un grupo de usuarios.
#
# - Sólo podrá haber una conversación de grupo para todos.
# - Cada usuario necesitará un número telefónico para poder unirse al grupo.
# - Cuando un usuario manda un mensaje, se agrega a la conversación para que todos lo vean.
# - Un mensaje sólo puede contener texto (sin fotos, videos, contactos, etc.)
# - Sólo algunos usuarios pueden ser administradores y heredar la funcionalidad de un Admin.

class GroupConversation
  @@name = "Apprenticeship"
  @@users = []
  @@messages = []

  def self.users
    @@users
  end

  def self.messages
    @@messages
  end

  def self.print_conversation
    @@messages.each do |message|
      puts message
    end
  end
end

module Admin
  attr_accessor :is_admin

  def add_user_to_group(user)
    GroupConversation.users.push(user) if @is_admin
  end

  def remove_user_from_group(user)
    GroupConversation.users.delete(user) if @is_admin
  end

  def make_admin(user)
    user.is_admin = true if @is_admin
  end
end

class User
  include Admin

  attr_accessor :name
  attr_accessor :phone_number

  def initialize(name, phone_number)
    @name = name
    @phone_number = phone_number
  end

  def send_message(text)
    message = Message.new(text, self, Time.now)
    GroupConversation.messages.push(message)
  end

  def eql?(other)
    @name == other.name and @phone_number == other.phone_number and @is_admin == other.is_admin
  end

  def hash
    @name.hash + @phone_number.hash + @is_admin.hash
  end
end

class Message
  attr_accessor :text
  attr_accessor :author
  attr_accessor :timestamp

  def initialize(text, author, timestamp)
    @text = text
    @author = author
    @timestamp = timestamp
  end

  def to_s
    "#{@author.name} (#{@timestamp.strftime("%H:%M")}): #{@text}"
  end
end

alice = User.new("Alice", "8164727362")
alice.is_admin = true
GroupConversation.users.push(alice)

bob = User.new("Bob", "4082223115")
alice.add_user_to_group(bob)

alice.send_message("Hola!")
bob.send_message("Como estas?")
alice.send_message("Sensacional!!!!")
bob.send_message("👍🏼")
alice.send_message("Te voy a hacer admin, ok?")

alice.make_admin(bob)

bob.send_message("jaja ya te puedo borrar 😈")
bob.remove_user_from_group(alice)

GroupConversation.print_conversation
