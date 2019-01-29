require 'rest-client'
require 'json'
require 'pry'
# REMEMBER: to call whatever method you're looking to pry into.

# iterate over the response hash to find the collection of `films` for the given
#   `character`
# collect those film API urls, make a web request to each URL to get the info
#  for that film
# return value of this method should be collection of info about each film.
#  i.e. an array of hashes in which each hash reps a given film
# this collection will be the argument given to `print_movies`
#  and that method will do some nice presentation stuff like puts out a list
#  of movies by title. Have a play around with the puts with other info about a given film.
def print_movies(films)
    # some iteration magic and puts out the movies in a nice list
    films.each do |film_hash|
        puts film_hash["title"]
    end
end

def get_character_movies_from_api(character_name)
    #make the web request
    response_string = RestClient.get('http://www.swapi.co/api/people/')
    response_hash = JSON.parse(response_string)
    array_film_hash = []

    # binding.pry
    response_hash["results"].find do |char_hash|
        if char_hash["name"] == character_name

            char_hash["films"].map do |url|
             array_film_hash << JSON.parse(RestClient.get(url))
            end
        end
    end
    print_movies(array_film_hash)
end

# def get_character_movies_from_api(character)
#   # uri = URI('http://www.swapi.co/api/people/')
#   all_characters = RestClient.get('http://www.swapi.co/api/people/')
#   character_hash = JSON.parse(all_characters)
#   character_data = character_hash["results"].find { |data| data["name"] == character }
#   film_urls = character_data["films"]
#   film_data = film_urls.collect { |data| JSON.parse(RestClient.get(data)) }
#   film_data
# end

get_character_movies_from_api("Luke Skywalker")



def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# That `get_character_movies_from_api` method is probably pretty long.
# Does it do more than one job?
# Can you split it up into helper methods?
