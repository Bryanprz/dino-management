require_relative "dino_management"
require "rspec"

describe "Dino Management" do
  let(:dino_data) { [
    { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
    { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 },
    { "name"=>"DinoC", "category"=>"herbivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>70 },
    { "name"=>"DinoD", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"plant", "age"=>90 },
    { "name"=>"DinoE", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"plant", "age"=>100 }
  ] }

  context "when using the long and unoptimized method" do
    describe "dino health calculation" do
      it "calculates dino health using age, category and diet" do
        expect(run(dino_data)[:dinos][0]["health"]).to eq(0)
        expect(run(dino_data)[:dinos][1]["health"]).to eq(20)
        expect(run(dino_data)[:dinos][2]["health"]).to eq(15)
        expect(run(dino_data)[:dinos][3]["health"]).to eq(5)
      end
    end

    describe "dino comment setting" do
      it "assigns appropriate comment based on health" do
        # if health is greater than 0 comment is 'Alive', else 'Dead'
        expect(run(dino_data)[:dinos][0]["comment"]).to eq('Dead')
        expect(run(dino_data)[:dinos][1]["comment"]).to eq('Alive')
        expect(run(dino_data)[:dinos][2]["comment"]).to eq('Alive')
        expect(run(dino_data)[:dinos][3]["comment"]).to eq('Alive')
        expect(run(dino_data)[:dinos][4]["comment"]).to eq('Dead')
      end
    end

    describe "dino age metric calculation" do
      it "computes age_metrics based on age and comment" do
        # if comment == Dead age metrics is 0
        # if age is 1 or less, age metrics is 0
        # if age is more than 1, age metrics is age divided by 2
        expect(run(dino_data)[:dinos][0]["age_metrics"]).to eq(0)
        expect(run(dino_data)[:dinos][1]["age_metrics"]).to eq(40)
        expect(run(dino_data)[:dinos][2]["age_metrics"]).to eq(35)
        expect(run(dino_data)[:dinos][3]["age_metrics"]).to eq(45)
        expect(run(dino_data)[:dinos][4]["age_metrics"]).to eq(0)
      end
    end

    describe "dino category summary" do
      it "counts dinos by categories" do
        expect(run(dino_data)[:summary]['herbivore']).to eq(2)
        expect(run(dino_data)[:summary]['carnivore']).to eq(3)
      end 
    end
  end
end


