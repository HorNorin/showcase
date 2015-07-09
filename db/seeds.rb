# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = []
10.times do
  user = User.new username: Faker::Name.name,
                  email: Faker::Internet.email,
                  password: "secret",
                  password_confirmation: "secret"
  user.skip_confirmation!
  user.save
  users << user
end

100.times do |i|
  show = Show.create title: "Show ##{i+1}",
              description: "Show ##{i+1}'s description",
              duration: 22,
              youtube_url: "https://www.youtube.com/watch?v=4GPKYLabHv0"
  users.each do |user|
    show.comments.create user: user, body: Faker::Lorem.sentence(3)
  end
end
