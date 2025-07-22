# This is a poorly written code for the management of dinos.
# The purpose of this code is to serve as a refactor test for
# candidates applying for a software engineer position at our company.
# We expect you to refactor it and turn it into an efficient
# and maintainable code, following best practices. Fill in the Rspect test as well, modify it to your liking,
# we do want to see some decent testing.
# Please don't spend too much time on this, we know your time is valuable and we want to
# make this fun but also allow you to show off your ruby skills :)
#
# Existing data: [
#   { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
#   { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 }
# ]
#

def run(dinos)
    # Handle nil or empty input
    return { dinos: [], summary: {} } if dinos.nil? || dinos.empty?

    # Handle unknown categories
    return { dinos: dinos, summary: {} } if dinos.any? { |d| !['herbivore', 'carnivore'].include?(d['category']) }

    dinos.each do |d|
      # add [health] to dinos array
      
      # Apply 'Flocking Rules'; find most similar lines and make the differences the same
      # to extract the low-level abstraction first 

      remaining_life_span = 100 - d['age']
      is_eating_correct_diet = (d['category'] == 'herbivore' && d['diet'] == 'plants') || (d['category'] == 'carnivore' && d['diet'] == 'meat')

      if d['age'] > 0
        d['health'] = is_eating_correct_diet ? remaining_life_span : remaining_life_span / 2
      else
        d['health'] = 0
      end

      # add [comment] to dinos array
      if d['health'] > 0
        d['comment'] = 'Alive'
      else
        d['comment'] = 'Dead'
      end
    end

    dinos.each do |d|
      # add [age_metrics] to dinos array  
      if d['comment'] == 'Alive' && d['age'] > 1
          d['age_metrics'] = (d['age'] / 2).to_i
      else
        d['age_metrics'] = 0
      end
    end

    if dinos && dinos.length > 0
      a = dinos.group_by { |d| d['category'] }.map do |category, dino_list|
        { category: category, count: dino_list.count }
      end
    end

    f = {}
    a.each do |category_metrics|
      # add [summary] to dinos array
      f[category_metrics[:category]] = category_metrics[:count]
    end

    return { dinos: dinos, summary: f }
  end
  
  dinfo = run([
               { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
               { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 }
             ])
  
  puts dinfo  