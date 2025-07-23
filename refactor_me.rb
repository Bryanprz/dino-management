require_relative "dino_management"
require "rspec"

describe "Dino Management" do
  let(:dino_data) { [
    { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
    { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 },
    { "name"=>"DinoC", "category"=>"herbivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>70 },
    { "name"=>"DinoD", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"plant", "age"=>90 },
    { "name"=>"DinoE", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>0 }
  ] }

  context "when using the long and unoptimized method" do
    describe "dino health calculation" do
      it "calculates dino health using age, category and diet" do
        expect(run(dino_data)[:dinos][0]["health"]).to eq(0)
        expect(run(dino_data)[:dinos][1]["health"]).to eq(20)
        expect(run(dino_data)[:dinos][2]["health"]).to eq(15)
        expect(run(dino_data)[:dinos][3]["health"]).to eq(5)
        expect(run(dino_data)[:dinos][4]["health"]).to eq(0)
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

  context "edge cases" do
    describe "empty array input" do
      it "handles empty array gracefully" do
        result = run([])
        expect(result[:dinos]).to be_empty
        expect(result[:summary]).to be_empty
      end
    end

    describe "nil input" do
      it "returns empty result" do
        result = run(nil)
        expect(result[:dinos]).to be_empty
        expect(result[:summary]).to eq({})
      end
    end

    describe "invalid categories" do
      let(:invalid_dino) { {"name"=>"DinoX", "category"=>"flying", "diet"=>"fish", "age"=>50} }
      
      it "handles unknown categories" do
        result = run([invalid_dino])
        expect(result[:dinos][0][:health]).to be_nil
        expect(result[:dinos][0]["comment"]).to eq('Unknown category')
        expect(result[:dinos][0]["age_metrics"]).to be_nil
        expect(result[:summary]["message"]).to eq('Cannot process dinos with unknown categories')
      end
    end

    describe "negative ages" do
      let(:negative_age_dino) { {"name"=>"DinoY", "category"=>"carnivore", "diet"=>"meat", "age"=>-10} }
      
      it "treats negative ages as 0" do
        result = run([negative_age_dino])
        expect(result[:dinos][0]["health"]).to eq(0)
        expect(result[:dinos][0]["comment"]).to eq('Dead')
        expect(result[:dinos][0]["age_metrics"]).to eq(0)
      end
    end

    describe "age boundary conditions" do
      let(:age_zero_dino) { {"name"=>"DinoY", "category"=>"herbivore", "diet"=>"plants", "age"=>0} }
      let(:age_one_dino) { {"name"=>"DinoZ", "category"=>"herbivore", "diet"=>"plants", "age"=>1} }
      let(:age_two_dino) { {"name"=>"DinoW", "category"=>"herbivore", "diet"=>"plants", "age"=>2} }
      
      it "handles age boundary conditions correctly" do
        result = run([age_one_dino, age_two_dino])
        
        # Age 0 should have 0 age_metrics
        expect(result[:dinos][0]["age_metrics"]).to eq(0)

        # Age 1 should have 0 age_metrics
        expect(result[:dinos][0]["age_metrics"]).to eq(0)
        
        # Age 2 should have 1 age_metrics (2/2 = 1)
        expect(result[:dinos][1]["age_metrics"]).to eq(1)
      end
    end
  end
end


