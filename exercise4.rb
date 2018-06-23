# Crea un sistema para una biblioteca en el que se puedan realizar las siguientes acciones:
#
# - Registrar/eliminar a un usuario para rentar libros.
#   Se guardarán los campos de nombre, apellido, fecha de nacimiento y email
# - Registrar/eliminar un libro del inventario.
#   Un libro tendrá título, autor, año e ISBN, y número de copias
# - Marcar algunos libros como adquiribles (pueden ser comprados por usuarios)
#   Esos libros tendrán un precio asignado
# - Poder listar:
#   - Usuarios
#   - Libros
#   - Libros rentados
#   - Libros con retraso
#   - Usuarios que deben libros con retraso
# - Poder listar las rentas totales con su fecha y nombre de la persona.

class User
  attr_accessor :name
  attr_accessor :last_name
  attr_accessor :date_of_birth
  attr_accessor :email
  attr_accessor :current_rent

  def initialize(name, last_name, date_of_birth, email)
    @name = name
    @last_name = last_name
    @date_of_birth = date_of_birth
    @email = email
  end

  # Implementamos `eql?` y `hash` para que Ruby pueda comparar este objeto contra
  # otros similares en un arreglo, hash, etc. por ej para que pueda eliminarlo de un arreglo.
  #
  # `eql?` regresa `true` o `false` si el otro objeto es igual (mismos valores).
  def eql?(other)
    @name == other.name and @last_name == other.last_name and @date_of_birth == other.date_of_birth and @email == other.email
  end

  # `hash` calcula un número único para este objeto (como huella digital).
  def hash
    @name.hash + @last_name.hash + @date_of_birth.hash + @email.hash
  end

  def to_s
    "#{@name} #{@last_name}"
  end
end

module Purchasable
  attr_accessor :for_sale
  attr_accessor :price
end

class Book
  include Purchasable

  attr_accessor :title
  attr_accessor :author
  attr_accessor :year
  attr_accessor :isbn
  attr_accessor :number_of_copies

  def initialize(title, author, year, isbn, number_of_copies)
    @title = title
    @author = author
    @year = year
    @isbn = isbn
    @number_of_copies = number_of_copies
    @for_sale = false
  end

  def eql?(other)
    @title == other.title and @author == other.author and @year == other.year and @isbn == other.isbn and @number_of_copies == other.number_of_copies
  end

  def hash
    @title.hash + @author.hash + @year.hash + @isbn.hash + @number_of_copies.hash
  end

  def to_s
    "#{@title}, #{@author} (#{@year})"
  end
end

class BookRent
  attr_accessor :user
  attr_accessor :book
  attr_accessor :rent_timestamp
  attr_accessor :return_timestamp

  def initialize(user, book)
    @user = user
    @book = book
    @rent_timestamp = Time.now
    @return_timestamp = nil
  end

  def to_s
    # Si `@return_timestamp` no tiene valor, Ruby va a asignar "(rented)".
    return_status = @return_timestamp || "(rented)"
    "#{@rent_timestamp}\n#{return_status}\n#{@book.title}\n#{@user.name} #{@user.last_name}"
  end
end

class Library
  @@users = []
  @@books = []
  @@book_rents = []

  def self.users
    @@users
  end

  def self.books
    @@books
  end

  def self.book_rents
    @@book_rents
  end

  def self.rent(user, book)
    # No se puede rentar un libro si ya no hay copias disponibles.
    raise "Book is not available" if book.number_of_copies == 0
    book.number_of_copies -= 1
    # Al rentar, se genera un objeto de tipo `BookRent` y se guarda en el `User` como su
    # renta actual.
    rent = BookRent.new(user, book)
    @@book_rents.push(rent)
    user.current_rent = rent
  end

  def self.return(rent)
    # Al regresar un libro, se almacena la fecha de regreso y se le incrementa 1 de nuevo
    # al número total de copias del libro.
    rent.return_timestamp = Time.now
    rent.book.number_of_copies += 1
  end
end

# Crear usuarios.
mark_hamill = User.new("Mark", "Hamill", Time.new(1990, 1, 4),"mark.hamill@gmail.com")
carrie_fisher = User.new("Carrie","Fisher", Time.new(1990, 1, 4),"carrie.fisher@gmail.com")
emma_watson = User.new("Emma", "Watson", Time.new(1990, 1, 4), "emma.watson@gmail.com")
daniel_radcliffe = User.new("Daniel", "Radcliffe", Time.new(1990, 1, 4), "daniel.radcliffe@gmail.com")
rupert_grint = User.new("Rupert", "Grint", Time.new(1990, 1, 4), "rupert.grint@gmail.com")

# Agregar a biblioteca.
Library.users.concat([mark_hamill, carrie_fisher, emma_watson, daniel_radcliffe,
  rupert_grint])

# Eliminar usuario de biblioteca.
Library.users.delete(mark_hamill)

# Crear libros.
harry_potter1 = Book.new("Harry Potter and the Philosopher's Stone","J. K. Rowling", 1997, "0439554934", 7)
harry_potter2 = Book.new("Harry Potter and the Chamber of Secrets","J. K. Rowling", 1998, "0439064864", 7)
harry_potter3 = Book.new("Harry Potter and the Prisoner of Azkaban","J. K. Rowling", 1999, "043965548X", 7)
harry_potter4 = Book.new("Harry Potter and the Goblet of Fire","J. K. Rowling", 2000, "0439139600", 7)
harry_potter5 = Book.new("Harry Potter and the Order of the Phoenix","J. K. Rowling", 2003, "0439358078", 7)
harry_potter6 = Book.new("Harry Potter and the Half-Blood Prince","J. K. Rowling", 2005, "0439785960", 7)
harry_potter7 = Book.new("Harry Potter and the Deathly Hallows","J. K. Rowling", 2007, "0545010225", 7)
gone_girl = Book.new("Gone Girl","Gillian Flynn", 2012, "0307588378", 5)
godfather1 = Book.new("The Godfather","Mario Puzo", 1969, "0451205766", 2)
godfather1.for_sale = true
godfather1.price = 250.0
narnia_1to7 = Book.new("The Chronicles of Narnia","C. S. Lewis", 1956, "0066238501", 4)

# Agregar libros a biblioteca.
Library.books.concat([harry_potter1, harry_potter2, harry_potter3, harry_potter4,
  harry_potter5, harry_potter6, harry_potter7, gone_girl, godfather1, narnia_1to7])

# Eliminar libro de biblioteca.
Library.books.delete(gone_girl)

# Rentar libro.
Library.rent(daniel_radcliffe, harry_potter1)

# Regresar libro.
Library.return(daniel_radcliffe.current_rent)
