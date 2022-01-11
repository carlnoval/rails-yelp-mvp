# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def resto_only(count)
  count.times do
    Restaurant.create(
      name: Faker::Restaurant.name,
      address: Faker::Address.street_address,
      # https://stackoverflow.com/questions/2640819/extract-number-from-string-in-ruby/59238529
      phone_number: Faker::PhoneNumber.cell_phone.delete("^0-9"),
      category: ["Chinese", "Italian", "Japanese", "French", "Belgian"].sample)
  end
end

def gen_content(range)
  summary_paragraph = []
  rand(range).times do
    summary_paragraph << ( [Faker::Company.catch_phrase, Faker::Company.bs].join(" ") << "." )
  end
  summary_paragraph.join(" ")
end

def resto_w_content (count={})
  resto_only(count[:restaurant])

  Restaurant.all.each do |restaurant|
    count[:review].times do
      Review.create(rating: rand(0..5), content: gen_content(1..4), restaurant: restaurant)
    end
  end
end



resto_w_review = 2
review_count = 5
resto_wo_review = 3
puts "Cleaning database..."
Restaurant.destroy_all
puts "Database is now clean..."
puts "Creating #{resto_w_review} * Restaurant, w reviews"
resto_w_content restaurant: resto_w_review, review: review_count
puts "Creating #{resto_wo_review} * Restaurant, w/o reviews"
resto_only(resto_wo_review)
puts "Seeding finished..."
puts "Restaurant with lowest id: #{Restaurant.first.id}"
puts "Restaurant with highest id: #{Restaurant.last.id}"

