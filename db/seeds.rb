# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
20.times do |i|
  email = "user#{i + 1}@example.com"
  next if User.exists?(email: email)
  User.create!(
    name: "User #{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "123456789",
    role: [0, 1, 2].sample
  )
end

30.times do |i|
  Asset.create!(
    title: "Asset #{i + 1}",
    description: "Description for asset #{i + 1}",
    price: rand(100..10_000),
    user_id: rand(1..20)
  )
end

