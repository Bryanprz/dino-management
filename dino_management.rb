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
  attr_reader :dinos_data, :summary

  SUPPORTED_DINO_CATEGORIES = ['herbivore', 'carnivore'].freeze

  def initialize(dinos_data)
    @dinos_data = dinos_data
    @dinos_data = [] if dinos_data.nil?
    @summary = {}
  end

  def analyze_data
    report_dinos_health
    report_dinos_age_metrics
    report_summary
  end

  def report_dinos_health
    dinos_data.each do |d|
      dino = Dino.new(d)
      d['health'] = DinoHealthTracker.new(dino).calculate_health

      if dino_categories_valid?
        d['comment'] = d['health'] > 0 ? 'Alive' : 'Dead'
      else
        d['comment'] = 'Unknown category'
      end
    end
  end

  def report_dinos_age_metrics
    dinos_data.each do |d|
      if dino_categories_valid?
        if d['comment'] == 'Alive' && d['age'] > 1
          d['age_metrics'] = (d['age'] / 2).to_i
        else
          d['age_metrics'] = 0
        end
      else
        d['age_metrics'] = nil
      end
    end
  end

  def report_summary
    # binding.pry
    # if !dino_categories_valid?
    #   binding.pry
    #   summary['message'] = 'Cannot process dinos with unknown categories'
    #   binding.pry
    #   return
    # end

    if !dino_categories_valid?
      message = 'Cannot process dinos with unknown categories'
      summary['message'] = message
      dinos_data.each { |dino| dino['message'] = message }
      return 
    end
    
    group_dinos_by_category.each do |category_metrics|
      summary[category_metrics[:category]] = category_metrics[:count]
    end
    summary
  end

  # def self.unknown_categories_response(dinos_data)
  #   { dinos: dinos_data, summary: {'message': 'Cannot process dinos with unknown categories'} }
  # end
  
  private 

  def dino_categories_valid?
    dinos_data.all? { |d| SUPPORTED_DINO_CATEGORIES.include?(d['category']) }
  end

  def group_dinos_by_category
    if dinos_data&.any?
      dinos_data.group_by { |d| d['category'] }.map do |category, dino_list|
        { category: category, count: dino_list.count }
      end
    end
  end

end

def supported_dino_categories
  ['herbivore', 'carnivore']
end

# Main
def run(dinos)
    return {dinos: [], summary: {}} if dinos.nil? || dinos.empty?

    dino_population_tracker = DinoPopulationTracker.new(dinos)
    dino_population_tracker.analyze_data

    return { dinos: dinos, summary: dino_population_tracker.summary }
  end
  
  dinfo = run([
               { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
               { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 }
             ])
  
  puts dinfo  