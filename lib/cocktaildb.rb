# Copyright 2022 XXIV
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
require_relative "cocktaildb/version"
require 'net/http'
require 'erb'
require 'json'

module CocktailDB
  class CocktailDBException < StandardError
    def initialize(message)
      super(message)
    end
  end

  class << self

    ##
    # Search cocktail by name
    #
    # * `s` cocktail name
    #
    # Raises CocktailDBException
    def search(s)
      begin
        response = get_request("search.php?s=#{ERB::Util.url_encode(s)}")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['drinks']
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # Search cocktails by first letter
    #
    # * `c` cocktail letter
    #
    # Raises CocktailDBException
    def search_by_letter(c)
      begin
        response = get_request("search.php?f=#{c}")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['drinks']
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # Search ingredient by name
    #
    # * `s` ingredient name
    #
    # Raises CocktailDBException
    def search_ingredient(s)
      begin
        response = get_request("search.php?i=#{ERB::Util.url_encode(s)}")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['ingredients'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['ingredients'][0]
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # Search cocktail details by id
    #
    # * `i` cocktail id
    #
    # Raises CocktailDBException
    def search_by_id(i)
      begin
        response = get_request("lookup.php?i=#{i}")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['drinks'][0]
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # Search ingredient by ID
    #
    # * `i` ingredient id
    #
    # Raises CocktailDBException
    def search_ingredient_by_id(i)
      begin
        response = get_request("lookup.php?iid=#{i}")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['ingredients'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['ingredients'][0]
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # Search a random cocktail
    #
    # Raises CocktailDBException
    def random()
      begin
        response = get_request("random.php")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['drinks'][0]
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # Filter by ingredient
    #
    # * `s` ingredient name
    #
    # Raises CocktailDBException
    def filter_by_ingredient(s)
      begin
        response = get_request("filter.php?i=#{ERB::Util.url_encode(s)}")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['drinks']
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # Filter by alcoholic
    #
    # * `s` alcoholic or non alcoholic
    #
    # Raises CocktailDBException
    def filter_by_alcoholic(s)
      begin
        response = get_request("filter.php?a=#{ERB::Util.url_encode(s)}")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['drinks']
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # Filter by Category
    #
    # * `s` category name
    #
    # Raises CocktailDBException
    def filter_by_category(s)
      begin
        response = get_request("filter.php?c=#{ERB::Util.url_encode(s)}")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['drinks']
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # Filter by Glass
    #
    # * `s` glass name
    #
    # Raises CocktailDBException
    def filter_by_glass(s)
      begin
        response = get_request("filter.php?g=#{ERB::Util.url_encode(s)}")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        return json['drinks']
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # List the categories filter
    #
    # Raises CocktailDBException
    def categories_filter()
      begin
        response = get_request("list.php?c=list")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        list = []
        json['drinks'].each { |i|
          list.append(i["strCategory"])
        }
        return list
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # List the glasses filter
    #
    # Raises CocktailDBException
    def glasses_filter()
      begin
        response = get_request("list.php?g=list")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        list = []
        json['drinks'].each { |i|
          list.append(i["strGlass"])
        }
        return list
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # List the ingredients filter
    #
    # Raises CocktailDBException
    def ingredients_filter()
      begin
        response = get_request("list.php?i=list")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        list = []
        json['drinks'].each { |i|
          list.append(i["strIngredient1"])
        }
        return list
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    ##
    # List the alcoholic filter
    #
    # Raises CocktailDBException
    def alcoholic_filter()
      begin
        response = get_request("list.php?a=list")
        if response.length == 0
          raise CocktailDBException.new("no results found")
        end
        json = JSON.parse(response)
        if json['drinks'] == nil
          raise CocktailDBException.new("no results found")
        end
        list = []
        json['drinks'].each { |i|
          list.append(i["strAlcoholic"])
        }
        return list
      rescue => ex
        raise CocktailDBException.new(ex.message)
      end
    end

    private def get_request(endpoint)
      uri = URI("https://thecocktaildb.com/api/json/v1/1/#{endpoint}")
      res = Net::HTTP.get_response(uri)
      res.body
    end

  end
end