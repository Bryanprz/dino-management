require 'rspec'
require_relative '../lib/dino_management/dino_analysis_report'
require_relative '../lib/dino_management/dino'

describe DinoAnalysisReport do
  let(:dino) { Dino.new(name: 'Rex', age: 100, category: 'carnivore', diet: 'meat', period: 'Cretaceous') }
  let(:report) { DinoAnalysisReport.new(dino: dino, health: 10, comment: 'Alive', age_metrics: 50) }

  it 'initializes with correct attributes' do
    expect(report.dino).to eq(dino)
    expect(report.health).to eq(10)
    expect(report.comment).to eq('Alive')
    expect(report.age_metrics).to eq(50)
  end

  describe '#to_h' do
    it 'converts the report to a hash' do
      expected_hash = {
        'name' => 'Rex',
        'age' => 100,
        'category' => 'carnivore',
        'diet' => 'meat',
        'period' => 'Cretaceous',
        'health' => 10,
        'comment' => 'Alive',
        'age_metrics' => 50
      }
      expect(report.to_h).to eq(expected_hash)
    end
  end
end
