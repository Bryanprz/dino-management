require 'rspec'
require_relative '../lib/dino_management/dino'

describe Dino do
  it 'initializes with correct attributes' do
    dino = Dino.new(name: 'Rex', age: 100, category: 'carnivore', diet: 'meat', period: 'Cretaceous')
    expect(dino.name).to eq('Rex')
    expect(dino.age).to eq(100)
    expect(dino.category).to eq('carnivore')
    expect(dino.diet).to eq('meat')
    expect(dino.period).to eq('Cretaceous')
  end

  describe '#carnivore?' do
    it 'returns true if the dino is a carnivore' do
      dino = Dino.new(name: 'Rex', age: 100, category: 'carnivore', diet: 'meat', period: 'Cretaceous')
      expect(dino.carnivore?).to be true
    end

    it 'returns false if the dino is not a carnivore' do
      dino = Dino.new(name: 'Rex', age: 100, category: 'herbivore', diet: 'plants', period: 'Cretaceous')
      expect(dino.carnivore?).to be false
    end
  end

  describe '#herbivore?' do
    it 'returns true if the dino is a herbivore' do
      dino = Dino.new(name: 'Rex', age: 100, category: 'herbivore', diet: 'plants', period: 'Cretaceous')
      expect(dino.herbivore?).to be true
    end

    it 'returns false if the dino is not a herbivore' do
      dino = Dino.new(name: 'Rex', age: 100, category: 'carnivore', diet: 'meat', period: 'Cretaceous')
      expect(dino.herbivore?).to be false
    end
  end
end
