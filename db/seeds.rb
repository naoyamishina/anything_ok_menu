# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

60.times do |n|
  User.create!(
    name: Faker::Name.unique.name,
    email: Faker::Internet.unique.email,
    password: "3150test",
    password_confirmation: "3150test"
  )
end

60.times do |index|
  Menu.create(
      user: User.offset(rand(User.count)).first,
      name: "タイトル#{index}",
      memo: "本文#{index}"
  )
end