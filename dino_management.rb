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

def remaining_dino_lifespan(dino)
  100 - dino['age']
end

def dino_eating_correct_diet?(dino)
  (dino['category'] == 'herbivore' && dino['diet'] == 'plants') || (dino['category'] == 'carnivore' && dino['diet'] == 'meat')
end

def calculate_dinos_health(dinos)
  dinos.each do |d|
    if d['age'] > 0
      d['health'] = dino_eating_correct_diet?(d) ? remaining_dino_lifespan(d) : remaining_dino_lifespan(d) / 2
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
end

def calculate_dinos_age_metrics(dinos)
  dinos.each do |d|
    if d['comment'] == 'Alive' && d['age'] > 1
        d['age_metrics'] = (d['age'] / 2).to_i
    else
      d['age_metrics'] = 0
    end
  end
end

def group_dinos_by_category(dinos)
  if dinos&.any?
    dinos.group_by { |d| d['category'] }.map do |category, dino_list|
      { category: category, count: dino_list.count }
    end
  end
end

def run(dinos)
    # Handle nil or empty input
    return { dinos: [], summary: {} } if dinos.nil? || dinos.empty?

    # Handle unknown categories
    return { dinos: dinos, summary: {} } if dinos.any? { |d| !['herbivore', 'carnivore'].include?(d['category']) }

    calculate_dinos_health(dinos)
    calculate_dinos_age_metrics(dinos)

    f = {}
    group_dinos_by_category(dinos).each do |category_metrics|
      # add [summary] to dinos return object
      f[category_metrics[:category]] = category_metrics[:count]
    end

    return { dinos: dinos, summary: f }
  end
  
  dinfo = run([
               { "name"=>"DinoA", "category"=>"herbivore", "period"=>"Cretaceous", "diet"=>"plants", "age"=>100 },
               { "name"=>"DinoB", "category"=>"carnivore", "period"=>"Jurassic", "diet"=>"meat", "age"=>80 }
             ])
  
  puts dinfo  