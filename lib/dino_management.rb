require_relative 'dino_management/dino'
require_relative 'dino_management/dino_population_survey'
require_relative 'dino_management/dino_analysis_report'

module DinoManagement
  class Error < StandardError; end

  # Main entry point for the library
  # @param dinos_data [Array<Hash>] Array of dinosaur data hashes
  # @return [Hash] Analysis results with :dinos and :summary
  # @example
  #   result = DinoManagement.analyze([{name: "T-Rex", ...}])
  def self.analyze(dinos_data)
    survey = DinoPopulationSurvey.new(dinos_data)
    survey.analyze
    
    {
      dinos: survey.reports.map(&:to_h),
      summary: survey.summary
    }
  end

  # Alias for backward compatibility
  def self.run(dinos_data)
    analyze(dinos_data)
  end
end

# For backward compatibility with existing code
# Consider deprecating this in the future
def run(dinos_data)
  warn "[DEPRECATION] Top-level [run](cci:1://file:///Users/bryan/Code/corporate_tools/lib/dino_management.rb:12:0-20:3) is deprecated. Use `DinoManagement.analyze` instead."
  DinoManagement.analyze(dinos_data)
end
