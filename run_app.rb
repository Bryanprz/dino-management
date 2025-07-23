require_relative './lib/dino_management'

puts "\n--- Dino Management System Analysis ---"
puts "Running analysis with sample data...\n"

dinos_data = [
  { "name"=>"T-Rex", "category"=>"carnivore", "period"=>"Cretaceous", "diet"=>"meat", "age"=>100 },
  { "name"=>"Stegosaurus", "category"=>"herbivore", "period"=>"Jurassic", "diet"=>"plants", "age"=>80 },
  { "name"=>"Velociraptor", "category"=>"carnivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>70 }, # Incorrect diet
  { "name"=>"Brachiosaurus", "category"=>"herbivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>90 }, # Incorrect diet
  { "name"=>"Pterodactyl", "category"=>"flying", "period"=>"Jurassic", "diet"=>"fish", "age"=>50 }, # Invalid category
  { "name"=>"Ankylosaurus", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>60 } # Another supported dino
]

result = DinoManagement.analyze(dinos_data)

puts "--- Individual Dino Reports ---"
if result[:dinos].empty?
  puts "No dino reports generated."
else
  result[:dinos].each_with_index do |dino, index|
    puts "\n  Dino ##{index + 1}:"
    puts "    Name: #{dino['name']}"
    puts "    Category: #{dino['category']}"
    puts "    Age: #{dino['age']}"
    puts "    Diet: #{dino['diet']}"
    puts "    Period: #{dino['period']}"
    puts "    Health: #{dino['health'] || 'N/A'}"
    puts "    Comment: #{dino['comment'] || 'N/A'}"
    puts "    Age Metrics: #{dino['age_metrics'] || 'N/A'}"
  end
end

puts "\n--- Population Summary ---"

if result[:summary].empty?
  puts "No summary generated."
else
  result[:summary].each do |key, value|
    puts "  #{key.to_s.capitalize}: #{value}"
  end
end

puts "\n--- Analysis Complete ---"