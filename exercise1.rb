# Objetivo:
#   Diseñar un catálogo de películas de IMDB el cual contenga los siguientes datos
#   - Película: título, año, país de origen, actores principales, foto de portada (URL), compañía
#   - Actor: Nombre completo, género, lugar de nacimiento, fecha de nacimiento, fecha de muerte
#
# Generar por lo menos 10 entradas de películas y agregar a sus actores correspondientes.
# Reutiliza actores que aparezcan en más de una película.
#
# Agrega métodos relevantes para contestar las siguientes preguntas:
# - El actor sigue vivo?
# - Cuántos actores salen en una película?
# - Cuáles son los lugares de nacimiento de los actores de una película?
# - Cuántas películas se tienen dado un año?
# - Cuál es la película con más actores?
# - Cuántas películas se tienen por compañía productora?

class Catalog
  attr_accessor :movies

  def movie_count_per_year(year)
    count = 0
    @movies.each do |movie|
      count += 1 if movie.year == year
    end
    count
  end

  def movie_with_most_actors
    biggest_movie = movies.first
    @movies.each do |movie|
      if movie.actors.count > biggest_movie.actors.count
        biggest_movie = movie
      end
    end
    biggest_movie
  end
end

class Movie
  attr_accessor :title
  attr_accessor :year
  attr_accessor :country
  attr_accessor :actors
  attr_accessor :company
  attr_accessor :cover_url

  def initialize(title)
    @title = title
  end

  def actor_count
    @actors.count
  end

  def actor_birthplaces
    @actors.map do |actor|
      "#{actor.name} was born in #{actor.birthplace}"
    end
  end
end

class Actor
  attr_accessor :name
  attr_accessor :date_of_birth
  attr_accessor :date_of_death
  attr_accessor :birthplace

  def initialize(name)
    @name = name
  end
end

# Star Wars IV
mark_hamill = Actor.new("Mark Hamill")
mark_hamill.birthplace = "Oakland, CA"
mark_hamill.date_of_birth = "25/09/1951"

carrie_fisher = Actor.new("Carrie Fisher")
carrie_fisher.birthplace = "Burbank, CA"
carrie_fisher.date_of_birth = "21/10/1956"
carrie_fisher.date_of_death = "27/12/2016"

star_wars = Movie.new("A New Hope")
star_wars.year = 1977
star_wars.company = "Lucasfilm"
star_wars.country = "USA"
star_wars.actors = [mark_hamill, carrie_fisher]

# Harry Potter and the Philosopher's Stone
emma_watson = Actor.new("Emma Watson")
emma_watson.birthplace = "Paris, France"
emma_watson.date_of_birth = "15/04/1990"

daniel_radcliffe = Actor.new("Daniel Radcliffe")
daniel_radcliffe.birthplace = "London, UK"
daniel_radcliffe.date_of_birth = "23/07/1989"

rupert_grint = Actor.new("Rupert Grint")
rupert_grint.birthplace = "Stevenage, UK"
rupert_grint.date_of_birth = "24/08/1988"

harry_potter = Movie.new("Harry Potter and the Philosopher's Stone")
harry_potter.year = 2001
harry_potter.company = "Warner Bros."
harry_potter.actors = [emma_watson, daniel_radcliffe, rupert_grint]

# Catalog
catalog = Catalog.new
catalog.movies = [star_wars, harry_potter]
