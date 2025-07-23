class DinoAnalysisReport
  attr_reader :dino, :health, :comment, :age_metrics

  def initialize(dino:, health:, comment:, age_metrics:)
    @dino = dino
    @health = health
    @comment = comment
    @age_metrics = age_metrics
  end

  def to_h
    {
      'name' => dino.name,
      'age' => dino.age,
      'category' => dino.category,
      'diet' => dino.diet,
      'period' => dino.period,
      'health' => health,
      'comment' => comment,
      'age_metrics' => age_metrics
    }
  end
end
