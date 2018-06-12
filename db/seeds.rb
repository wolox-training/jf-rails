# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(email: 'test@wolox.com.ar', password: '123123123', password_confirmation: '123123123', first_name: 'Test', last_name: 'TestLastName', confirmed_at: Time.zone.now)
User.create(email: 'javier.flores@wolox.cl', password: '123123123', password_confirmation: '123123123', first_name: 'Javier', last_name: 'Flores', confirmed_at: Time.zone.now)

Book.create(genre: "TestGenre", author: "TestAuthor", image: "TestImage", title: "TestTitle", publisher: "TestPublisher", year: "TestYear")
