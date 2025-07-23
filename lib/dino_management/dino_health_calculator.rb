class DinoHealthCalculator
    LIFESPAN = 100
  
    def self.calculate(dino)
      return 0 if dino.age <= 0
      return remaining_lifespan(dino) if correct_diet?(dino)
      remaining_lifespan(dino) / 2
    end
  
    private
  
    def self.correct_diet?(dino)
      (dino.herbivore? && dino.diet == "plants") || 
      (dino.carnivore? && dino.diet == "meat")
    end
  
    def self.remaining_lifespan(dino)
      LIFESPAN - dino.age
    end
end