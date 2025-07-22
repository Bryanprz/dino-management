# This is a poorly written code for the management of dinos.
# The purpose of this code is to serve as a refactor test for
# candidates applying for a software engineer position at our company.
# We expect you to refactor it and turn it into an efficient
# and maintainable code, following best practices. Fill in the Rspect test as well, modify it to your liking,
# we do want to see some decent testing.
# Please don't spend too much time on this, we know your time is valuable and we want to
# make this fun but also allow you to show off your ruby skills :)
#
# Existing data: [
#   { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
#   { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 }
# ]
#
require 'pry'

class Dino
  attr_reader :name, :age, :category, :diet, :period

  def initialize(dino_data)
    @name = dino_data['name']
    @age = dino_data['age']
    @category = dino_data['category']
    @diet = dino_data['diet']
    @period = dino_data['period']
  end
end

class DinoHealthTracker
  attr_reader :health, :dino

  def initialize(dino)
    @dino = dino
  end

  def calculate_health
    if dino.age > 0
      @health = dino_eating_correct_diet? ? remaining_dino_lifespan : remaining_dino_lifespan / 2
    else
      @health = 0
    end
  end

  private 

  def dino_eating_correct_diet?
    (dino.category == 'herbivore' && dino.diet == 'plants') || (dino.category == 'carnivore' && dino.diet == 'meat')
  end

  def remaining_dino_lifespan
    100 - dino.age
  end
end

class DinoPopulationTracker
  attr_reader :dinos

  def initialize(dinos)
    @dinos = dinos
  end

  def calculate_dinos_health
    dinos.each do |d|
      dino = Dino.new(d)
      d['health'] = DinoHealthTracker.new(dino).calculate_health
      d['comment'] = d['health'] > 0 ? 'Alive' : 'Dead'
    end
  end

  def calculate_dinos_age_metrics
    dinos.each do |d|
      if d['comment'] == 'Alive' && d['age'] > 1
        d['age_metrics'] = (d['age'] / 2).to_i
      else
        d['age_metrics'] = 0
      end
    end
  end
end

def calculate_dinos_age_metrics(dinos)
  dinos.each do |d|
    if d['comment'] == 'Alive' && d['age'] > 1
        d['age_metrics'] = (d['age'] / 2).to_i
    else
      d['age_metrics'] = 0
    end
  end
end

def group_dinos_by_category(dinos)
  if dinos&.any?
    dinos.group_by { |d| d['category'] }.map do |category, dino_list|
      { category: category, count: dino_list.count }
    end
  end
end

# Dino Managemenet Configuration
def create_dinos_summary(dinos)
  summary = {}
  group_dinos_by_category(dinos).each do |category_metrics|
    summary[category_metrics[:category]] = category_metrics[:count]
  end
  summary
end

def supported_dino_categories
  ['herbivore', 'carnivore']
end

# Responses
def unknown_categories_response(dinos)  
  { dinos: dinos, summary: {'message': 'Cannot process dinos with unknown categories'} }
end

def empty_dinos_response
  { dinos: [], summary: {} }
end

# Main
def run(dinos)
    # Handle 
    if dinos.nil? || dinos.empty?
      return empty_dinos_response 
    end

    # Handle unknown categories
    if dinos.any? { |d| !supported_dino_categories.include?(d['category']) }
      return unknown_categories_response(dinos) 
    end
    
    dinos_population_tracker = DinoPopulationTracker.new(dinos) 
    dinos_population_tracker.calculate_dinos_health
    dinos_population_tracker.calculate_dinos_age_metrics

    return { dinos: dinos, summary: create_dinos_summary(dinos) }
  end
  
  dinfo = run([
               { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
               { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 }
             ])
  
  puts dinfo  