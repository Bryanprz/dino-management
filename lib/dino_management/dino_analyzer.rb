require_relative 'dino_analysis_report'
require_relative 'dino_config'

# Analyzes dinosaur health metrics and generates analysis reports.
# Uses a functional approach with pure functions for better testability
#
class DinoAnalyzer
  include DinoConfig

  def self.analyze(dino)
    if !dino_category_valid?(dino)
      return DinoAnalysisReport.new(
        dino: dino,
        health: nil,
        comment: 'Unknown category',
        age_metrics: nil
      )
    end

    health = calculate_health(dino)
    comment = create_health_comment(health)
    age_metrics = calculate_age_metrics(dino, comment)

    DinoAnalysisReport.new(
      dino: dino,
      health: health,
      comment: comment,
      age_metrics: age_metrics
    )
  end

  private

  def self.calculate_health(dino)
    return 0 if dino.age <= 0
    return remaining_dino_lifespan(dino) if correct_diet?(dino)
    remaining_dino_lifespan(dino) / 2
  end

  def self.create_health_comment(health)
    health.positive? ? 'Alive' : 'Dead'
  end

  def self.calculate_age_metrics(dino, comment)
    return 0 unless comment == 'Alive' && dino.age > 1
    (dino.age / 2).to_i
  end

  def self.correct_diet?(dino)
    (dino.herbivore? && dino.diet == 'plants') ||
    (dino.carnivore? && dino.diet == 'meat')
  end

  def self.remaining_dino_lifespan(dino)
    LIFESPAN - dino.age
  end

  def self.dino_category_valid?(dino)
    SUPPORTED_DINO_CATEGORIES.include?(dino.category)
  end
end