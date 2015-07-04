# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |i|
  Show.create title: "Show ##{i+1}",
              description: "Show ##{i+1}'s description",
              duration: 22,
              youtube_url: "https://www.youtube.com/watch?v=4GPKYLabHv0"
end
