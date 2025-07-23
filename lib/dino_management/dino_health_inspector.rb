# Inspects an individual dino's data and calculates its health, comment, and age metrics
# Updates the provided data hash with calculated health metrics for use by DinoPopulationSurvey
# 
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