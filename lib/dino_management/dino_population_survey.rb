# Handles the survey of dino populations; orchestrates 
# the analysis of data and generates a summary
#
class DinoPopulationSurvey
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