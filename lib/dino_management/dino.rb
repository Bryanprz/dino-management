# Represents a single dino and its biological characteristics
# 
# This is a value object containing immutable data about a dino's 
# species, diet, and historical period
# 
class Dino
  attr_reader :name, :age, :category, :diet, :period
  
  def initialize(name:, age:, category:, diet:, period: nil)
    @name = name
    @age = age
    @category = category
    @diet = diet
    @period = period
  end
  
  def herbivore?
    category == 'herbivore'
  end
  
  def carnivore?
    category == 'carnivore'
  end
end