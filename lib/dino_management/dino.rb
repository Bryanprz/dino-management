# Represents a single dino and its biological characteristics
# 
# This is a value object containing immutable data about a dino's 
# species, diet, and historical period
# 
class Dino
    attr_reader :name, :age, :category, :diet, :period
  
    def initialize(dino_data)
      @name = dino_data['name']
      @age = dino_data['age']
      @category = dino_data['category']
      @diet = dino_data['diet']
      @period = dino_data['period']
    end
  
    def herbivore?
      category == 'herbivore'
    end
  
    def carnivore?
      category == 'carnivore'
    end
end