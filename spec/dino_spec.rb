require 'rspec'
require_relative '../lib/dino_management/dino'

describe Dino do
  let(:carnivore_dino) { Dino.new(name: 'Rex', age: 100, category: 'carnivore', diet: 'meat', period: 'Cretaceous') }
  let(:herbivore_dino) { Dino.new(name: 'Triceratops', age: 80, category: 'herbivore', diet: 'plants', period: 'Cretaceous') }

  it 'initializes with correct attributes' do
    expect(carnivore_dino.name).to eq('Rex')
    expect(carnivore_dino.age).to eq(100)
    expect(carnivore_dino.category).to eq('carnivore')
    expect(carnivore_dino.diet).to eq('meat')
    expect(carnivore_dino.period).to eq('Cretaceous')
  end

  describe '#carnivore?' do
    it 'returns true if the dino is a carnivore' do
      expect(carnivore_dino.carnivore?).to be true
    end

    it 'returns false if the dino is not a carnivore' do
      expect(herbivore_dino.carnivore?).to be false
    end
  end

  describe '#herbivore?' do
    it 'returns true if the dino is a herbivore' do
      expect(herbivore_dino.herbivore?).to be true
    end

    it 'returns false if the dino is not a herbivore' do
      expect(carnivore_dino.herbivore?).to be false
    end
  end
end