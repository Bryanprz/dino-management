require "rspec"
require_relative "../dino_management"

describe "Dino Management" do
  let(:dino_data) { [
    { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
    { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 },
    { "name"=>"DinoC", "category"=>"herbivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>70 },
    { "name"=>"DinoD", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"plant", "age"=>90 },
    { "name"=>"DinoE", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>0 }
  ] }

  let(:result) { run(dino_data) }
  let(:dinos) { result[:dinos] }
  let(:summary) { result[:summary] }

  context "when using the long and unoptimized method" do
    describe "dino health calculation" do
      it "calculates dino health using age, category and diet" do
        expect(dinos[0]["health"]).to eq(0)
        expect(dinos[1]["health"]).to eq(20)
        expect(dinos[2]["health"]).to eq(15)
        expect(dinos[3]["health"]).to eq(5)
        expect(dinos[4]["health"]).to eq(0)
      end
    end

    describe "dino comment setting" do
      it "assigns appropriate comment based on health" do
        expect(dinos[0]["comment"]).to eq('Dead')
        expect(dinos[1]["comment"]).to eq('Alive')
        expect(dinos[2]["comment"]).to eq('Alive')
        expect(dinos[3]["comment"]).to eq('Alive')
        expect(dinos[4]["comment"]).to eq('Dead')
      end
    end

    describe "dino age metric calculation" do
      it "computes age_metrics based on age and comment" do
        expect(dinos[0]["age_metrics"]).to eq(0) # Dead
        expect(dinos[1]["age_metrics"]).to eq(40) # 80/2
        expect(dinos[2]["age_metrics"]).to eq(35) # 70/2
        expect(dinos[3]["age_metrics"]).to eq(45) # 90/2
        expect(dinos[4]["age_metrics"]).to eq(0) # Age 0
      end
    end

    describe "dino category summary" do      
      it "counts dinos by categories" do
        expect(summary['herbivore']).to eq(2)
        expect(summary['carnivore']).to eq(3)
      end 
    end
  end

  context "edge cases" do
    describe "empty array input" do
      let(:result) { run([]) }

      it "handles empty array gracefully" do
        expect(result[:dinos]).to be_empty
        expect(result[:summary]).to be_empty
      end
    end

    describe "nil input" do
      let(:result) { run(nil) }

      it "returns empty result" do
        expect(result[:dinos]).to be_empty
        expect(result[:summary]).to eq({})
      end
    end

    describe "invalid categories" do
      let(:invalid_dino) { {"name"=>"DinoX", "category"=>"flying", "diet"=>"fish", "age"=>50} }
      let(:result) { run([invalid_dino]) }

      it "handles unknown categories" do
        expect(result[:dinos][0][:health]).to be_nil
        expect(result[:dinos][0]["comment"]).to eq('Unknown category')
        expect(result[:dinos][0]["age_metrics"]).to be_nil
        expect(result[:summary]["message"]).to eq('Cannot process dinos with unknown categories')
      end
    end

    describe "negative ages" do
      let(:negative_age_dino) { {"name"=>"DinoY", "category"=>"carnivore", "diet"=>"meat", "age"=>-10} }
      let(:result) { run([negative_age_dino]) }
      
      it "treats negative ages as 0" do
        expect(result[:dinos][0]["health"]).to eq(0)
        expect(result[:dinos][0]["comment"]).to eq('Dead')
        expect(result[:dinos][0]["age_metrics"]).to eq(0)
      end
    end

    describe "age boundary conditions" do
      let(:age_zero_dino) { {"name"=>"DinoY", "category"=>"herbivore", "diet"=>"plants", "age"=>0} }
      let(:age_one_dino) { {"name"=>"DinoZ", "category"=>"herbivore", "diet"=>"plants", "age"=>1} }
      let(:age_two_dino) { {"name"=>"DinoW", "category"=>"herbivore", "diet"=>"plants", "age"=>2} }
      let(:result) { run([age_zero_dino, age_one_dino, age_two_dino]) }
        
      it "handles age boundary conditions correctly" do
        expect(result[:dinos][0]["age_metrics"]).to eq(0)
        expect(result[:dinos][1]["age_metrics"]).to eq(0)
        expect(result[:dinos][2]["age_metrics"]).to eq(1)
      end
    end
  end
end