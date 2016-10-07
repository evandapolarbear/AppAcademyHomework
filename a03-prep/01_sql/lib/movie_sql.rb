require 'singleton'
require 'sqlite3'

class MovieDatabase < SQLite3::Database
  include Singleton

  def initialize
    super(File.dirname(__FILE__) + "/../movie.db")

    self.results_as_hash = true
    self.type_translation = true
  end

  def self.execute(*args)
    self.instance.execute(*args)
  end
end

# 1. Obtain the cast list for the movie "Zoolander"; order by the
# actor's name.
def zoolander_cast
  MovieDatabase.execute(<<-SQL)
  SELECT actors.name
  FROM movies
  JOIN castings on movies.id = castings.movie_id
  JOIN actors on actors.id = castings.actor_id
  WHERE movies.title = "Zoolander"
  ORDER BY actors.name
SQL
end

# 2. List the films in which 'Harrison Ford' has appeared; order by
# movie title.
def harrison_ford_films
  MovieDatabase.execute(<<-SQL)
  SELECT movies.title
  FROM movies
  JOIN castings on movies.id = castings.movie_id
  JOIN actors on actors.id = castings.actor_id
  WHERE actors.name = 'Harrison Ford'
  ORDER BY movies.title
SQL
end

# 3. List the films in which 'Denzel Washington' has appeared, but not
#    in the leading role. Order by movie title.
def denzel_washington_non_starring_films
  MovieDatabase.execute(<<-SQL)
  SELECT movies.title
  FROM movies
  JOIN castings on movies.id = castings.movie_id
  JOIN actors on actors.id = castings.actor_id
  WHERE actors.name = 'Denzel Washington' AND castings.ord != 1
  ORDER BY movies.title
SQL
end

# 4. List the films together with the leading star for all 1962
# films. Order by movie title.
def leading_star_for_1962_films
  MovieDatabase.execute(<<-SQL)
  SELECT movies.title, actors.name
  FROM movies
  JOIN castings on movies.id = castings.movie_id
  JOIN actors on actors.id = castings.actor_id
  WHERE movies.yr = 1962 AND castings.ord = 1
  ORDER BY movies.title
SQL
end

# 5. There is a film from 2012 in our database for which there is no
# associated casting information. Give the id and title of this movie.
def unknown_actors_2012
  MovieDatabase.execute(<<-SQL)
  SELECT movies.id, movies.title
  FROM movies
  LEFT OUTER JOIN castings on movies.id = castings.movie_id
  WHERE castings.actor_id IS NULL
  GROUP BY movies.id

SQL
end

# 6. List the movie title and starring actor (ord = 1) for films with 70
#    or more cast members. Order by movie title.
#
#    NB: Make sure you group by movie id
#    and not by movie title (what if there are remakes?).

def big_movie_stars
  MovieDatabase.execute(<<-SQL)
  SELECT movies.title, lead_actors.name
  FROM movies
  JOIN castings on movies.id = castings.movie_id
  JOIN actors on actors.id = castings.actor_id
  join castings as lead_castings on lead_castings.actor_id = actors.id
  join actors as lead_actors on lead_actors.id = lead_castings.id
  where lead_castings.ord = 1
  GROUP BY movies.id
  HAVING COUNT(actors.name) >= 70
  ORDER BY movies.title
SQL
end

# 7. List the film title and the leading actor for all of the films
# 'Julie Andrews' played in. Order by movie title name. Be careful!
# There is a movie (Pink Panther) in which Julie Andrews appears in
# two roles; do not double count the star of that film (Peter
# Sellers).
def julie_andrews_stars
  MovieDatabase.execute(<<-SQL)
  SELECT DISTINCT(movies.title), lead_actors.name
  FROM actors AS julie_actors
  JOIN castings AS julie_castings on julie_actors.id = julie_castings.actor_id
  JOIN movies ON julie_castings.movie_id = movies.id
  JOIN castings AS lead_castings ON movies.id = lead_castings.movie_id
  JOIN actors AS lead_actors on lead_actors.id = lead_castings.actor_id
  WHERE julie_actors.name = 'Julie Andrews' AND lead_castings.ord = 1
SQL
end

# 8. There is a movie in which 'Barrie Ingham' plays two roles. Write a
# query that returns the title of this movie.
def barrie_ingham_multiple_roles
  MovieDatabase.execute(<<-SQL)
  SELECT movies.title
  FROM movies
  JOIN castings on movies.id = castings.movie_id
  JOIN actors on actors.id = castings.actor_id
  WHERE actors.name = 'Barrie Ingham'
  GROUP BY movies.title
  HAVING COUNT(*) > 1
SQL
end
