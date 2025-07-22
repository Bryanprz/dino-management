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
      if d['age'] > 0
        if d['category'] == 'herbivore'
          d['health'] = d['diet'] == 'plants' ? (100 - d['age']) : (100 - d['age']) / 2
        else
          if d['category'] == 'carnivore'
            d['health'] = d['diet'] == 'meat' ? (100 - d['age']) : (100 - d['age']) / 2
          end
        end
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
      if d['comment'] == 'Alive'
        if d['age'] > 1
          d['age_metrics'] = (d['age'] / 2).to_i
        else
          d['age_metrics'] = 0
        end
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