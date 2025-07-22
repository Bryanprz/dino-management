require_relative "dino_management"
require "rspec"

describe "Dino Management" do
  let(:dino_data) { [
    { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
    { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 }
  ] }

  context "when using the long and unoptimized method" do
    describe "dino health calculation" do
      it "calculates dino health using age, category and diet" do
        # puts "Running.... #{run(dino_data)[:dinos][0]["health"]}"
        expect(run(dino_data)[:dinos][0]["health"]).to eq(0)
        expect(run(dino_data)[:dinos][1]["health"]).to eq(20)
      end
    end

    describe "dino comment setting" do
      it "assigns appropriate comment based on health" do
        expect(run(dino_data)[:dinos][0]["comment"]).to eq('Dead')
        expect(run(dino_data)[:dinos][1]["comment"]).to eq('Alive')
      end
    end

    describe "dino age metric calculation" do
      it "computes age_metrics based on age and comment" do
        # if comment == Dead age metrics is 0
        #if d['age'] > 1, then d['age_metrics'] = (d['age'] / 2).to_i
        # if age is more than 1, age metrics is age / 2
        # if age is 1 or less, age metrics is 0
        expect(run(dino_data)[:dinos][0]["age_metrics"]).to eq(0)
        expect(run(dino_data)[:dinos][1]["age_metrics"]).to eq(40)
      end
    end

    describe "dino category summary" do
      it "counts dinos by categories" do
        expect(run(dino_data)[:summary]['herbivore']).to eq(1)
        expect(run(dino_data)[:summary]['carnivore']).to eq(1)
      end 
    end
  end
end


