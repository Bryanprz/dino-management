require_relative 'dino'
require_relative 'dino_analyzer'

# Handles the survey of dino populations; orchestrates
# the analysis of data and generates a summary
#
class DinoPopulationSurvey
  attr_reader :reports, :summary, :dinos
  UNKNOWN_CATEGORY_MSG = 'Unknown category'.freeze
  ERROR_MSG = 'Cannot process dinos with unknown categories'.freeze

  def initialize(dinos_data)
    dinos_data = dinos_data || []
    # The original dino_data used string keys, so we convert them to symbols for the Dino initializer
    @dinos = Array(dinos_data).map { |d| Dino.new(**d.transform_keys(&:to_sym)) }
    @reports = []
    @summary = {}
  end

  # Analyzes all dinosaurs and generates reports and a summary
  def analyze
    @reports = @dinos.map { |dino| DinoAnalyzer.analyze(dino) }
    generate_summary
  end

  private

  def generate_summary
    if unknown_categories_present?
      add_error_message
    else
      build_category_summary
    end
  end

  def unknown_categories_present?
    reports.any? { |r| r.comment == UNKNOWN_CATEGORY_MSG }
  end

  def build_category_summary
    group_dinos_by_category.each do |category_metrics|
      summary[category_metrics[:category]] = category_metrics[:count]
    end
  end

  def group_dinos_by_category
    reports.group_by { |r| r.dino.category }.map do |category, report_list|
      { category: category, count: report_list.count }
    end
  end

  def add_error_message
    summary['message'] = ERROR_MSG
  end
end