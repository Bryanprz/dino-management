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

module DinoConfig
  LIFESPAN = 100
  SUPPORTED_DINO_CATEGORIES = ['herbivore', 'carnivore'].freeze
end
  
class DinoPopulationTracker
  include DinoConfig
  attr_reader :dinos_data, :summary, :dinos_health_inspectors

  def initialize(dinos_data)
    @dinos_data = dinos_data || []
    @dinos_health_inspectors = create_health_inspectors
    @summary = {}
  end

  def analyze
    analyze_dinos_data
    generate_summary
  end

  private 

  def create_health_inspectors
    @dinos_data.map { |d| DinoHealthInspector.new(d) }
  end

  def analyze_dinos_data
    dinos_health_inspectors.each(&:analyze)
  end

  def generate_summary
    if dino_categories_valid?
      build_category_summary
    else
      add_error_message
    end
  end

  def dino_categories_valid?
    dinos_data.all? { |d| SUPPORTED_DINO_CATEGORIES.include?(d['category']) }
  end

  def build_category_summary
    group_dinos_by_category.each do |category_metrics|
      summary[category_metrics[:category]] = category_metrics[:count]
    end
  end

  def group_dinos_by_category
    dinos_data.group_by { |d| d['category'] }.map do |category, dino_list|
      { category: category, count: dino_list.count }
    end
  end

  def add_error_message
    summary['message'] = 'Cannot process dinos with unknown categories'
  end
end

class DinoHealthInspector
  include DinoConfig
  attr_reader :health, :dino, :dino_data, :age_metrics, :comment

  def initialize(dino_data)
    @dino_data = dino_data
    @dino = Dino.new(dino_data)
  end

  def analyze
    calculate_health
    create_health_comment
    calculate_age_metrics
  end

  private 
  
  def calculate_health
    @health = if dino.age <= 0
      0
    elsif correct_diet?
      remaining_dino_lifespan
    else
      remaining_dino_lifespan / 2
    end

    dino_data['health'] = @health
  end

  def create_health_comment
    unless dino_category_valid?
      @comment = 'Unknown category'
      dino_data['comment'] = @comment
      return
    end

    @comment = health.positive? ? 'Alive' : 'Dead'
    dino_data['comment'] = @comment
  end

  def calculate_age_metrics
    @age_metrics = if !dino_category_valid?
      nil
    elsif dino_alive_and_old_enough?
      (dino_data['age'] / 2).to_i
    else
      0
    end 

    dino_data['age_metrics'] = @age_metrics
  end

  def correct_diet?
    (dino.category == 'herbivore' && dino.diet == 'plants') ||
    (dino.category == 'carnivore' && dino.diet == 'meat')
  end

  def remaining_dino_lifespan
    LIFESPAN - dino.age
  end

  def dino_category_valid?
    SUPPORTED_DINO_CATEGORIES.include?(dino.category)
  end

  def dino_alive_and_old_enough?
    dino_data['comment'] == 'Alive' && dino.age > 1
  end
end

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

# Main
def run(dinos_data)
  dino_population_tracker = DinoPopulationTracker.new(dinos_data)
  dino_population_tracker.analyze

  { 
    dinos: dino_population_tracker.dinos_data, 
    summary: dino_population_tracker.summary 
  }
end

dinfo = run([
  { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
  { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 }
])

puts dinfo  